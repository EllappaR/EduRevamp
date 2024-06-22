import 'dart:async';
import 'package:flutter/material.dart';
import 'home.dart';
import 'landing_page.dart';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Landing(),
      ));
    });
  }

  // added test yourself
  // and made the text to align at center 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100]
        ),
        child: Image.asset(
          'images/start.jpg',// Replace with the actual image asset path
          fit: BoxFit.contain,
          height: double.infinity,// Adjust this as needed
        ),
      ),
    );
  }
}