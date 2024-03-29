

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';



class Constants{
  static getUri(String endpoint) {
    return Uri(
      scheme: 'http',
      host: '10.11.0.49',
      port: 8080,
      path: endpoint,
    );
  }

  static const String _userKey = 'user';

  static Future<void> saveUserLocally(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = user.toJson();
    final userDataString = json.encode(userData);
    await prefs.setString(_userKey, userDataString);
  }

  static Future<User?> getUserLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userKey);
    if (userDataString != null) {
      final userData = json.decode(userDataString);
      return User.fromJson(userData);
    }
    return null;
  }
}