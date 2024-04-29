import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_harbour/screens/widgets/button.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/auth_provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void sendResetLink() async {
      try {
        await Provider.of<AuthServiceProvider>(context, listen: false)
            .resetPassword(email: emailController.text);
        Future.delayed(const Duration(seconds: 0), () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('A password reset link has been sent to your email.'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        });
      } on FirebaseAuthException catch (e) {
        String message = 'An error occurred, please try again later.';
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        }
        Future.delayed(const Duration(seconds: 0), () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red,
            ),
          );
        });
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  const Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.h),
                  const Text(
                    'Enter your email where the password reset link can be sent!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colorGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            TextField(
              controller: emailController,
              cursorColor: primaryGreen,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your Email',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 8.0.w),
                  child: SvgPicture.asset(
                    color: colorLightGrey,
                    'assets/icons/email.svg',
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            MyButton(
              buttonText: 'Send Reset Link',
              buttonColor: primaryGreen,
              textColor: Colors.white,
              buttonWidth: 245,
              buttonHeight: 50.h,
              onTap: () {
                FocusScope.of(context).unfocus();
                if (emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email can\'t be empty!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  sendResetLink();
                }
              },
            ),
            SizedBox(height: 15.h),
            MyButton(
              onTap: () {
                Navigator.pop(context);
              },
              buttonText: 'Back to Login',
              buttonColor: colorGrey,
              textColor: Colors.white,
              buttonWidth: 245,
              buttonHeight: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
