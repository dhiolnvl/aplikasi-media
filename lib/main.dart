import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
  // DHIO LINOVAL 23.240.0016
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Demo App',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
