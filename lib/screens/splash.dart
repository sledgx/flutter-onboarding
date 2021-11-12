import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_onboarding/screens/home.dart';
import 'package:flutter_onboarding/screens/onboarding.dart';
import 'package:flutter_onboarding/utils/preferences.dart';
import 'package:flutter_onboarding/utils/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _wait() {
    Timer(
      const Duration(
        milliseconds: 3000,
      ),
      _gotoNextScreen,
    );
  }

  void _gotoNextScreen() async {
    bool onboardingIsViewed = await PreferencesManager.getOnboardingViewed();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        if (onboardingIsViewed) {
          return const HomeScreen();
        } else {
          return const OnboardingScreen();
        }
      }),
    );
  }

  @override
  void initState() {
    _wait();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 0, 0, 0.2),
                Color.fromRGBO(0, 0, 0, 0.8)
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                  ),
                  Text(
                    'Flutter',
                    style: kSubtitleStyle,
                  ),
                  Text(
                    'Onboarding',
                    style: kTitleStyle,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
