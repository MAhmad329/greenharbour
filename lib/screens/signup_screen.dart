import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_harbour/screens/widgets/button.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/auth_provider.dart';
import '../providers/password_visibility_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Future<void> signup() async {
    try {
      var user = await Provider.of<AuthServiceProvider>(context, listen: false)
          .createUserWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
        nameController.text.trim(),
      );
      if (!mounted) return;
      if (user != null) {
        Navigator.pushReplacementNamed(context, 'login_screen');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to sign up: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
                      const Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Text(
                        'Create your new account',
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
                  height: 44.h,
                ),
                Column(
                  children: [
                    TextField(
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      controller: nameController,
                      cursorColor: primaryGreen,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter Your Full Name',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 8.0.w),
                          child: SvgPicture.asset(
                            'assets/icons/user.svg',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    TextField(
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      controller: emailController,
                      cursorColor: primaryGreen,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email',
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
                    SizedBox(
                      height: 15.h,
                    ),
                    Consumer<PasswordVisibilityProvider>(
                      builder: (context, provider, child) {
                        return TextField(
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          controller: confirmPasswordController,
                          cursorColor: primaryGreen,
                          obscureText: provider.isObscure,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Confirm Password',
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
                  height: 45.h,
                ),
                MyButton(
                    onTap: () {
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Passwords do not match'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (nameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in all the fields!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        signup();
                      }
                    },
                    buttonText: 'Create Account',
                    buttonColor: primaryGreen,
                    textColor: Colors.white,
                    buttonWidth: 245,
                    buttonHeight: 50.h),
                SizedBox(
                  height: 90.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, 'login_screen');
                      },
                      child: const Text(
                        'Login',
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
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
