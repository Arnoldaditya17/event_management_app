import 'package:another_flushbar/flushbar.dart';
import 'package:event_management_app/utility/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
        Navigator.pushReplacementNamed(context, RoutesName.navigationMenu);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: TSizes.appBarHeight,
              left: TSizes.defaultSpace,
              right: TSizes.defaultSpace,
              bottom: TSizes.defaultSpace),
          child: Column(
            children: [
              ///Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        height: 150,
                        image: AssetImage(
                            'assets/icon/appicon.png'
                        ),
                      ),
                      Text(
                        "Welcome Back",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              /// Form DATA
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
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
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          hintText: 'Email',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(0),
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
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.password_check),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<bool>(
                      future: Future.value(UserController
                          .isLoading), // Wrap bool value in Future.value
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting ||
                            snapshot.data == true) {
                          return const CircularProgressIndicator(); // Show loader while isLoading is true
                        } else {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _handleLogin,
                              child: const Text('LOGIN'),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesName.signup);
                        },
                        child: Text(
                          'Create Account',
                          style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.deepPurpleAccent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}