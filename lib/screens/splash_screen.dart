import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (!mounted) {
      return;
    }
    Navigator.pushReplacementNamed(context, 'wrapper');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add your logo or splash screen image
            Image.asset('assets/Logo.svg'),
            SizedBox(height: 20.h),
            const CircularProgressIndicator(), // Optional: Add a loading indicator
          ],
        ),
      ),
    );
  }
}
