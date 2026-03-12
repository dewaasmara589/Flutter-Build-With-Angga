
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({
    super.key,
    required this.id,
    required this.tab,
    required this.idFromQueryParam,
    required this.idFromExtra,
  });

  final String id;
  final String tab;
  final String idFromQueryParam;
  final String idFromExtra;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
      body: Center(
        child: Column(
          spacing: 16.0,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Profile with ID : $id"),
            Text("Profile with Tab : $tab"),
            Text("Profile with ID (Query Param) : $idFromQueryParam"),
            Text("Profile with ID (Extra) : $idFromExtra"),
            ElevatedButton(
                onPressed: () {
                  context.go("/");
                },
                child: Text("Back to Home")
            )
          ],
        ),
      ),
    );
  }
  
}