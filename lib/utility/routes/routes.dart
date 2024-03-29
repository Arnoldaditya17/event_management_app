import 'package:event_management_app/utility/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../screens/HomeScreen/home.dart';
import '../../screens/loginscreen/login.dart';


class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('no such routes'),
              ),
            );
          },
        );
    }
  }
}
