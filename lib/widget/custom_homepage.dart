import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medico/screen/admin_screen.dart';
import 'package:medico/screen/welcome_screen.dart';
import 'package:medico/widget/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';


class CustomHomepage extends StatelessWidget {
  final String title;
  CustomHomepage({super.key, this.child, required this.title});
  final Widget? child ;

  @override
  Widget build(BuildContext context) {
    Future<void> logoutUser() async {
      try {
        await FirebaseAuth.instance.signOut();

        // Clear stored email from SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('userEmail');
        // Navigate back to the login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const welcomescreen()),
        );
      } catch (e) {
        print('Logout error: $e');
        // Display an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to logout. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer:
      const mydrawer(),
      appBar: title != null ? AppBar(

        iconTheme: const IconThemeData(color: Colors.white),

        title:  Text(title,
          style: const TextStyle(color: Colors.white,fontSize: 20.0,
              fontWeight: FontWeight.w500),),
        backgroundColor: Colors.blue[600],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logoutUser,
          ),
        ],
      ) : null, // If title is null, AppBar won't be sho\
      body: Stack(
        children: [
          SafeArea(child: child!)
        ],
      ),
    );
  }
}

