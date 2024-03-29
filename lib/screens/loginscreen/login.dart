import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../controllers/user_login_controller.dart';
import '../../models/user.dart';
import '../../utility/routes/routes_name.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Initially, password is hidden
  bool isValidEmail(String email) {
    // Define a regular expression for email validation
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        UserController.isLoading = true; // Set loading state to true
      });

      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        final User user = await UserController.login(email, password);
        Navigator.pushNamed(context, RoutesName.home);
      } catch (e) {
        print('Authentication failed: $e');
        // Show error message or handle authentication failure
        Flushbar(


          borderRadius: BorderRadius.circular(5),
          message: 'Authentication failed: $e',
          duration: Duration(seconds: 3),
        )..show(context);
      } finally {
        setState(() {
          UserController.isLoading = false; // Set loading state back to false
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: const Color.fromARGB(255, 41, 8, 134),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 20,
                  bottom: 5,
                ),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!isValidEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    // Add more email validation logic if needed
                    return null;
                  },
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.black),
                    fillColor: const Color.fromARGB(255, 225, 227, 229),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 10,
                  bottom: 5,
                ),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  // Toggle password visibility
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    // Add more password validation logic if needed
                    return null;
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.black),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    fillColor: const Color.fromARGB(255, 225, 227, 229),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<bool>(
                future: Future.value(UserController
                    .isLoading), // Wrap bool value in Future.value
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == true) {
                    return const CircularProgressIndicator(); // Show loader while isLoading is true
                  } else {
                    return ElevatedButton(
                      onPressed: _handleLogin,
                      child: const Text('LOGIN'),
                    );
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.signup);
                },
                child: const Text(
                  'create account',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
