// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:leadeetuto/screens/guest.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leadee',
      home: GuestScreen(),
    );
  }
}
