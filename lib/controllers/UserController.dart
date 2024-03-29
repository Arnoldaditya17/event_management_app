import 'dart:convert';

import '../constants/constants.dart';

import 'package:http/http.dart' as http;

import '../models/User.dart';
class UserController{

  static Future<User> login(String email , String password) async {
    final url = Constants.getUri('/user/login');
    final response = await http.post(

      url,
      body:jsonEncode({"email":email,"password":password}),
      headers: {
        'Content-Type': 'application/json',
      },
    );


    if (response.statusCode == 200) {
      final  User user = User.fromJson(json.decode(response.body));
      await Constants.saveUserLocally(user);
      return user;
    } else {
      throw Exception('User or password Invalid');
    }
  }
}