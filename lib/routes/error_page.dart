import 'package:calendar_it/constants/theme_file.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          body: Center(
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.bottomLeft,
              children: const [
                Text("404",
                  style: TextStyle(
                    color: LightTheme.primary,
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text("Error")
              ],
            ),
          ),
        )
    );
  }
}
