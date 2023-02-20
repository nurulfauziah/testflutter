import 'package:flutter/material.dart';
import 'package:testflutter/feature/auth/presentation/signup_screen.dart';
import 'package:testflutter/helper/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tets',
      navigatorKey: myNavigatorKey,
      theme: ThemeData(
        primaryColor: const Color(0xFF6F35A5),
        inputDecorationTheme: const InputDecorationTheme(
            focusColor: Color(0xFF6F35A5), fillColor: Color(0xFF6F35A5)),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SignupForm(),
    );
  }
}
