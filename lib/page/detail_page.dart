import 'package:flutter/material.dart';
import 'package:places_in_jakarta/model/model.dart';
import 'package:places_in_jakarta/remote_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String fsqId = ModalRoute.of(context)!.settings.arguments as String;
  
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
            future: RemoteService().getPlaceDetails(fsqId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
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
                              Column(
                                children: getCategoriesList(
                                    snapshot.data?.categories),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(thickness: 1, color: Colors.blueGrey),
                              SizedBox(
                                height: 15,
                              ),
                              nameText(snapshot.data?.name),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: getImage(snapshot.data!.photos.isNotEmpty
                                    ? snapshot.data?.photos[0]
                                    : null),
                              ),
                              SizedBox(height: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    getLocationList(snapshot.data?.location),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              countryText(snapshot.data?.location?.country),
                              SizedBox(
                                height: 10,
                              ),
                              if (snapshot.data?.rating != null)
                                Row(
                                  children: [
                                    Text('Rating: ${snapshot.data?.rating}'),
                                    SizedBox(width: 10,),
                                    getRating(snapshot.data?.rating),

                                  ],
                                ),
                              Divider(thickness: 1, color: Colors.blueGrey),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Address:',
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: 300,
                                          child: formattedAddressText(snapshot
                                              .data
                                              ?.location
                                              ?.formatted_address),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text('City:'),
                                      SizedBox(
                                        width: 45,
                                      ),
                                      Text(snapshot.data!.location!.locality
                                          .toString()),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Postcode:'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    postCodeText(
                                        snapshot.data?.location?.postcode),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Region:'),
                                  SizedBox(
                                    width: 27,
                                  ),
                                  regionText(snapshot.data?.location?.region)
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Link:',
                                    ),
                                    SizedBox(
                                      width: 45,
                                    ),
                                    Container(
                                      width: 200,
                                      child: linkText(snapshot.data?.link),
                                    ),
                                  ],
                                ),
                              )
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
  final address = location?.address;
  if (address != null) {
    filteredLocationTextList.add(
      Text(
        address,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  return filteredLocationTextList;
}

RatingBar getRating(double? rating){
  return RatingBar.builder(
    itemBuilder: (context, _)  => Icon(Icons.star, color: Colors.amber,),
    tapOnlyMode: true, 
    itemCount: 10,
    initialRating: rating != null ? rating : 0.0,
    minRating: 0,
    maxRating: 10,
    itemSize: 20,
    allowHalfRating: true,
    onRatingUpdate: (rating) {});
  }

Text nameText(String? name) {
  return Text(name != null ? name.toString() : '',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
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
  final imageUrl = photo?.constructImageUrl();
  return imageUrl != null
      ? Image(height: 300, image: NetworkImage(imageUrl))
      : Image.asset('asset/placeholderImage.png', height: 300);
}

Text countryText(String? country) {
  return Text(
    country != null ? country.toString() : '',
  );
}

Text regionText(String? region) {
  return Text(region != null ? region.toString() : '');
}

Text linkText(String? link) {
  final String linkString = link != null
      ? ('https://api.foursquare.com' + link.toString())
      : 'No Link Provided';
  return Text(linkString);
}

Text postCodeText(String? postcode) {
  return Text(
    postcode != null ? postcode.toString() : 'Postcode could not be found.',
  );
}

Text formattedAddressText(String? formatted_adress) {
  return Text(
    formatted_adress != null ? formatted_adress.toString() : '',
  );
}
