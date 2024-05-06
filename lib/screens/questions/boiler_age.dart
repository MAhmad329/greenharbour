// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_harbour/constants.dart';
import 'package:green_harbour/models/questions.dart';
import 'package:green_harbour/screens/questions/occupancy_type.dart';
import 'package:green_harbour/screens/questions/source_of_heating.dart';
import 'package:green_harbour/screens/widgets/button.dart';
import 'package:green_harbour/screens/widgets/forms_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class BoilerAde extends StatefulWidget {
  const BoilerAde({super.key});

  @override
  State<BoilerAde> createState() => _BoilerAdeState();
}

int selectedIndex = 1000;

var question = const Question(
    question: 'Is your boiler older than 15 years?',
    descripton:
        'If unsure if the boiler qualifies, please visit https://www.homeheatingguide.co.uk/efficiency-tables and check the efficiency rating is below 86%',
    options: [
      'a)  Yes',
      'b)  No',
      'c)  Not Sure',
    ],
    pickedAnswer: '');

class _BoilerAdeState extends State<BoilerAde> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checking Eligibility'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height(20),
              Text(
                '${questionNo.toString()}. ${question.question}',
                style: const TextStyle(
                    color: colorBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              height(8),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'If unsure if the boiler qualifies, please visit ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'homeheatingguide.co.uk/efficiency-tables',
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("Hello World");
                          launch(
                              'https://www.homeheatingguide.co.uk/efficiency-tables');
                        },
                    ),
                    const TextSpan(
                      text: ' and check the efficiency rating is below 86%',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              height(24),
              Expanded(
                child: ListView.builder(
                  itemCount: question.options.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          height: 74,
                          width: 1.sw,
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? Colors.green
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    question.options[index],
                                    style: TextStyle(
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Center(
                  child: selectedIndex == 1000
                      ? MyButton(
                          onTap: () {},
                          buttonText: 'Next',
                          buttonColor: colorGrey,
                          textColor: Colors.white,
                          buttonWidth: 245,
                          buttonHeight: 50.h)
                      : MyButton(
                          onTap: () {
                            if (selectedIndex == 2) {
                            } else {
                              questionNo++;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SourceOfHeating()));
                            }
                          },
                          buttonText: 'Next',
                          buttonColor: primaryGreen,
                          textColor: Colors.white,
                          buttonWidth: 245,
                          buttonHeight: 50.h),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
