import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_harbour/providers/auth_provider.dart';
import 'package:green_harbour/providers/houses_provider.dart';
import 'package:green_harbour/providers/password_visibility_provider.dart';
import 'package:green_harbour/screens/home_screen.dart';
import 'package:green_harbour/screens/login_screen.dart';
import 'package:green_harbour/screens/signup_screen.dart';
import 'package:green_harbour/wrapper.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthServiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HouseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PasswordVisibilityProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          builder: EasyLoading.init(),
          theme: ThemeData(
              textTheme: GoogleFonts.interTextTheme(),
              appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
              scaffoldBackgroundColor: Colors.white),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const Wrapper(),
            'login_screen': (context) => const LoginScreen(),
            'home_screen': (context) => HomeScreen(),
            'signup_screen': (context) => const SignupScreen(),
          },
        );
      },
    );
  }
}
