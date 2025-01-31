import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medico/screen/admin_screen.dart';
import 'package:medico/screen/user_homepage.dart';
import 'package:medico/screen/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 100.0,
          height: 100.0,
        ),
      ),
    );
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('userEmail') ?? '';

    // Delay navigation to show the splash screen for a short duration
    Timer(Duration(seconds: 2), () {
      if (userEmail.isNotEmpty) {
        if (userEmail == 'desaianushka945@gmail.com') {
          _navigateToAdminHomePage();
        } else {
          _navigateToUserHomePage();
        }
      } else {
        // If not logged in, navigate to the welcome screen
        _navigateToWelcomeScreen();
      }
    });
  }

  void _navigateToAdminHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => adminhomepage()),
    ).catchError((error) => print("Error navigating to AdminHomePage: $error"));
  }

  void _navigateToUserHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => userhomepage()),
    ).catchError((error) => print("Error navigating to UserHomePage: $error"));
  }

  void _navigateToWelcomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => welcomescreen()),
    ).catchError((error) => print("Error navigating to WelcomeScreen: $error"));
  }

}
