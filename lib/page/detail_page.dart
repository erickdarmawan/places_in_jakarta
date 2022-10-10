import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:places_in_jakarta/home_page.dart';
import 'package:places_in_jakarta/model/places.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BackButton(
            onPressed: () {},
          ),
        ],
        title: Text("Details"),
      ),
      // body:
      // FutureBuilder(
      //   future: ,
      // )
    );
  }
}
