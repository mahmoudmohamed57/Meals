import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setBool({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool? getBool({required String key}) {
    return sharedPreferences.getBool(key);
  }

  static Future<bool> setString({
    required String key,
    required String value,
  }) async {
    return await sharedPreferences.setString(key, value);
  }

  static String? getString({required String key}) {
    return sharedPreferences.getString(key);
  }

  static Future<bool> setInt({
    required String key,
    required int value,
  }) async {
    return await sharedPreferences.setInt(key, value);
  }

  static int? getInt({required String key}) {
    return sharedPreferences.getInt(key);
  }

  static Future<bool> setStringList({
    required String key,
    required List<String> value,
  }) async {
    return await sharedPreferences.setStringList(key, value);
  }

  static Future<List<String>?> getStringList({required String key}) async {
    return sharedPreferences.getStringList(key);
  }
}
