import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project1/chat/chat_screen.dart';
import 'package:mini_project1/screens/home_screen.dart';
import 'package:mini_project1/screens/signin_screen.dart';
import 'package:mini_project1/screens/videos.dart';

import '../quiz/splash.dart';
import '../virtual tutor/home_page.dart';
import 'books.dart';

class elearning extends StatefulWidget {
  const elearning({super.key});

  @override
  State<elearning> createState() => _elearningState();
}

class _elearningState extends State<elearning> {
  String selectedClass = "Class 1"; // Initialize with Class 1 as the default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-learning Resources for You!"),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/landing.jpg'), // Replace with the actual image asset path
              fit: BoxFit.cover,
            ),
          ),
          width: 250, // Adjust the width as needed
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
                child: Text(
                  "Menu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text("E-Learning Resources"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const elearning()),
                  );
                  // Handle E-Learning Resources option here
                },
              ),
              ListTile(
                title: const Text("Attend Assessments"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  splashscreen()),
                  );
                  // Handle Attend Assessments option here
                },
              ),
              ListTile(
                title: const Text("Virtual Assistant"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  HomePage()),
                  );
                  // Handle Attend Assessments option here
                },
              ),
              ListTile(
                title: const Text("Return to Home Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const HomeScreen()),
                  );
                  // Handle Attend Assessments option here
                },
              ),
              ListTile(
                title: const Text("Logout"),
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Signed Out");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInScreen()),
                    );
                  });
                  // Handle Attend Assessments option here
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/landing.jpg'), // Replace with the actual image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedClass,
              onChanged: (String? newValue) {
                setState(() {
                  selectedClass = newValue!; // Update the selected class when the user selects a different one
                });
              },
              items: <String>[
                "Class 1",
                "Class 2",
                "Class 3",
                "Class 4",
                "Class 5",
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            buildClassCard(selectedClass), // Display the card for the selected class
          ],
        ),
      ),
    );
  }

  Widget buildClassCard(String className) {
    return Container(
      width: 600,
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          color: Colors.deepOrange[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                className,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const Videos();
                  }));
                  // Handle 'Books' button click for this class
                },
                child: const Text(
                  "Videos",
                  style: TextStyle(fontSize: 16), // Adjust the button font size
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjust the button padding
                ),
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const Books();
                  }));
                  // Handle 'Books' button click for this class
                },
                child: const Text(
                  "Books",
                  style: TextStyle(fontSize: 16), // Adjust the button font size
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjust the button padding
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}