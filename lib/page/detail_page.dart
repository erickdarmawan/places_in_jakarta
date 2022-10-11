import 'package:flutter/material.dart';
import 'package:places_in_jakarta/model/model.dart';
import 'package:places_in_jakarta/remote_service.dart';
import 'package:places_in_jakarta/model/place_details.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            BackButton(
              onPressed: () {
                Navigator.pushNamed(context, '/n');
              },
            ),
          ],
          title: Text("Details"),
        ),
        body: FutureBuilder<PlaceDetails?>(
            future: RemoteService().getPlaceDetails('4e2a764d7d8b7deda6c627e7'),
            builder: (context, snapshot) {
              return Center(
                child: ListView.builder(
                    itemCount: snapshot.data.hashCode,
                    itemBuilder: (BuildContext, index) {
                      return Column(
                        children: [
                          Text('Name'),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Categories'),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 300,
                            decoration: BoxDecoration(color: Colors.black45),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Address'),
                        ],
                      );
                    }),
              );
            }));
  }
}
