import 'package:flutter/material.dart';
import 'package:youtube_home_page/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      title: 'Youtube App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.black, 
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, 
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), 
        ),
      ),
      home: const HomePage(),
    );
  }
}
