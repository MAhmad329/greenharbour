import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_harbour/models/questions.dart';

const primaryGreen = Color(0xFF1F4343);
const colorBlack = Color(0xFF01042D);
const colorGrey = Color(0xFF8E8E93);
const colorLightGrey = Color(0xFFCCCDD5);

InputDecoration kTextFieldDecoration = InputDecoration(
  hintText: 'hint',
  hintStyle: const TextStyle(fontSize: 14, color: colorLightGrey),
  contentPadding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 16.0.w),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0.r),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorLightGrey, width: 1.0.w),
    borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primaryGreen, width: 2.0.w),
    borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
  ),
);

void easyLoading() {
  EasyLoading.show(
    indicator: const CircularProgressIndicator(
      backgroundColor: primaryGreen,
      color: Colors.teal,
    ),
    maskType: EasyLoadingMaskType.none,
    dismissOnTap: true,
  );
}

const List<Question> questions = [
  Question(
      question: 'What is your occupancy type?',
      options: [
        'a) Homeowner',
        'b) Private Tanant',
        'c) Social Tentant',
        'd) Other',
      ],
      pickedAnswer: ''),
  Question(
      question: 'What is your main source of heating?',
      options: [
        'a) Gas',
        'b) Electricity',
        'c) Oil',
        'd) Not Sure',
      ],
      pickedAnswer: ''),
  Question(
      question: 'Has your property got central heating?',
      options: [
        'a) Yes',
        'b) No',
      ],
      pickedAnswer: ''),
  Question(
      question: 'What type of property do you live in?',
      options: [
        'a) Detached House',
        'b) Semi-Detached House',
        'c) Terraced House',
        'd) Flat/Apartment',
        'E) Bungalow',
        'F) Other',
      ],
      pickedAnswer: ''),
  Question(
      question:
          'Is your boiler older than 15 years If unsure if the boiler qualifies, please visit https://www.homeheatingguide.co.uk/efficiency-tables and check the efficiency rating is below 86%',
      options: [
        'a) Detached House',
        'b) Semi-Detached House',
        'c) Terraced House',
        'd) Flat/Apartment',
        'E) Bungalow',
        'F) Other',
      ],
      pickedAnswer: ''),
  Question(
      question:
          'Does anyone living at the property claim any UK qualified benefits?',
      descripton:
          '(This could include Pension Credit, Child benefits, Working Tax Credits, income support etc.)',
      options: [
        'a) Yes',
        'b) No',
      ],
      pickedAnswer: ''),
];
