import 'package:flutter/material.dart';
import 'package:green_harbour/providers/auth_provider.dart';
import 'package:green_harbour/screens/home_screen.dart';
import 'package:green_harbour/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'models/user_model.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServiceProvider>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          );
        }

        final User? user = snapshot.data;
        if (user == null) {
          return const LoginScreen();
        } else {
          return HomeScreen();
        }
      },
    );
  }
}
