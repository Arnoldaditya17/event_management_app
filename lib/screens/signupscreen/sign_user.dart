import 'package:event_management_app/controllers/user_signup_controller.dart';
import 'package:flutter/material.dart';
import '../../controllers/user_login_controller.dart';
import '../../models/user.dart';
import '../../utility/routes/routes_name.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Email validation regex
    String emailPattern = r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b';
    RegExp regExp = RegExp(emailPattern, caseSensitive: false);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    // Pattern to accept alphabetic characters and spaces
    String namePattern = r'^[A-Za-z ]+$';
    RegExp regExp = RegExp(namePattern);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid name (letters and spaces only)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Teacher')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: validateName,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: validateName,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email ID'),
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, continue with processing the input values
                    final firstName = firstNameController.text;
                    final lastName = lastNameController.text;
                    final email = emailController.text;
                    final phoneNumber = phoneNumberController.text;

                    User user = User(
                      id: 0,
                      firstname: firstName,
                      lastname: lastName,
                      email: email,
                      phone: phoneNumber,
                    );

                    bool isSaved = await UserRegistrationController.signupUsers(user);
                    if (isSaved) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User saved successfully!')),
                      );
                      Navigator.pushNamed(context, RoutesName.login);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to save user!')),
                      );
                    }
                  }
                },
                child: const Text('Register and Send Credentials'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
