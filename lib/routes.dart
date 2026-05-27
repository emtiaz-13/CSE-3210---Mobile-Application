import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/logout_screen.dart';
import 'screens/search_donor_screen.dart';
import 'screens/donor_list_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String logout = '/logout';
  static const String searchDonor = '/search_donor';
  static const String donorList = '/donor_list';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const BloodDonationSplash(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignUpScreen(),
    home: (context) => const HomeScreen(),
    logout: (context) => const LogoutScreen(),
    searchDonor: (context) => const SearchDonorScreen(),
    donorList: (context) => const DonorListScreen(),
  };
}
