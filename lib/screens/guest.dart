// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:leadeetuto/models/user_model.dart';
import 'package:leadeetuto/screens/dashboard/home.dart';
import 'package:leadeetuto/screens/guest/auth.dart';
import 'package:leadeetuto/screens/guest/password.dart';
import 'package:leadeetuto/screens/guest/terms.dart';
import 'package:leadeetuto/screens/services/user_service.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({super.key});

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  UserService _userService = UserService();

  List<Widget> _widgets = [];
  int? _indexSelected = 0;

  String? _email;

  @override
  void initState() {
    super.initState();

    _widgets.addAll([
      AuthScreen(
        onChangedStep: (index, value) => setState(() {
          _indexSelected = index;
          _email = value;
        }),
      ),
      TermScreen(
        onChangedStep: (index) => setState(() => _indexSelected = index),
      ),
      PasswordScreen(
        onChangedStep: (index, value) => setState(() {
          if (index != null) {
            _indexSelected = index;
          }

          if (value != null) {
            _userService
                .auth(UserModel(
              email: _email,
              password: value,
            ))
                .then((value) {
              if (value.uid != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              }
            });
          }
        }),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widgets.elementAt(_indexSelected!),
    );
  }
}
