// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:leadeetuto/screens/guest.dart';
import 'package:leadeetuto/screens/services/user_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
            ),
            onPressed: () async {
              await _userService.logout();

              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => GuestScreen()),
                (route) => false,
              );
            },
            child: Text("Logout"),
          ),
        ),
      ),
    );
  }
}
