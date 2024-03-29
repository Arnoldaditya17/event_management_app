import 'dart:convert';

import '../constants/constants.dart';

import 'package:http/http.dart' as http;

import '../models/user.dart';
class UserController {
  static bool isLoading = false;

  static Future<User> login(String email, String password) async {
    isLoading = true; // Set loading state to true before API call
    try {
      final url = Constants.getUri('/user/login');
      final response = await http.post(
        url,
        body: jsonEncode({"email": email, "password": password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final User user = User.fromJson(json.decode(response.body));
        await Constants.saveUserLocally(user);
        return user;
      } else {
        throw Exception('User or password Invalid');
      }
    } finally {
      isLoading = false; // Set loading state back to false after API call
    }
  }
}
