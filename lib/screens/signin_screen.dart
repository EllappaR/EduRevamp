import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project1/screens/reset_password.dart';
import 'package:mini_project1/screens/signup_screen.dart';

import '../helper.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'aftersignin.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  String? _errorMessage;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFCB2B93),
              Color(0xFF9546C4),
              Color(0xFF5E61F4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                Image.asset(
                  "images/logo.png", // Replace with your logo image path
                  width: 250, // Adjust the width as needed
                  height: 250, // Adjust the height as needed
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _emailTextController,
                  decoration: InputDecoration(
                    labelText: "Enter registered e-mail",
                    icon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _passwordTextController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    icon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                forgetPassword(context),
                firebaseUIButton(context, "Sign In", () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text,
                  ).then((userCredential)async {
                    // Check if the user has already completed authentication
                    // You can use a flag stored in SharedPreferences or Firestore
                    await HelperFunctions.saveUserLoggedInStatus(true);
                    await HelperFunctions.saveUserEmailSF(_emailTextController.text);
                    print("Successfully login");

                    bool hasCompletedAuthentication = false; // Replace with actual check

                    if (hasCompletedAuthentication) {
                      // User has already completed authentication, navigate to HomeScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => AfterSignInScreen()),
                      );
                    }
                  }).catchError((error) {
                    setState(() {
                      _errorMessage = "Incorrect login credentials";
                      if (error.code == 'user-not-found') {
                        _errorMessage = 'You have not created an account.';
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                        );
                      }
                    });
                  });
                }),
                signUpOption(),
                // Display error message if it exists
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
    height: 35,
    alignment: Alignment.bottomRight,
    child: TextButton(
    child: const Text(
    "Forgot Password?",
    style: TextStyle(color: Colors.white70),
    textAlign: TextAlign.right,
    ),
    onPressed: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ResetPassword()),
    ),
    ));
  }
}

