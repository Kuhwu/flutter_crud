import 'package:flutter/material.dart';
import 'package:flutter_crud/readpage.dart';

//import 'package:flutter_crud/homepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD',
      theme: ThemeData.dark(),
      home: const ReadPage(),
    );
  }
}
