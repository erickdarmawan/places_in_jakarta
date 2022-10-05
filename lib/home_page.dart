// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places_in_jakarta/remote_service.dart';
import 'package:places_in_jakarta/model/places.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places in Jakarta'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Place>>(
        future: callService().callNetwork(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            // height: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                getImage(snapshot.data?[index].photo),
                                SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    snapshot.data![index].name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: getCategories(
                                            snapshot.data![index].categories),
                                      ),
                                    ),
                                    if (snapshot.data?[index].rating != null)
                                      getRating(snapshot.data?[index].rating),
                                  ],
                                )
                              ],
                            )),
                      ),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Text('....');
        },
      ),
    );
  }

  getImage(Photo? photo) {
    return photo != null
        ? Image(height: 300, image: NetworkImage(photo!.constructImageUrl()))
        : Image.asset('asset/placeholderImage.png', height: 300);
  }

  getCategories(List<PlaceCategory> categories) {
    return categories
        .map((cat) => Container(
              child: Text(
                cat.name,
              ),
            ))
        .toList();
  }

  getRating(double? rating) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(3),
      child: Text(
        rating != null ? rating.toString() : '',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      decoration: BoxDecoration(color: Colors.green.withOpacity(0.5)),
    );
  }
}
