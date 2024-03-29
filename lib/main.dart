import 'package:event_management_app/providers/auth_provider.dart';
import 'package:event_management_app/screens/HomeScreen/home.dart';
import 'package:event_management_app/screens/loginscreen/login.dart';
import 'package:event_management_app/utility/routes/routes.dart';
import 'package:event_management_app/utility/routes/routes_name.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';
import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (_) => SliderProvider(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => CountProvider(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => FavouriteProvider(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => ThemeProvider(),
        // ),
        ChangeNotifierProvider(create: (_)=>AuthProvider()),
      ],
      child: Builder(builder: (BuildContext context) {
        //final themeProvider=Provider.of<ThemeProvider>(context);
        return MaterialApp(
          //themeMode: themeProvider.themeMode,
          theme: ThemeData(

              iconTheme: const IconThemeData(color: Colors.blue,)


          ),
          darkTheme: ThemeData(brightness: Brightness.dark,
            primaryColor: Colors.red,
            iconTheme:const IconThemeData(color: Colors.red),
            appBarTheme:  const AppBarTheme(backgroundColor: Colors.red),

          ),


          debugShowCheckedModeBanner: false,
          home: FutureBuilder<User?>(
            future: Constants.getUserLocally(), // Check if a user is already logged in
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Loading state, you can display a loading indicator
                return const CircularProgressIndicator(); // or any loading widget
              } else {
                if (snapshot.hasData) {
                  // User data exists, navigate to the home page
                  return const HomeScreen();
                } else {
                  // User data doesn't exist, navigate to the login page
                  return const LoginPage();
                }
              }
            },
          ),

          onGenerateRoute: Routes.generateRoutes,
        );
      }),
    );
  }
}


