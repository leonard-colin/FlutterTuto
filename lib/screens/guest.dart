// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:leadeetuto/models/user_model.dart';
import 'package:leadeetuto/screens/dashboard/home.dart';
import 'package:leadeetuto/screens/guest/auth.dart';
import 'package:leadeetuto/screens/guest/password.dart';
import 'package:leadeetuto/screens/guest/terms.dart';
import 'package:leadeetuto/screens/services/common_service.dart';
import 'package:leadeetuto/screens/services/user_service.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({super.key});

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  CommonService _commonService = CommonService();
  UserService _userService = UserService();

  List<Widget> _widgets = [];
  int? _indexSelected = 0;

  String? _email;

  @override
  void initState() {
    super.initState();

    AuthScreen authScreen = AuthScreen(
      onChangedStep: (index, value) async {
        StateRegistration stateRegistration =
            await _userService.mailingList(value);

        setState(
          () {
            _indexSelected = index;
            _email = value;

            if (stateRegistration == StateRegistration.COMPLETE) {
              _indexSelected = _widgets.length - 1;
            }
          },
        );
      },
    );

    PasswordScreen passwordScreen = PasswordScreen(
      onChangedStep: (index, value) async {
        UserModel connectedUserModel = await _userService.auth(
          UserModel(
            email: _email,
            password: value,
          ),
        );
        setState(() {
          if (index != null) {
            _indexSelected = index;
          }

          if (connectedUserModel.uid != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          }
        });
      },
    );

    _commonService.terms.then(
      (terms) => setState(
        () => _widgets.addAll(
          [
            authScreen,
            TermScreen(
              terms: terms,
              onChangedStep: (index) => setState(() => _indexSelected = index),
            ),
            passwordScreen,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widgets.isEmpty
          ? SafeArea(
              child: Scaffold(
                body: Center(
                  child: Text("Loading..."),
                ),
              ),
            )
          : _widgets.elementAt(_indexSelected!),
    );
  }
}
