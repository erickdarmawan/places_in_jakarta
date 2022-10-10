import 'package:flutter/material.dart';
import 'package:places_in_jakarta/page/detail_page.dart';
import 'home_page.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      'home_page': (context) => const HomePage(),
      'detail_page': (context) => DetailPage()
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        'detail_page': (context) => DetailPage(),
      },
    );
  }
}
