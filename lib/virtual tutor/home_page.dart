import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_project1/virtual%20tutor/api_integration_widget.dart';

import '../helper.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myIndex = 0;
  String username = '';
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettinguserdata();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
    final user = FirebaseAuth.instance.currentUser!.displayName.toString();


    String userEmailString =
    FirebaseAuth.instance.currentUser!.email!.toString();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text("VIRTUAL ASSISTANT")
        ),
        body: PageView(
          controller: _pageController,
          children: [
            buildHomePage(username),
           // const Profile(),
          ],
          onPageChanged: (index) {
            setState(() {
              myIndex = index;
            });
          },
        ),

      ),
    );
  }

  Widget buildHomePage(String userEmailString) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: Text(
            "Hello $userEmailString!",
            style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Explore and Learn", // Add your subheading text here
            style: TextStyle(fontSize: 18.0, color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
        Expanded(
          child: ApiIntegrationWidget(),
        ),
      ],
    );
  }
}
