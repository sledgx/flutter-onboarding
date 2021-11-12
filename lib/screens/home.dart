import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/utils/preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _incrementCounter() {
    setState(() {
      if (_counter < 100) {
        _counter++;
      }
    });
  }

  void _clearPreferences() {
    PreferencesManager.unsetOnboardingViewed();
  }

  void _setLanguage(String languageCode) {
    context.setLocale(Locale(languageCode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home.title').tr(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'home.center_text',
            ).tr(),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 35.0),
            _counter >= 5
                ? TextButton.icon(
                    onPressed: () => _clearPreferences(),
                    icon: const Icon(Icons.settings_suggest_outlined),
                    label: const Text(
                      'home.reset_text',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ).tr(),
                  )
                : const Text('home.trick_text').tr(),
            const SizedBox(height: 50.0),
            const Text(
              'home.select_language',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
            const SizedBox(height: 20.0),
            TextButton.icon(
              onPressed: () => _setLanguage('en'),
              icon: Image.asset(
                'assets/images/flag_en.png',
                width: 25.0,
              ),
              label: const Text(
                'English',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () => _setLanguage('it'),
              icon: Image.asset(
                'assets/images/flag_it.png',
                width: 25.0,
              ),
              label: const Text(
                'Italiano',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: 10,
            bottom: 100,
            child: FloatingActionButton(
              heroTag: 'increment',
              onPressed: _incrementCounter,
              tooltip: 'generics.increment'.tr(),
              child: const Icon(Icons.add),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 20,
            child: FloatingActionButton(
              heroTag: 'decrement',
              onPressed: _decrementCounter,
              tooltip: 'generics.decrement'.tr(),
              child: const Icon(Icons.remove),
              backgroundColor: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
