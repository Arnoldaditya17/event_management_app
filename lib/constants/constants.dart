

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/User.dart';

class Constants{
  static getUri(String endpoint) {
    return Uri(
      scheme: 'http',
      host: '192.168.1.9',
      port: 8081,
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