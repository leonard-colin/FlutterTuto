// ignore_for_file: prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:leadeetuto/screens/camera.dart';
import 'package:leadeetuto/screens/dashboard/home.dart';
import 'package:leadeetuto/screens/guest.dart';
import 'package:leadeetuto/screens/services/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final List<CameraDescription> cameras = await availableCameras();

  await Firebase.initializeApp();

  runApp(App(
    cameras: cameras,
  ));
}

class App extends StatelessWidget {
  UserService _userService = UserService();
  final List<CameraDescription> cameras;

  App({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leadee',
      home: CameraScreen(
        cameras: cameras,
      ),

      // StreamBuilder(
      //   stream: _userService.user,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.active) {
      //       if (snapshot.hasData) {
      //         return HomeScreen();
      //       }

      //       return GuestScreen();
      //     }

      //     return SafeArea(
      //       child: Scaffold(
      //         body: Center(
      //           child: Text("Loading..."),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
