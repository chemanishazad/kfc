import 'package:flutter/material.dart';
import 'package:kfc/pages/home/home_page.dart';
import 'package:kfc/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kfc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color(0xfffe6d02),
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: Fonts.averta,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(height: 1.2),
          )),
      home: const HomePage(),
    );
  }
}
