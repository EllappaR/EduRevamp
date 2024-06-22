import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project1/quiz/splash.dart';
import 'package:mini_project1/screens/signin_screen.dart';
import 'package:mini_project1/virtual%20tutor/home_page.dart';

import '../chat/chat_screen.dart';
import '../helper.dart';
import 'elearning.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User? _user; // Store the signed-in user
  String username ="";
  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;// Fetch the signed-in user
    gettinguserdata();
  }


  gettinguserdata()async{

    await HelperFunctions.getUserNameFromSF().then((value) {
      setState(() {
        username = value!;
 });
  });
 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/landing.jpg'), // Replace with the actual image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hi, ${username} ", // Display the username or 'User' if it's null
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "Welcome to Rural EduRevamp", // Display the username or 'User' if it's null
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
              const SizedBox(height: 20), // Add some spacing
              Image.asset(
                "images/logo.png", // Replace with your logo image path
                width: 150, // Adjust the width as needed
                height: 150, // Adjust the height as needed
              ),
              Text(
                "Explore knowledge and grow your learning", // Display the username or 'User' if it's null
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
