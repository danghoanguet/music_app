import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music_app/app/screens/on_boarding/on_boarding_screen.dart';
import 'package:music_app/app/screens/splash/splash_screen.dart';
import 'package:music_app/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthBase>(create: (context) => Auth()),
      ],
      child: MaterialApp(
        routes: {'onBoarding': (context) => OnBoardingScreen()},
        debugShowCheckedModeBanner: false,
        title: 'Music App',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
