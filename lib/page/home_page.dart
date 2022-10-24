import 'package:flutter/material.dart';
import 'package:places_in_jakarta/page/detail_page.dart';
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
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 54, 54),
        title: Text('Places in Jakarta'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Place>>(
        future: RemoteService().getPlaceList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: OutlinedButton(
                        onPressed: () {
                          var fsqId = snapshot.data![index].fsq_id;

                          Navigator.pushNamed(context, DetailPage.routeName,
                              arguments: fsqId);
                        },
                        child: Card(
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  getImage(snapshot.data?[index].photo),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Card(
                                    shadowColor: Colors.black,
                                    elevation: 1,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.4)),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: getNameText(
                                              snapshot.data?[index].name)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: getCategories(snapshot
                                                  .data?[index].categories ??
                                              []),
                                        ),
                                      ),
                                      if (snapshot.data?[index].rating != null)
                                        getRating(snapshot.data?[index].rating),
                                    ],
                                  )
                                ],
                              )),
                        ),
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
        ? Image(height: 300, image: NetworkImage(photo.constructImageUrl()))
        : Image.asset('asset/placeholderImage.png', height: 300);
  }

  Text getNameText(String? name) {
    final String textContent = name != null ? name.toString() : '';
    return Text(textContent,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ));
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
      padding: const EdgeInsets.all(3),
      child: Row(
        children: [
          const Icon(Icons.star_border_sharp, color: Colors.yellowAccent,),
          const SizedBox(width: 1,),
          Text(
            rating != null ? rating.toString() : '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      decoration: BoxDecoration(color: Colors.green.withOpacity(0.5)),
    );
  }
}
