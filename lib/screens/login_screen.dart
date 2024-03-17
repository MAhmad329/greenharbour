import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_harbour/constants.dart';
import 'package:provider/provider.dart';

import '../providers/password_visibility_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.0.w),
          child: Column(
            children: [
              SizedBox(
                height: 140.h,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                          fontSize: 28.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Use your credentials below and login to your account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: colorGrey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 90.h,
              ),
              Column(
                children: [
                  TextField(
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                    controller: emailController,
                    cursorColor: primaryGreen,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 8.0.w),
                        child: Transform.scale(
                          alignment: Alignment.center,
                          scale: 0.5
                              .r, // Adjust the scale factor to reduce the size
                          child: SvgPicture.asset(
                            'assets/icons/email.svg',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Consumer<PasswordVisibilityProvider>(
                    builder: (context, provider, child) {
                      return TextFormField(
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                        controller: passwordController,
                        cursorColor: primaryGreen,
                        obscureText: provider.isObscure,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Password',
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 8.0.w),
                            child: Transform.scale(
                              alignment: Alignment.center,
                              scale: 0.5
                                  .r, // Adjust the scale factor to reduce the size
                              child: SvgPicture.asset(
                                'assets/icons/lock.svg',
                              ),
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 8.0.w),
                            child: IconButton(
                              splashColor: Colors.transparent,
                              color: Colors.grey.shade500,
                              icon: Icon(
                                color: primaryGreen,
                                size: 20.r,
                                provider.isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                provider.toggleVisibility();
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
