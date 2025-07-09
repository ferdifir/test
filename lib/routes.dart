import 'package:flutter/material.dart';
import 'package:myapp/pages/dashboard_page.dart';
import 'package:myapp/pages/location_page.dart';
import 'package:myapp/pages/login_page.dart';
import 'package:myapp/pages/register_page.dart';

class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String location = '/location';
  static const String dashboard = "/dashboard";

  static Map<String, WidgetBuilder> route = {
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    location: (context) => const LocationPage(),
    dashboard: (context) => const DashboardPage(),
  };
}
