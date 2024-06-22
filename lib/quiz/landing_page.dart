import 'package:flutter/material.dart';

import 'home.dart';
class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subjects"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/landing.jpg'), // Replace with the actual image asset path
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => homepage(unit1: 'Unit 1', unit2: 'Unit 2', i: 0, unit3: 'Unit 3'),
                ));
              },
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.pink[100],
                  child: Center(
                    child: Text("English",
                      style: TextStyle(
                        fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => homepage(unit1: 'Nature', unit2: 'Living', i: 3, unit3: 'Animals'),
                ));
              },
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.blue[100],
                  child: Center(
                    child: Text("EVS",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => homepage(unit1: 'Geometry', unit2: 'Numbers', i: 6, unit3: 'Patterns',),
                ));
              },
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.green[100],
                  child: Center(
                    child: Text("Maths",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
