import 'package:flutter/material.dart';
import 'package:green_harbour/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Text(Provider.of<AuthServiceProvider>(context).currentUser!.email!),
      ),
    );
  }
}
