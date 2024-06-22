import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project1/database_services.dart';

import 'home_screen.dart';

class Tutor extends StatefulWidget {
  const Tutor({Key? key}) : super(key: key);

  @override
  _TutorState createState() => _TutorState();
}

class _TutorState extends State<Tutor> {
  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String selectedState = 'Tamil Nadu'; // Initialize with a default value
  String highestQualification = '';
  bool isWorkingAsTeacher = false;
  String schoolName = '';



  // Function to save tutor details to Firestore
  Future<void> saveTutorDetails() async {

    if (_formKey.currentState!.validate()) {

      try {
        // Add the tutor's details to the 'mentor' collection in Firestore
       await Databaseservice().createMentor(firstName, lastName, selectedState, highestQualification, isWorkingAsTeacher, schoolName, FirebaseAuth.instance.currentUser!.uid).whenComplete(() =>
           Databaseservice().updateMentor(FirebaseAuth.instance.currentUser!.uid).whenComplete(() =>
           Navigator.push(context, MaterialPageRoute(builder: (context){
         return const HomeScreen();
       }))
           )
       );

      } catch (e) {
        // Handle any errors, such as network issues or Firestore permissions
        print('Error: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutor Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      firstName = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      lastName = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: selectedState,
                  items: ['Tamil Nadu', 'Other State']
                      .map((state) => DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedState = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'State',
                  ),
                  validator: (value) {
                    if (value == 'Tamil Nadu' || value == 'Other State') {
                      return null; // Valid selection
                    } else {
                      return 'Please select a state';
                    }
                  },
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      highestQualification = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Highest Qualification'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your highest qualification';
                    }
                    return null;
                  },
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Text("Are you working as a teacher?"),
                      SizedBox(width: 10),
                      Radio(
                        value: true,
                        groupValue: isWorkingAsTeacher,
                        onChanged: (value) {
                          setState(() {
                            isWorkingAsTeacher = value as bool;
                          });
                        },
                      ),
                      Text("Yes"),
                      SizedBox(width: 10),
                      Radio(
                        value: false,
                        groupValue: isWorkingAsTeacher,
                        onChanged: (value) {
                          setState(() {
                            isWorkingAsTeacher = value as bool;
                          });
                        },
                      ),
                      Text("No"),
                    ],
                  ),
                ),
                if (isWorkingAsTeacher)
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        schoolName = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Name of the School'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the school name';
                      }
                      return null;
                    },
                  ),
                ElevatedButton(
                  onPressed: () async {
                      // All fields are valid, and the form is ready to be submitted
                      // You can use the entered values here as needed
                      // For example, you can save them to a database or perform other actions.
                      // After that, you can navigate to the HomeScreen.
                    saveTutorDetails();

                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
