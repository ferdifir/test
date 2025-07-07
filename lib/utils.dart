import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
