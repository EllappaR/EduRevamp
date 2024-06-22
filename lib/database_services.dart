import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Databaseservice {
  final String? uid;

  Databaseservice({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection("user");
  final CollectionReference mentorCollection = FirebaseFirestore.instance.collection("mentor");
  final CollectionReference studentCollection = FirebaseFirestore.instance.collection("student");


  // create user collection
  Future updateUserData(String fullname, String email) async {
    return await userCollection.doc(uid).set({
      "fullname": fullname,
      "email": email,
      "uid": uid,
      "StaffNames": [],
      "isMentor":false,
      "isStudent":false,
    }
    );
  }

  Future gettingUserdata(String email) async {
    QuerySnapshot snapshot = await userCollection.where(
        "email", isEqualTo: email).get();
    return snapshot;
  }



  //create mentor
  Future<void> createMentor(
      String firstName ,
      String lastName,
      String selectedState,// Initialize with a default value
      String highestQualification,
      bool isWorkingAsTeacher,
      String schoolName,
      String uid,
      )async{


    try{
      DocumentReference mentorDocumentReference = await mentorCollection.add({
        "MentorId": "",
        "Userid": uid,
        'firstName': firstName,
        'lastName': lastName,
        'state': selectedState,
        'highestQualification': highestQualification,
        'isWorkingAsTeacher': isWorkingAsTeacher,
        'schoolName': isWorkingAsTeacher ? schoolName : null,
      }
      );
      await mentorDocumentReference.update({
        "MentorId": mentorDocumentReference.id,
      });
      print(uid);
    } catch(e){
      if (kDebugMode) {
        print("Error in creating mentor collection: $e");
      }
    }

  }
// update isMentor

  Future updateMentor(String uid) async {
    print(uid);
    return await userCollection.doc(uid).update({
      "isMentor": true,
    });
  }

  // update isStudent

  Future updateStudent(String uid) async {
    print(uid);
    return await userCollection.doc(uid).update({
      "isStudent": true,
    });
  }
// fetch is mentor and student
  Future<bool> getIsMentor(String uid) async {
    // Assuming you have the Firestore collection and uid defined.
    DocumentSnapshot doc = await userCollection.doc(uid).get();

    if (doc.exists) {
      // Check if the document exists
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        bool isMentor = data['isMentor'] as bool? ?? false;
        return isMentor;
      } else {
        // Handle the case where data is null
        return false;
      }
    } else {
      // Handle the case where the document doesn't exist
      return false;
    }
  }
  Future<bool> getIsStudent(String uid) async {
    DocumentSnapshot doc = await userCollection.doc(uid).get();

    if (doc.exists) {
      // Check if the document exists
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        bool isStudent = data['isStudent'] as bool? ?? false;
        return isStudent;
      } else {
        // Handle the case where data is null
        return false;
      }
    } else {
      // Handle the case where the document doesn't exist
      return false;
    }
  }

  // create the student collection
  Future<void> createStudent(
      String firstName,
      String lastName,
      String mobileNumber,
      String gender,
      DateTime? selectedDate,
      String selectedGrade,
      String selectedState,
      String uid,
      ) async {


    try {
      DocumentReference studentDocumentReference = await studentCollection.add({
        "StudentId": "",
        "Userid": uid,
        'firstName': firstName,
        'lastName': lastName,
        'mobileNumber': mobileNumber,
        'gender': gender,
        'dob': selectedDate,
        'grade': selectedGrade,
        'state': selectedState,
      });

      await studentDocumentReference.update({
        "StudentId": studentDocumentReference.id,
      });
      print(uid);
    } catch (e) {
      if (kDebugMode) {
        print("Error in creating student collection: $e");
      }
    }
  }


}