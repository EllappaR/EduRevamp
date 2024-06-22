import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project1/quiz/resultpage.dart';


class getjson extends StatelessWidget {
  // accept the langname as a parameter

  late String langname;
  getjson({super.key, required this.langname});
  late String assettoload;


  // a function
  // sets the asset to a particular JSON file
  // and opens the JSON
  setasset() {
    if (langname == "Unit 1") {
      assettoload = "assets/unit1.json";
    } else if (langname == "Unit 2") {
      assettoload = "assets/unit2.json";
    } else if (langname == "Unit 3") {
      assettoload = "assets/unit3.json";
    } else if (langname == "Living") {
      assettoload = "assets/Living.json";
    } else if (langname == "Nature") {
      assettoload = "assets/nature.json";
    }else if (langname == "Animals") {
      assettoload = "assets/animals.json";
    } else if (langname == "Numbers") {
      assettoload = "assets/Numbers.json";
    } else if (langname == "Geometry") {
      assettoload = "assets/Geometry.json";
    }else if (langname == "Patterns") {
      assettoload = "assets/Patterns.json";
    }
  }


  @override
  Widget build(BuildContext context) {
    // this function is called before the build so that
    // the string assettoload is avialable to the DefaultAssetBuilder
    setasset();
    // and now we return the FutureBuilder to load and decode JSON
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString(assettoload, cache: false),
      builder: (context, snapshot) {
        List mydata = json.decode(snapshot.data.toString());
        if (mydata == null) {
          return Scaffold(
            body: Container(
              child: Center(
                child: Text(
                  "Loading",
                ),
              ),
            ),
          );
        } else {
          return quizpage(mydata: mydata);
        }
      },
    );

  }
}

class quizpage extends StatefulWidget {
  final List mydata;

  quizpage({Key? key, required this.mydata}) : super(key: key);
  @override
  _quizpageState createState() => _quizpageState(mydata);
}

class _quizpageState extends State<quizpage> {
  final List mydata;
  _quizpageState(this.mydata);

  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  bool disableAnswer = false;
  // extra varibale to iterate
  int j = 1;
  int timer = 30;
  String showtimer = "30";
  var random_array;

  Map<String, Color> btncolor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };

  bool canceltimer = false;

  bool showSplash = false;

  // code inserted for choosing questions randomly
  // to create the array elements randomly use the dart:math module
  // -----     CODE TO GENERATE ARRAY RANDOMLY

  genrandomarray(){
    var distinctIds = [];
    var rand = new Random();
      for (int i = 0; ;) {
      distinctIds.add(rand.nextInt(10));
        random_array = distinctIds.toSet().toList();
        if(random_array.length < 10){
          continue;
        }else{
          break;
        }
      }
      print(random_array);
  }

  //   var random_array;
  //   var distinctIds = [];
  //   var rand = new Random();
  //     for (int i = 0; ;) {
  //     distinctIds.add(rand.nextInt(10));
  //       random_array = distinctIds.toSet().toList();
  //       if(random_array.length < 10){
  //         continue;
  //       }else{
  //         break;
  //       }
  //     }
  //   print(random_array);

  // ----- END OF CODE
  // var random_array = [1, 6, 7, 2, 4, 10, 8, 3, 9, 5];

  // overriding the initstate function to start timer as this screen is created
  @override
  void initState() {
    starttimer();
    genrandomarray();
    super.initState();
  }

  // overriding the setstate function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    canceltimer = false;
    timer = 30;
    setState(() {
      if (j < 10) {
        i = random_array[j];
        j++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(marks: marks),
        ));
      }
      btncolor["a"] = Colors.indigoAccent;
      btncolor["b"] = Colors.indigoAccent;
      btncolor["c"] = Colors.indigoAccent;
      btncolor["d"] = Colors.indigoAccent;
      disableAnswer = false;
    });
    starttimer();
  }

  void checkanswer(String k) {
    
    // in the previous version this was
    // mydata[2]["1"] == mydata[1]["1"][k]
    // which i forgot to change
    // so make sure that this is now corrected

    if (mydata[2][i.toString()] == mydata[1][i.toString()][k]) {
      // just a print sattement to check the correct working
      // debugPrint(mydata[2][i.toString()] + " is equal to " + mydata[1][i.toString()][k]);
      marks = marks + 1;
      // changing the color variable to be green
      colortoshow = right;
      showSplash = true; // Set to true when the answer is correct

      // Show the "Hooray" message as a Snackbar

    } else {
      // just a print sattement to check the correct working
      // debugPrint(mydata[2]["1"] + " is equal to " + mydata[1]["1"][k]);
      colortoshow = wrong;
      showSplash = false;
    }
    setState(() {
      // applying the changed color to the particular button that was selected
      btncolor[k] = colortoshow;
      canceltimer = true;
      disableAnswer = true;
    });
    // nextquestion();
    // changed timer duration to 1 second
    Timer(Duration(seconds: 2), () {
      // Hide the splash screen and proceed to the next question after 2 seconds
      setState(() {
        showSplash = false;
      });
      nextquestion();
    });
  }

  Widget choicebutton(String k) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: MaterialButton(
          onPressed: () => checkanswer(k),
          child: Text(
            mydata[1][i.toString()][k],
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Alike",
              fontSize: 20.0,
            ),
            maxLines: 1,
          ),
          color: btncolor[k],
          splashColor: Colors.indigo[700],
          highlightColor: Colors.indigo[700],
          minWidth: 200.0,
          height: 45.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: (){
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("ASSESSMENT"),
            content: Text("You Can't Go Back At This Stage."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          ),
        ).then((value) => Future.value(true)); // Return a Future

      },
      child: Scaffold(
        body: Stack(
          children:[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background.jpg'), // Replace with your image path
                  fit: BoxFit.cover, // You can adjust this to your needs
                ),
              ),
              child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      mydata[0][i.toString()],
                      style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: "Quando",
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: AbsorbPointer(
                      absorbing: disableAnswer,
                        child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            choicebutton('a'),
                            choicebutton('b'),
                            choicebutton('c'),
                            choicebutton('d'),
                          ],
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Center(
                      child: Text(
                        showtimer,
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
          ),
            ),
            if (showSplash) SplashWidget(),
      ],
        ),

      ),
    );
  }
}

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // Set your desired background color
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9, // Set the width to 90% of the screen
          heightFactor: 0.9, // Set the height to 90% of the screen
          child: Stack(
            children: [
              Positioned(
                left: 90,
                top: 0,
                bottom: 400,
                child: ClipOval(
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    child: Image.asset(
                      'images/joy.jpg',
                      width: 100, // Reduce the width to your desired size
                      height: 50, // Reduce the height to your desired size
                      fit: BoxFit.contain, // Adjust this as needed
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 210,
                top: 0,
                bottom: 400,
                child: Center(
                  child: Text(
                    "Hooray",
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








