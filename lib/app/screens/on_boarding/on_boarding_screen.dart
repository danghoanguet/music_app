import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/app/screens/sign_in/sign_in_screen.dart';
import 'package:music_app/app/screens/sign_up/sign_up_screens.dart';

import 'package:music_app/widgets/custom_text_button.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Spacer(),
              SizedBox(
                height: 80,
              ),
              Image.asset(
                "assets/logo.png",
                height: 200,
              ),
              Center(
                child: Text(
                  "Let’s get started",
                  style: TextStyle(
                      color: Color.fromRGBO(241, 241, 241, 0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Welcome to the Audio application. Start enjoying songs with high sound quality right away.",
                  style:
                      TextStyle(color: Colors.grey, fontSize: 18, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
              //Spacer(),
              SizedBox(
                height: 180,
              ),
              CustomTextButton(
                  onPressed: () => {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            fullscreenDialog: false,
                            builder: (context) => SignUpScreen(),
                          ),
                        )
                      },
                  title: "Sign Up"),
              //Spacer(),
              SizedBox(
                height: 40,
              ),
              _buildSignInText(context),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have account?  ",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        GestureDetector(
          onTap: () => {
            Navigator.of(context).push(
              CupertinoPageRoute(
                fullscreenDialog: false,
                builder: (context) => SignInScreen(),
              ),
            )
          },
          child: Text(
            "Sign In",
            style: TextStyle(color: Colors.yellowAccent, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
