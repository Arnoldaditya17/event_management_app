import 'package:event_management_app/controllers/user_signup_controller.dart';
import 'package:event_management_app/utility/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Let's Create your account", style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: TSizes.spaceBtwSections),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: firstNameController,
                      decoration: const InputDecoration(labelText: 'First Name',prefixIcon: Icon(Iconsax.user),),
                      validator: validateName,
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      controller: lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name',prefixIcon: Icon(Iconsax.user),),
                      validator: validateName,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email ID',prefixIcon: Icon(Iconsax.direct)),
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number',prefixIcon: Icon(Iconsax.call)),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
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
                      userProfile: '',
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
                child: const Text('Sign Up'),
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