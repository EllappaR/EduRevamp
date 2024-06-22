import 'package:firebase_auth/firebase_auth.dart';

import 'database_services.dart';


class AuthService{
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  //register
  Future registerUserWithEmailandPassword(String fullname,String email,String password)async {
    try{
      User user=(await firebaseauth.createUserWithEmailAndPassword(email: email, password: password)).user!;
      if(user!=null){
        await Databaseservice(uid:user.uid).updateUserData(fullname, email);
        return true;
      }
    }on FirebaseAuthException catch(e) {
      print(e.code);
      return e.message;
    }
  }
}