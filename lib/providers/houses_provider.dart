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
  List<House> myReviewedHouses = [];

  Future<void> searchHouses(
      {required String postalCode, required BuildContext context}) async {
    try {
      bool isDataFoundInFirebase =
          await getHousesFromFirebase(postalCode: postalCode);

      if (isDataFoundInFirebase == false) {
        fetchHouses(postalcode: postalCode, context: context);
      }
    } catch (error) {
      log('searchHouses Catched Error: $error');
    }
  }

  Future<void> fetchEnergyRatings({required String postalCode}) async {
    log('Fetching Energy Ratings');
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
        //  log(data['data'].length.toString());

        for (var i = 0; i < data['data'].length; i++) {
          //      log(data['data'][0].toString());
          //  log('------------------------------------');

          for (var j = 0; j < houses.length; j++) {
            String houseID = data['data'][i]['id'].toString();
            //  print('Energy House ID: ${houseID.toString()}');
            //  print(houses[j].houseId);
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

          // log(data['data'][i].toString());
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
          // log(data['data'][i]['attributes']['address']['simplified_format']
          //     .toString());
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
              postCode: house['postcode'].replaceAll(' ', ''),
            ),
          );
        }

        await fetchEnergyRatings(postalCode: postalcode);
        log('Got Data from API');
        addHousesToFirestore();
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

  Future<void> addHousesToFirestore() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      WriteBatch batch = firestore.batch();

      for (int index = 0; index < houses.length; index++) {
        var house = houses[index];
        var houseRef = firestore.collection('houses');

        // Add a document to the "postalCode" subcollection with the name of the postal code
        DocumentReference postalCodeDocRef = houseRef.doc(house.houseId);
        batch.set(postalCodeDocRef, house.toJson());
      }

      await batch.commit();

      log('Houses added successfully!');
    } catch (e) {
      log('Error adding Houses to Firebase: $e');
    }
  }

  Future<bool> getHousesFromFirebase({required String postalCode}) async {
    bool isDataFound = false;
    easyLoading();
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot querySnapshot = await firestore
          .collection('houses')
          .where('postCode', isEqualTo: postalCode)
          .get();

      if (querySnapshot.docs.isEmpty) {
        log('No houses found for the postalcode: $postalCode in Firebase');
      } else {
        houses.clear();
        houses.addAll(
          querySnapshot.docs
              .map(
                (doc) => House.fromJson(doc.data() as Map<String, dynamic>),
              )
              .toList(),
        );
        log('Got Data From Firebase');
        isDataFound = true;
        EasyLoading.dismiss();
        notifyListeners();
      }
    } catch (e) {
      log('Error retrieving houses: $e');
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
    return isDataFound;
  }

  Future<void> updateHouseReview(
    House house,
    String review,
  ) async {
    easyLoading();
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var reviewerId = FirebaseAuth.instance.currentUser!.uid;

      // Reference the house document within the specified postal code
      DocumentReference houseDocRef =
          firestore.collection('houses').doc(house.houseId);

      // Update the fields
      await houseDocRef.update({
        'review': review,
        'reviewerId': reviewerId,
      });
      EasyLoading.dismiss();

      log('House review updated successfully!');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error updating house review: $e');
    }
  }

  Future<void> getMyReviewedHouses() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String userId = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot querySnapshot = await firestore
          .collection('houses')
          .where('reviewerId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        log('No houses found');
      } else {
        myReviewedHouses.clear();
        myReviewedHouses.addAll(
          querySnapshot.docs
              .map(
                (doc) => House.fromJson(doc.data() as Map<String, dynamic>),
              )
              .toList(),
        );
        log('Fetched myReviewed Houses Successfully');

        EasyLoading.dismiss();
        notifyListeners();
      }
    } catch (e) {
      log('Error retrieving reviewed houses: $e');
    }
  }
}

class Backup {
//  Future<void> addHousesToFirestore() async {
//     try {
//       FirebaseFirestore firestore = FirebaseFirestore.instance;
//       WriteBatch batch = firestore.batch();

//       for (int index = 0; index < houses.length; index++) {
//         var house = houses[index];
//         DocumentReference postalCodeRef =
//             firestore.collection('postalcodes').doc(house.postCode);

//         CollectionReference houseCollectionRef =
//             postalCodeRef.collection(house.postCode);

//         // Add a document to the "postalCode" subcollection with the name of the postal code
//         DocumentReference postalCodeDocRef =
//             houseCollectionRef.doc(house.houseId);
//         batch.set(postalCodeDocRef, house.toJson());
//       }

//       await batch.commit();

//       log('Houses added successfully!');
//     } catch (e) {
//       log('Error adding Houses to Firebase: $e');
//     }
//   }

  // Future<bool> getHousesFromFirebase({required String postalCode}) async {
  //   bool isDataFound = false;
  //   easyLoading();
  //   try {
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;

  //     QuerySnapshot querySnapshot = await firestore
  //         .collection('postalcodes')
  //         .doc(postalCode)
  //         .collection(postalCode)
  //         .get();

  //     if (querySnapshot.docs.isEmpty) {
  //       log('No houses found for the postalcode: $postalCode in Firebase');
  //     } else {
  //       houses.clear();
  //       houses.addAll(
  //         querySnapshot.docs
  //             .map(
  //               (doc) => House.fromJson(doc.data() as Map<String, dynamic>),
  //             )
  //             .toList(),
  //       );
  //       log('Got Data From Firebase');
  //       isDataFound = true;
  //       EasyLoading.dismiss();
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     log('Error retrieving houses: $e');
  //     EasyLoading.dismiss();
  //   }
  //   EasyLoading.dismiss();
  //   return isDataFound;
  // }

  Future<void> updateHouseReview(
    House house,
    String review,
  ) async {
    easyLoading();
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var reviewerId = FirebaseAuth.instance.currentUser!.uid;

      // Reference the house document within the specified postal code
      DocumentReference houseDocRef = firestore
          .collection('postalcodes')
          .doc(house.postCode)
          .collection(house.postCode)
          .doc(house.houseId);

      // Update the fields
      await houseDocRef.update({
        'review': review,
        'reviewerId': reviewerId,
      });
      EasyLoading.dismiss();

      log('House review updated successfully!');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error updating house review: $e');
    }
  }
}
