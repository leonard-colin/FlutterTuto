// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Everyone has\n".toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                    children: [
                      TextSpan(
                        text: "knowledge\n".toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "to share.".toUpperCase(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "It all starts here.",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Enter your email"),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Ex: jane.doe@janedoe.com",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            elevation: 0,
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white),
                        onPressed: () => print("send"),
                        child: Text(
                          "continue".toUpperCase(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
