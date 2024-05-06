import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_harbour/constants.dart';
import 'package:green_harbour/models/questions.dart';
import 'package:green_harbour/screens/questions/central_heating.dart';
import 'package:green_harbour/screens/questions/occupancy_type.dart';
import 'package:green_harbour/screens/widgets/button.dart';
import 'package:green_harbour/screens/widgets/forms_widgets.dart';

class SourceOfHeating extends StatefulWidget {
  const SourceOfHeating({super.key});

  @override
  State<SourceOfHeating> createState() => _SourceOfHeatingState();
}

int selectedIndex = 1000;

var question = const Question(
    question: 'What is your main source of heating?',
    options: [
      'a) Gas',
      'b) Electricity',
      'c) Oil',
      'd) Not Sure',
    ],
    pickedAnswer: '');

class _SourceOfHeatingState extends State<SourceOfHeating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              questionNo--;
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
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
                '${(questionNo).toString()}. ${question.question}',
                style: const TextStyle(
                    color: colorBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
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
                            if (selectedIndex == 0) {
                              questionNo++;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CentralHeating()));
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
