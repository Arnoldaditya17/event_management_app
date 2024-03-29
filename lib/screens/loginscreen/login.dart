import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("build");
    final authProvider = Provider.of<AuthProvider>(context);
    ValueNotifier<bool> toggle = ValueNotifier<bool>(true);
    return Scaffold(
      backgroundColor: Colors.black45.withOpacity(0.2),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.network(
              'https://lottie.host/6d3fa948-6ec1-4bcc-b7f2-344492cbffb7/LmzMBy2DSs.json',
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: const TextStyle(color: Colors.white),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ValueListenableBuilder(
                    valueListenable: toggle,
                    builder: (context, value, child) {
                      return TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: passwordController,
                        obscureText: toggle.value,
                        decoration: InputDecoration(
                          suffix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                toggle.value=!toggle.value;
                              },
                              child: Icon(toggle.value
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      );
                    })),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();
                  if (email.isNotEmpty && password.isNotEmpty) {
                    authProvider.login(email, password);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all fields.'),
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.deepOrange,
                    border: Border.all(),
                  ),
                  child: Center(
                    child: authProvider.loading
                        ? CircularProgressIndicator()
                        : Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
