// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:green_harbour/constants.dart';
import 'package:green_harbour/models/house_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HouseProvider with ChangeNotifier {
  List<House> houses = [];

  Future<void> fetchEnergyRatings({required String postalCode}) async {
    print('Fetching Energy Ratings');
    final url = Uri.parse(
        'https://api.data.street.co.uk/street-data-api/v2/properties/areas/postcodes?fields[property]=energy_performance&postcode=$postalCode');
    final headers = {
      'Accept': 'application/json',
      'x-api-key': 'VS4IQQyyXqoVOEnWGLvbV0SXVkvbZ_tizfMmjePTXQU'
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = await json.decode(response.body);
        log(data['data'].length.toString());

        for (var i = 0; i < data['data'].length; i++) {
          //      log(data['data'][0].toString());
          //  log('------------------------------------');

          for (var j = 0; j < houses.length; j++) {
            String houseID = data['data'][i]['id'].toString();
            print('Energy House ID: ${houseID.toString()}');
            print(houses[j].houseId);
            if (houseID == houses[j].houseId) {
              if (data['data'][i]['attributes']['energy_performance']
                      .toString() !=
                  'null') {
                houses[j].energyRating = data['data'][i]['attributes']
                            ['energy_performance']['energy_efficiency']
                        ['current_rating']
                    .toString();
              }
            }
          }

          log(data['data'][i].toString());
          // log(
          //   data['data'][i]['attributes']['energy_performance'].toString(),
          // );
          // log(data['data'][i]['attributes']['energy_performance']
          //     ['energy_efficiency']
          // .toString(),);
        }

        // log(
        //   data['data'][0]['attributes']['energy_performance']
        //           ['energy_efficiency']['current_rating']
        //       .toString(),
        // );
      } else {
        log('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      log('fetchEnergyRatings Catched Error: $error');
    }
    notifyListeners();
  }

  Future<void> fetchHouses(
      {required String postalcode, required BuildContext context}) async {
    easyLoading();
    final url = Uri.parse(
        'https://api.data.street.co.uk/street-data-api/v2/properties/areas/postcodes?fields[property]=address&postcode=$postalcode');
    final headers = {
      'Accept': 'application/json',
      'x-api-key': 'VS4IQQyyXqoVOEnWGLvbV0SXVkvbZ_tizfMmjePTXQU'
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // print(data);
        //    print('-----------------------');
        houses.clear();
        for (var i = 0; i < data['data'].length; i++) {
          log(data['data'][i]['attributes']['address']['simplified_format']
              .toString());
          // log(data['data'][i]['id'].toString());
          var houseId = data['data'][i]['id'].toString();
          var house =
              data['data'][i]['attributes']['address']['simplified_format'];

          houses.add(
            House(
              houseId: houseId,
              houseNumber: house['house_number'],
              street: house['street'],
              locality: house['locality'].toString(),
              town: house['town'],
              postCode: house['postcode'],
            ),
          );
        }

        await fetchEnergyRatings(postalCode: postalcode);
        EasyLoading.dismiss();
      } else {
        log('Request failed with status: ${response.statusCode}');
        EasyLoading.dismiss();
        if (response.statusCode == 422) {
          var snackBar = SnackBar(
            content: const Text('Invalid Postal Code'),
            backgroundColor: Colors.black87,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 5),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } catch (error) {
      log('fetchHouses Catched Error: $error');
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

  Future<void> addDummyDataToFirestore() async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add multiple documents at once using a batch
      WriteBatch batch = firestore.batch();

      // Loop through each data and add it to the batch
      for (var data in houses) {
        // Generate a new document reference with an auto-generated ID
        DocumentReference docRef = firestore.collection('houses').doc();

        // Add data to the batch
        batch.set(docRef, data.toJson());
      }

      // Commit the batch
      await batch.commit();

      print('Dummy data added successfully!');
    } catch (e) {
      print('Error adding dummy data: $e');
    }
  }
}
