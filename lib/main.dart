import 'package:flutter/material.dart';
import 'package:places_in_jakarta/page/detail_page.dart';
import 'package:places_in_jakarta/remote_service.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/home_page': (context) => HomePage(),
        '/detail_page': (context) => DetailPage(),
      },
    );
  }
}
