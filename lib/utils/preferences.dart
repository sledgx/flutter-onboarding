import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static const String _onboardingViewedKey = 'onboarding_viewed';

  static Future<bool> getOnboardingViewed() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_onboardingViewedKey) ?? false;
  }

  static void setOnboardingViewed({bool viewed = true}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_onboardingViewedKey, viewed);
  }

  static void unsetOnboardingViewed() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(_onboardingViewedKey);
  }
}
