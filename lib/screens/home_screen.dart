// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_harbour/constants.dart';
import 'package:green_harbour/models/house_model.dart';
import 'package:green_harbour/screens/give_review_screen.dart';
import 'package:green_harbour/screens/search_screen.dart';

import 'package:green_harbour/screens/widgets/home_screen_widgets.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  var profilePic = 'asds';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                homeHeader(
                    imageUrl: '',
                    username: Provider.of<AuthServiceProvider>(context)
                        .currentUser!
                        .name!,
                    onTap: () {}),
                const SizedBox(
                  height: 15,
                ),
                searchBar(onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      'History',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Text('Hello');
              },
            ),
          )
        ],
      ),
    ));
  }
}

class HouseCard extends StatelessWidget {
  final House house;
  const HouseCard({
    super.key,
    required this.house,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Container(
        height: 170.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15), // Shadow color
              spreadRadius: 0, // Spread radius
              blurRadius: 10, // Blur radius
              offset: const Offset(0, 0), // Offset in x and y directions
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/house_icon.svg",
                      height: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'House ${house.houseNumber}',
                        style: const TextStyle(
                            color: colorBlack,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  '${house.street}, ${house.locality}, ${house.town}, ${house.postCode}',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  house.review == ''
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GiveReview(),
                              ),
                            );
                          },
                          child: const Row(
                            children: [
                              Text(
                                'Give Review',
                                style: TextStyle(
                                    color: colorBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: colorBlack,
                                size: 18,
                              )
                            ],
                          ),
                        )
                      : const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reviewed:',
                              style: TextStyle(
                                  color: colorBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Not Eligible',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                  house.energyRating == ''
                      ? const Text(
                          'No Energy Rating',
                          style: TextStyle(
                            color: colorGrey,
                            fontSize: 12,
                          ),
                        )
                      : Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  house.energyRating.toString(),
                                  style: const TextStyle(
                                      color: colorBlack,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                                SvgPicture.asset(
                                  'assets/icons/fire_icon.svg',
                                  width: 18,
                                )
                              ],
                            ),
                            const Text(
                              'Energy Rating',
                              style: TextStyle(
                                color: colorGrey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
