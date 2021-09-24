import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/app/screens/on_boarding/on_boarding_screen.dart';
import 'package:music_app/app/screens/sign_up/sign_up_screens.dart';
import 'package:music_app/services/auth.dart';
import 'package:music_app/widgets/custom_text_button.dart';
import 'package:music_app/widgets/custom_text_button_icon.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Sign In",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildForm(),
            SizedBox(
              height: 50,
            ),
            CustomTextButton(onPressed: onSignIn, title: "Get started"),
            SizedBox(
              height: 15,
            ),
            _buildFogretPasswordText(),
            //Spacer(),
            SizedBox(
              height: 120,
            ),
            CustomTestButtonIcon(
              onPressed: () => _signInWithGoogle(context, auth),
              title: "Sign in with Google",
              color: Color.fromRGBO(197, 77, 59, 1),
              imageUrl: "assets/google_logo.png",
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: CustomTestButtonIcon(
                onPressed: () => _signInWithFacebook(context, auth),
                title: "Sign in with Facebook",
                color: Color.fromRGBO(68, 103, 190, 1),
                imageUrl: "assets/facebook_logo.png",
              ),
            ),
            _buildCreateAccountText(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle(BuildContext context, AuthBase auth) async {
    print(auth.currentUser);
    try {
      await auth.signInWithGoogle();
      while (Navigator.of(context).canPop()) Navigator.of(context).pop();
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context, AuthBase auth) async {
    try {
      await auth.signInWithFacebook();
      while (Navigator.of(context).canPop()) Navigator.of(context).pop();
    } on Exception catch (e) {
      print(e);
    }
  }

  Widget _buildFogretPasswordText() {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Text(
          "Forget passwrod?",
          style: TextStyle(color: Colors.yellowAccent, fontSize: 15),
        ),
      ),
    );
  }

  Widget _buildCreateAccountText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Dont'n have account?  ",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        GestureDetector(
          //Todo: Switch back to Sign up screen,
          onTap: () => {Navigator.of(context).pop()},
          child: Text(
            "Create Account",
            style: TextStyle(color: Colors.yellowAccent, fontSize: 15),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Email address",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            height: 3,
          ),
        ),
        _buildEmailForm(),
        Text(
          "Password",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            height: 3,
          ),
        ),
        _buildPasswordForm(),
      ]),
    );
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      return true;
    }
    return false;
  }

  void onSignIn() async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      _validateAndSaveForm();
      await auth.signInWithEmailAndPassword(_email, _password);
      // pop until OnBoardingSreen
      while (Navigator.of(context).canPop()) Navigator.of(context).pop();
      print("Email: $_email\n Password: $_password");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  TextFormField _buildEmailForm() {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[600],
          hintText: "namesurname@gmail.com",
          hintStyle: TextStyle(color: Colors.white70),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFE1CDAA5), width: 3.0),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[600], width: 3.0),
          ),
          contentPadding: EdgeInsets.all(20)),
      onSaved: (value) => _email = value,
    );
  }

  TextFormField _buildPasswordForm() {
    return TextFormField(
      obscureText: obscureText ? true : false,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[600],
          suffixIcon: suffixIcon(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFE1CDAA5), width: 3.0),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[600], width: 3.0),
          ),
          contentPadding: EdgeInsets.all(20)),
      onSaved: (value) => _password = value,
      onEditingComplete: onSignIn,
    );
  }

  Widget suffixIcon() {
    return GestureDetector(
      onTap: () => _obscureChange(),
      child: !obscureText
          ? Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.white,
            )
          : Icon(
              Icons.remove_red_eye,
              color: Colors.white,
            ),
    );
  }

  void _obscureChange() {
    print(obscureText);
    obscureText = !obscureText;
    print(obscureText);
    setState(() {});
  }
}
