import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_harbour/constants.dart';
import 'package:green_harbour/screens/widgets/button.dart';
import 'package:provider/provider.dart';

import '../providers/email_verification_provider.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<EmailVerificationProvider>(context, listen: false)
        .startEmailVerificationCheck(() {
      if (mounted) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Your Email'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please verify your email to continue',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20.h),
            Consumer<EmailVerificationProvider>(
              builder: (context, provider, _) {
                return MyButton(
                  onTap: provider.secondsRemaining <= 0
                      ? () {
                          provider.sendVerificationEmail();
                        }
                      : null,
                  buttonColor: provider.secondsRemaining <= 0
                      ? primaryGreen
                      : Colors
                          .grey, // Change color to grey when timer is counting down
                  buttonWidth: 300.w,
                  buttonHeight: 45.h,
                  textColor: Colors.white,
                  buttonText: provider.secondsRemaining <= 0
                      ? 'Send Verification Email Again'
                      : 'Wait ${provider.secondsRemaining} seconds',
                );
              },
            ),
            SizedBox(height: 20),
            MyButton(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              buttonColor: primaryGreen,
              buttonWidth: 150.w,
              buttonHeight: 45.h,
              textColor: Colors.white,
              buttonText: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}
