import 'package:flutter/material.dart';
import 'package:music_app/services/auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => auth.signOut(), icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: Center(
          child: Text(
              "Welcom to Home Screen, ${auth.currentUser.uid.substring(1, 10)}"),
        ),
      ),
    );
  }
}
