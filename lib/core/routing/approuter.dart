import 'package:bmi/core/routing/routes.dart';
import 'package:bmi/screens/addfood/add_food.dart';
import 'package:bmi/screens/complete_info/complete_info.dart';
import 'package:bmi/screens/food_list.dart';
import 'package:bmi/screens/home/home_screen.dart';
import 'package:bmi/screens/login.dart';
import 'package:bmi/screens/new_record/new_record.dart';
import 'package:bmi/screens/signup.dart';
import 'package:bmi/screens/splash.dart';
import 'package:flutter/material.dart';

class Approuter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.signup:
        return MaterialPageRoute(builder: (context) => Signup());
      case Routes.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case Routes.completeInfo:
        return MaterialPageRoute(builder: (context) => CompleteInfo());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case Routes.addFood:
        return MaterialPageRoute(builder: (context) => AddFood());
      case Routes.foodList:
        return MaterialPageRoute(builder: (context) => FoodList());
    }
    return null;
  }
}
