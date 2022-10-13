import 'package:flutter/material.dart';
import 'package:places_in_jakarta/model/model.dart';
import 'package:places_in_jakarta/page/page.dart';
import 'package:places_in_jakarta/remote_service.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 9, 54, 54),
          title: Text(
            "Details",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<PlaceDetails?>(
            future: RemoteService().getPlaceDetails('4e2a764d7d8b7deda6c627e7'),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20),
                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (BuildContext, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                snapshot.data!.name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: getCategoriesList(
                                    snapshot.data?.categories),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                ),
                                child: getImage(snapshot.data!.photo),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    getLocationList(snapshot.data?.location),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data!.location!.country.toString(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if (snapshot.data?.rating != null)
                                getRating(snapshot.data?.rating),
                              SizedBox(
                                height: 30,
                              ),
                              Text('https://api.foursquare.com/' +
                                  snapshot.data!.link)
                            ],
                          );
                        }),
                  ),
                );
              }
              return Text('Could not load context ');
            }));
  }
}

List<Text> getLocationList(Location? location) {
  List<Text> filteredLocationTextList = [];
  if (location?.address != null) {
    filteredLocationTextList.add(Text(
      location!.address!,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ));
  }
  return filteredLocationTextList;
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

List<Row> getCategoriesList(List<PlaceCategory>? categories) {
  if (categories == null) {
    return [];
  }
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

Image getImage(Photo? photo) {
  return photo != null
      ? Image(height: 300, image: NetworkImage(photo!.constructImageUrl()))
      : Image.asset('asset/placeholderImage.png', height: 300);
}
