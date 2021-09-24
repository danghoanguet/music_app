import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/app/screens/sign_in/sign_in_screen.dart';
import 'package:music_app/landing_page.dart';
import 'package:music_app/services/auth.dart';
import 'package:music_app/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Create Account",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildForm(),
              SizedBox(
                height: 50,
              ),
              CustomTextButton(onPressed: onCreate, title: "Create account"),
              // Spacer(),
              SizedBox(
                height: 270,
              ),
              _buildSignInText(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInText() {
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
        SizedBox(
          height: 10,
        ),
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

  void onCreate() async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      _validateAndSaveForm();
      await auth.createUserWithEmailAndPassword(_email, _password);
      Navigator.of(context).pop();
      print("Email: $_email\n Password: $_password");
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
  }

  TextFormField _buildEmailForm() {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[600],
          hintText: "namesurname@gmail.com",
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
      onEditingComplete: onCreate,
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
