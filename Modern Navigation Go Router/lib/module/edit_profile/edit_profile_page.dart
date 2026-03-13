
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfilePage extends StatelessWidget{
  const EditProfilePage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile Page"),
      ),
      body: Center(
        child: Column(
          spacing: 16.0,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Edit Profile with ID : $id"),
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