import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
