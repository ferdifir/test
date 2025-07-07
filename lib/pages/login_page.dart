import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/api_service.dart';
import 'package:myapp/pages/location_page.dart';
import 'package:myapp/routes.dart';
import 'package:myapp/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final api = ApiService();
  bool _isPasswordVisible = false;
  bool _isValid = false;
  final emailCtrl = TextEditingController(text: 'USER@TEST.COM');
  final passwordCtrl = TextEditingController(text: '12345');

  void _loginRequest() async {
    try {
      final body = {
        "email": emailCtrl.text,
        "password": passwordCtrl.text,
        "tokenfirebase": "",
        "deviceid": "",
      };
      final res = await api.postFormData(
        endpoint: 'Master/ApiMember/login',
        data: body,
      );
      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        final data = body['data'];
        final box = Hive.box("app");
        box.put("id", data["idmemberuser"]);
        box.put("nama", data["namamemberuser"]);
        box.put("alamat", data["alamat"]);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LocationPage()),
        );
      } else {
        Utils.showSnackBar(context, 'Login Failed');
      }
    } catch (e) {
      Utils.showSnackBar(context, e.toString());
    }
  }

  void chekValidation() {
    setState(() {
      _isValid = emailCtrl.text.isNotEmpty && passwordCtrl.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          TextFormField(
            controller: emailCtrl,
            onChanged: (val) {
              chekValidation();
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: passwordCtrl,
            onChanged: (val) {
              chekValidation();
            },
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.key),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isValid ? _loginRequest : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(double.infinity, 48),
            ),
            child: Text("Login"),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.register);
            },
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}
