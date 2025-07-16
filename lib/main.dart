import 'package:bmi/core/routing/approuter.dart';
import 'package:bmi/firebase_options.dart';
import 'package:bmi/screens/complete_info/complete_info.dart';
import 'package:bmi/screens/home/home_screen.dart';
import 'package:bmi/screens/login.dart';
import 'package:bmi/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  BindingBase.debugZoneErrorsAreFatal = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Ensure errors are fatal in debug mode
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Adjust the design size as needed
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BMI Calculator',
          theme: ThemeData(primarySwatch: Colors.blue),
          onGenerateRoute: Approuter().onGenerateRoute,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              if (!snapshot.hasData) {
                return LoginScreen();
              }
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                final bool isNewUser =
                    user.metadata.creationTime!
                        .difference(user.metadata.lastSignInTime!)
                        .inDays <
                    5;
                if (isNewUser) {
                  return CompleteInfo();
                }
              }
              return HomeScreen();
            },
          ),
        );
      },
    );
  }
}
