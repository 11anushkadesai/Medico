import 'package:flutter/material.dart';

class mydrawer extends StatelessWidget {
  const mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue[100]?.withOpacity(0.5),
    );
  }
}
