import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const AUTH = "login_auth";
  static const IMAGE = "IMAGE_KEY";

  // get preferencesHelper => null;

//NOTE: generic Shared Preference
  Future<bool> isSharedPref(String key) async {
    final prefs = await sharedPreferences;
    return prefs.getBool(key) ?? false;
  }

  void setSharedPref(String key, bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(key, value);
  }

  Future<String> getStringSharedPref(String key) async {
    final prefs = await sharedPreferences;
    return prefs.getString(key) ?? '';
  }

  void setStringSharedPref(String key, String data) async {
    final prefs = await sharedPreferences;
    prefs.setString(key, data);
  }

  void removeStringSharedPref(String key) async {
    final prefs = await sharedPreferences;
    prefs.remove(key);
  }

//NOTE: special Shared Preference
  Future<String> get getLoginAuth async {
    final prefs = await sharedPreferences;
    String data = prefs.getString(AUTH) ?? '';
    return (data.isNotEmpty) ? data : '';
  }

  void setLoginAuth(String data) async {
    final prefs = await sharedPreferences;
    prefs.setString(AUTH, data);
  }

  void removeLoginAuth() async {
    final prefs = await sharedPreferences;
    prefs.remove(AUTH);
  }

  Future<String> getImagePref(String username) async {
    final prefs = await sharedPreferences;
    return prefs.getString(IMAGE + username) ?? '';
  }

  void setImagePref(String username, String data) async {
    final prefs = await sharedPreferences;
    prefs.setString(IMAGE + username, data);
  }
}
