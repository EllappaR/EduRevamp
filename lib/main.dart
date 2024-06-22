import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_project1/database_services.dart';
import 'package:mini_project1/screens/aftersignin.dart';
import 'package:mini_project1/screens/home_screen.dart';
import 'package:mini_project1/screens/signin_screen.dart';
import 'package:mini_project1/helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _signedIn = false;
  bool _mentor = false;
  bool _student = false;

  @override
  void initState() {
    super.initState();
    getUserStatus();
  }

  Future<void> getUserStatus() async {
    final loggedInStatus = await HelperFunctions.getUserLoggedInStatus();
    if (loggedInStatus != null) {
      setState(() {
        _signedIn = loggedInStatus;
      });
      if (_signedIn) {
        final isMentor = await Databaseservice().getIsMentor(FirebaseAuth.instance.currentUser!.uid);
        final isStudent = await Databaseservice().getIsStudent(FirebaseAuth.instance.currentUser!.uid);
        setState(() {
          _mentor = isMentor;
          _student = isStudent;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rural Edurevamp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _signedIn
          ? (_mentor || _student) // Check if either mentor or student is true
          ? const HomeScreen()
          : AfterSignInScreen()
          : const SignInScreen(),
    );

  }
}
