import 'package:flutter/material.dart';
import 'package:mini_project1/screens/displaybooks.dart';

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/landing.jpg'), // Replace with the actual image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                   return const MyPdfViewer(bookURL: 'books/English.pdf',);
                }));
              },
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.pink[100],
                  child: const Center(
                    child: Text("English",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const MyPdfViewer(bookURL: 'books/EVS.pdf',);
                }));
              },
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.blue[100],
                  child: const Center(
                    child: Text("EVS",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return const MyPdfViewer(bookURL: 'books/Maths.pdf',);
                }));
              },
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.green[100],
                  child: const Center(
                    child: Text("Maths",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
