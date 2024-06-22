import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project1/quiz/quizpage.dart';


class homepage extends StatefulWidget {
  final String unit1;
  final String unit2;
  final String unit3;
  final int i;
  const homepage({super.key, required this.unit1, required this.unit2, required this.i, required this.unit3});
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  List<String> images = [
    "images/py.png",
    "images/java.png",
    "images/js.png",
    "images/nature.jpeg",
    "images/living.png",
    "images/animals.jpeg",
    "images/geometry.jpeg",
    "images/numbers.jpeg",
    "images/patterns.jpeg",
  ];

  List<String> des = [
    "My Pet !!",
    "Play Time !!",
    "Families !!",
    " Natures Bounty!!",
    "Living and Non-living !!",
    "Animal around us!!",
    "Basic Shapes!!",
    "Numbers upto 100!!",
    "Patterns in everything!!",
  ];

  Widget customcard(String langname, String image, String des){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(

            builder: (context) => getjson(langname: langname,),
          ));
        },
        child: Material(
          color: Colors.indigoAccent,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      // changing from 200 to 150 as to look better
                      height: 150.0,
                      width: 150.0,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    langname,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: "Quando",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    des,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontFamily: "Alike"
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ASSESSMENT",
          style: TextStyle(
            fontFamily: "Quando",
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          customcard(widget.unit1, images[widget.i], des[widget.i]),
          customcard(widget.unit2, images[widget.i + 1], des[widget.i + 1]),
          customcard(widget.unit3, images[widget.i + 2], des[widget.i + 2])
        ],
      ),
    );
  }
}

