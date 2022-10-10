// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:places_in_jakarta/remote_service.dart';
import 'package:places_in_jakarta/model/places.dart';
import 'page/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent.withOpacity(0.2),
        title: Text('Places in Jakarta'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Place>>(
        future: callService().getPlaceList(),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getImage(snapshot.data?[index].photo),
                                SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: getName(snapshot.data![index].name),
                                ),
                                SizedBox(
                                  height: 5,
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
          return CircularProgressIndicator(
            color: Colors.blueGrey,
          );
        },
      ),
    );
  }

  Image getImage(Photo? photo) {
    return photo != null
        ? Image(height: 300, image: NetworkImage(photo!.constructImageUrl()))
        : Image.asset('asset/placeholderImage.png', height: 300);
  }

  Text getName(String name) {
    return Text(name,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  List<Row> getCategories(List<PlaceCategory> categories) {
    return categories
        .map((cat) => Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                        image: NetworkImage(cat.icon.constructIcon()),
                        fit: BoxFit.fill),
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  cat.name,
                ),
              ],
            ))
        .toList();
  }

  Container getRating(double? rating) {
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

// void selectedItem(BuildContext context, int index) {
//   switch (index) {
//     case 1:
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (context) => DetailPage()));
//   }
// }
