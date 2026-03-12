
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          spacing: 16.0,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  // Cara 1 Recommended
                  // context.go("/profile/21?id_query=666&id_query2=1000",
                  // extra: "777");

                  // Cara 2
                  // GoRouter.of(context).go("/profile");

                  // Cara 3 Push
                  context.push("/profile/21?id_query=666&id_query2=1000",
                      extra: "777");
                },
                child: Text("Go to Profile Page")
            ),
            ElevatedButton(
                onPressed: (){
                  context.go("/event");
                },
                child: Text("Go to Event Page")
            )
          ],
        ),
      ),
    );
  }
  
}