import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project1/database_services.dart';

import 'home_screen.dart';
// Import the home.dart file

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  String? _selectedGender;
  String? _selectedGrade;
  String? _selectedState;
  DateTime? _selectedDate;


  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  late final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> grades = ['1st Grade', 'other grade'];
  final List<String> states = ['Tamil Nadu', 'other state'];


  Future<void> saveStudentDetails() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Add the tutor's details to the 'mentor' collection in Firestore
        await Databaseservice().createStudent(_firstNameController.text, _lastNameController.text, _mobileNumberController.text, _selectedGender!, _selectedDate, _selectedGrade!, _selectedState!, FirebaseAuth.instance.currentUser!.uid).whenComplete(() {
          print("Student details saved successfully."); // Add this line
          Databaseservice().updateStudent(FirebaseAuth.instance.currentUser!.uid).whenComplete(() {
            print("Student data updated."); // Add this line
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              print("Navigating to HomeScreen."); // Add this line
              return const HomeScreen();
            }));
          });
        });
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
        title: const Text('Welcome Student'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Assign the form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _mobileNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Mobile Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text('Gender'),
              Row(
                children: genders.map((gender) {
                  return Row(
                    children: [
                      Radio<String>(
                        value: gender,
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                      Text(gender),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),

              const Text('Date of Birth'),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding: const EdgeInsets.all(8.0), // Adjust the padding here
                  child: Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : '${_selectedDate!.toLocal()}'.split(' ')[0],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedGrade,
                onChanged: (value) {
                  setState(() {
                    _selectedGrade = value;
                  });
                },
                items: grades.map((grade) {
                  return DropdownMenuItem<String>(
                    value: grade,
                    child: Text(grade),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Grade'),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedState,
                onChanged: (value) {
                  setState(() {
                    _selectedState = value;
                  });
                },
                items: states.map((state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'State'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {

                    // Handle form submission here
                    // You can access the entered data using _firstNameController.text, _lastNameController.text, etc.

                    // Navigate to the Home screen on button press
                    saveStudentDetails();

                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    if (picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }
}
