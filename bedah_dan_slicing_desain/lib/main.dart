import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Item Service Coffee"), backgroundColor: Colors.blue,),
        body: ListView(
          padding: EdgeInsetsGeometry.all(16.0),
          children: [
            // click right button mouse -> Refactor ->
            // 1. Extract Method (untuk mengubah Container ke method atau function baru)
            // 2. Extract Widget (untuk mengubah Container ke widget atau StatelessWidget baru)
            Container(
              padding: EdgeInsetsGeometry.fromLTRB(40.0, 30.0, 40.0, 60.0),
              // Jika ada decoration harus dimasukkan colornya ke decoration
              decoration: BoxDecoration(
                color: Colors.brown[50],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(230),
                  bottomRight: Radius.circular(230),
                ),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 6.0,
                      color: Colors.brown[400]!,
                    offset: const Offset(1, 3)
                  ),
                ]
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(40.0),
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNjwqGCJv6cGlYkCpHjbapmPUBcrLfokF9-w&s",
                      fit: BoxFit.cover,
                      width: 80.0,
                      height: 80.0,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    "Casual Chocolate Coffee",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      color: Colors.brown[900]
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Text(
                    "Reguler casual coffee (without milk or cream) is low in calories. In fact, a typical cup of coffee",
                    style: TextStyle(
                        fontSize: 12.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0,),
                  TextButton(
                      onPressed: (){},
                      child: const Text("Explore More"),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.resolveWith((state){
                        return EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0);
                      }),
                      backgroundColor: MaterialStateProperty.resolveWith((state){
                        return Colors.brown[700];
                      }),
                      foregroundColor: MaterialStateProperty.resolveWith((state){
                        return Colors.white;
                      }),
                      shape: MaterialStateProperty.resolveWith((state){
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(30.0)
                        );
                      }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
