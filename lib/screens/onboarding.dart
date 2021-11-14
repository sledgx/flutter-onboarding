import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_onboarding/data/onboarding.dart';
import 'package:flutter_onboarding/screens/home.dart';
import 'package:flutter_onboarding/utils/preferences.dart';
import 'package:flutter_onboarding/utils/styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingData> _pages = [
    OnboardingData(
      imagePath: 'assets/images/onboarding1.png',
      title: 'onboarding.page1.title'.tr(),
      description: 'onboarding.page1.description'.tr(),
    ),
    OnboardingData(
      imagePath: 'assets/images/onboarding2.png',
      title: 'onboarding.page2.title'.tr(),
      description: 'onboarding.page2.description'.tr(),
    ),
    OnboardingData(
      imagePath: 'assets/images/onboarding3.png',
      title: 'onboarding.page3.title'.tr(),
      description: 'onboarding.page3.description'.tr(),
    )
  ];
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPages() {
    List<Widget> list = [];
    for (int i = 0; i < _pages.length; i++) {
      list.add(_buildPage(_pages[i]));
    }
    return list;
  }

  Widget _buildPage(OnboardingData page) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(page.imagePath),
              height: 300.0,
              width: 300.0,
            ),
          ),
          const SizedBox(height: 30.0),
          Text(
            page.title,
            style: kOnboardingTitleStyle,
          ),
          const SizedBox(height: 15.0),
          Text(
            page.description,
            style: kOnboardingDescriptionStyle,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _pages.length; i++) {
      list.add(_buildIndicator(i == _currentPage));
    }
    return list;
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0xFF7B51D3),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  void _gotoHome() {
    PreferencesManager.setOnboardingViewed();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _gotoHome(),
                    child: const Text(
                      'generics.skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ).tr(),
                  ),
                ),
                SizedBox(
                  height: 600.0,
                  child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: _buildPages(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _pages.length - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  'generics.next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ).tr(),
                                const SizedBox(width: 10.0),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _pages.length - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => _gotoHome(),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: const Text(
                      'generics.get_started',
                      style: TextStyle(
                        color: Color(0xFF5B16D0),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                  ),
                ),
              ),
            )
          : const Text(''),
    );
  }
}
