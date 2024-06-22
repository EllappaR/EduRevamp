import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project1/helper.dart';
import 'package:mini_project1/screens/aftersignin.dart';
import 'package:mini_project1/screens/authentication.dart';
import '../auth.dart';
import '../database_services.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  AuthService authService = AuthService();
  String fullname ="";
  String emailid ="";
  String pass ="";
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;


  void register() async {

    await authService.registerUserWithEmailandPassword(fullname,emailid,pass).
    then((value)async{
      if(value == true){
        Navigator.push(context, MaterialPageRoute(builder:(context){
          return HomeScreen();
        }));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("CB2B93"),
                hexStringToColor("9546C4"),
                hexStringToColor("5E61F4")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter UserName", Icons.person_outline, false,
                        _userNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Email Id", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outlined, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "Sign Up", () async {
                      User user=(await firebaseauth.createUserWithEmailAndPassword(email: _emailTextController.text, password: _passwordTextController.text)).user!;
                      if(user!=null){
                      await Databaseservice(uid:user.uid).updateUserData(_userNameTextController.text, _emailTextController.text);
                      await HelperFunctions.saveUserLoggedInStatus(true);
                      await HelperFunctions.saveUserEmailSF(_emailTextController.text);
                      await HelperFunctions.saveUserNameSF(_userNameTextController.text) ;
                      print(user.uid);
                      print("Successfully register");
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return AfterSignInScreen();
                      }));
                    })
                  ],
                ),
              ))),
    );
  }
}