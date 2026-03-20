
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsetsGeometry.all(20.0),
        children: [
          ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, '/counter');
            },
            child: Text("Counter"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent, // Background color
              foregroundColor: Colors.white, // Text/icon color
            ),
          ),
          SizedBox(height: 20.0,),
          ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, '/todo');
            },
            child: Text("Todo Page"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal, // Background color
              foregroundColor: Colors.white, // Text/icon color
            ),
          ),
        ],
      ),
    );
  }

}