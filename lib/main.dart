import 'package:flutter/material.dart';
import 'package:flutter_onboarding/screens/home.dart';
import 'package:flutter_onboarding/screens/onboarding.dart';
import 'package:flutter_onboarding/utils/preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Onboarding',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: () async {
          return await PreferencesManager.getOnboardingViewed();
        }(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return const HomeScreen(title: 'Home from Main');
          } else {
            return const OnboardingScreen();
          }
        },
      ),
    );
  }
}
