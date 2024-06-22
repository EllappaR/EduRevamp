import 'package:flutter/material.dart';
import 'package:mini_project1/database_services.dart';
import 'package:mini_project1/screens/tutor.dart';

import 'authentication.dart';


class AfterSignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Your Role"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the student image and button
            Column(
              children: [
                Image.asset(
                  'images/student_image.png', // Replace with your student image
                  width: 200, // Adjust the width as needed
                  height: 200, // Adjust the height as needed
                ),
                ElevatedButton(
                  onPressed: () {
                    // Student role selected

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AuthenticationScreen()),
                    );
                  },
                  child: Text("I'm a Student"),
                ),
              ],
            ),
            SizedBox(height: 20), // Add spacing between student and mentor
            // Display the mentor image and button
            Column(
              children: [
                Image.asset(
                  'images/mentor_image.png', // Replace with your mentor image
                  width: 200, // Adjust the width as needed
                  height: 200, // Adjust the height as needed
                ),
                ElevatedButton(
                  onPressed: () {
                    // Mentor role selected
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Tutor()),
                    );
                  },
                  child: Text("I'm a Mentor"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
