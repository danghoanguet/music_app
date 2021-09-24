import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/app/screens/home_screen/home_screen.dart';
import 'package:music_app/app/screens/on_boarding/on_boarding_screen.dart';
import 'package:music_app/app/screens/sign_in/sign_in_screen.dart';
import 'package:music_app/services/auth.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      body: StreamBuilder<User>(
          stream: auth.onAuthStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final User user = snapshot.data;
              if (user == null) {
                return OnBoardingScreen();
              }
              return HomeScreen();
            } else {
              return Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
            }
          }),
    );
  }
}
