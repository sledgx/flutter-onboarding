import 'package:flutter/material.dart';
import 'package:flutter_onboarding/utils/preferences.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key? key, required this.title}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 35.0),
            _counter >= 5
                ? TextButton(
                    onPressed: () => _clearPreferences(),
                    child: const Text('Reset Preferences'),
                  )
                : const Text('Trick: at least 5 clicks are needed'),
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
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 20,
            child: FloatingActionButton(
              heroTag: 'decrement',
              onPressed: _decrementCounter,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
              backgroundColor: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
