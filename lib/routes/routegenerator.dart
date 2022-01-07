import 'package:calendar_it/constants/theme_file.dart';
import 'package:calendar_it/main.dart';
import 'package:calendar_it/pages/Authentication/authenticate.dart';
import 'package:calendar_it/pages/LandingPage/landing_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args= settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(
            builder:(_)=>const LandingPage()
        );
      case '/login':
        return MaterialPageRoute(
            builder:(_)=>const Authentication()
        );
      case '/home':
        return MaterialPageRoute(
            builder:(_)=>const MyHomePage(title:"Calendar It")
        );
      default:
        return _errorRoute();

    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('ERROR'),
          ),
        );
      }
   );
}

