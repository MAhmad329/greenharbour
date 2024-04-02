import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_harbour/constants.dart';
import 'package:green_harbour/screens/widgets/button.dart';

class GiveReview extends StatefulWidget {
  const GiveReview({super.key});

  @override
  State<GiveReview> createState() => _GiveReviewState();
}

class _GiveReviewState extends State<GiveReview> {
  String selectedValue = "Cooperative Behavior";
  void onChanged(String value) {
    setState(
      () {
        selectedValue = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'House 1',
                    style: TextStyle(
                        color: colorBlack,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Text(
                  '123 Imaginary Streedsfkldjst, Fictitious City, Makebelieve County, Dreamland 56789',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'E',
                          style: TextStyle(
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
                      'Enery Rating',
                      style: TextStyle(
                        color: colorGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black.withOpacity(0.1),
                ),
                const Text(
                  'Give Review',
                  style: TextStyle(color: colorBlack, fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                DropdownButtonFormField(
                    dropdownColor: Colors.grey.shade100,
                    focusColor: primaryGreen,
                    decoration: InputDecoration(
                      focusColor: primaryGreen,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: colorLightGrey)),
                    ),
                    elevation: 0,
                    hint: const Text('Select a Review'),
                    items: <String>[
                      "Cooperative Behavior",
                      "Friendly and Helpful",
                      "Not Eligible",
                      "Poor Communication",
                      "Unprofessional Behavior",
                      "Slow Response Time",
                      "Rude and Unhelpful",
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(
                        () {
                          selectedValue = value!;
                        },
                      );
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Center(
                child: MyButton(
                    onTap: () {},
                    buttonText: 'Submit',
                    buttonColor: primaryGreen,
                    textColor: Colors.white,
                    buttonWidth: 245,
                    buttonHeight: 50.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
