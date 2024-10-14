import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visicheck/pages/Tabs.dart';
import 'package:visicheck/pages/login_or_register_page.dart';
import 'package:visicheck/pages/get_started_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    setState(() {
      _isFirstTime = isFirstTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstTime) {
      return GetStartedPage(
        onGetStarted: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isFirstTime', false);
          setState(() {
            _isFirstTime = false;
          });
        },
      );
    }

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return Tabs();
          }

          // user is not logged in
          else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
