import 'package:flutter/material.dart';
import 'package:shopping_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopeee Shopping App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 253, 140, 35),
          primary: const Color.fromARGB(255, 253, 140, 35),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 37,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.black,
        )),
        fontFamily: "Lato",
      ),
      home: const HomePage(),
    );
  }
}
