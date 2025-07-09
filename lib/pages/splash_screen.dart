import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = Hive.box("app");

  void _isLoggedIn() {
    Future.delayed(const Duration(seconds: 2), () {
      final String id = box.get("id", defaultValue: "");
      if (id.isNotEmpty) {
        final String idperusahaan = box.get("idperusahaan", defaultValue: "");
        final String idcabang = box.get("idcabang", defaultValue: "");
        if (idperusahaan.isNotEmpty && idcabang.isNotEmpty) {
          Navigator.pushReplacementNamed(context, Routes.dashboard);
        } else {
          Navigator.pushReplacementNamed(context, Routes.location);
        }
      } else {
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Test Coding",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
