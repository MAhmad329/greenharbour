// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_harbour/constants.dart';
import 'package:green_harbour/providers/auth_provider.dart';
import 'package:green_harbour/screens/widgets/button.dart';
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

  Future<void> login() async {
    try {
      var user = await Provider.of<AuthServiceProvider>(context, listen: false)
          .signInWithEmailAndPassword(
              emailController.text, passwordController.text);
      if (!mounted) return;
      if (user != null) {
        Navigator.pushReplacementNamed(context, 'home_screen');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login failed, please check your credentials"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to sign in: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Text(
                        'Use your credentials below and login to your account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: colorGrey,
                            fontSize: 14,
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
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
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
                    SizedBox(
                      height: 15.h,
                    ),
                    Consumer<PasswordVisibilityProvider>(
                      builder: (context, provider, child) {
                        return TextField(
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          controller: passwordController,
                          cursorColor: primaryGreen,
                          obscureText: provider.isObscure,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter Your Password',
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 8.0.w),
                              child: SvgPicture.asset(
                                'assets/icons/lock.svg',
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 8.0.w),
                              child: IconButton(
                                splashColor: Colors.transparent,
                                color: Colors.grey.shade500,
                                icon: Icon(
                                  color: primaryGreen,
                                  size: 24.r,
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
                ),
                SizedBox(
                  height: 26.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                MyButton(
                    onTap: () {
                      login();
                    },
                    buttonText: 'Log into your account',
                    buttonColor: primaryGreen,
                    textColor: Colors.white,
                    buttonWidth: 245,
                    buttonHeight: 50.h),
                SizedBox(
                  height: 150.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, 'signup_screen');
                      },
                      child: const Text(
                        'Sign up here',
                        style: TextStyle(
                            fontSize: 13,
                            color: primaryGreen,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
