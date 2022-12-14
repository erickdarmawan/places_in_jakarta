import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:places_in_jakarta/model/model.dart';


class RemoteService {
  Future<List<Place>> getPlaceList() async {
    Map<String, String> requestHeaders = {
      'Authorization': 'fsq3Tz0b7lh6LtcyoIl2kbZFHMuAxGaAXs9veBuPglC2LU8='
    };
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.foursquare.com/v3/places/search?query=jakarta&fields=rating,name,photos,fsq_id,categories,location');
    var response = await client.get(uri, headers: requestHeaders);
  

    if (response.statusCode == 200) {
      var place = json.decode(response.body);

     
      var results = place['results'] as List;
      List<Place> placeList = [];

      for (var result in results) {
        Photo? photo;
        List photoResult = result['photos'];
        if (photoResult.isNotEmpty) {
          photo = Photo(photoResult[0]['prefix'], photoResult[0]['suffix']);
        }

        List<PlaceCategory> categories = [];

        if (result['categories'] != null) {
          for (var categoryResult in result['categories']) {
            IconMap iconMap = IconMap(categoryResult['icon']['prefix'],
                categoryResult['icon']['suffix']);
            PlaceCategory category =
                PlaceCategory(categoryResult['name'], iconMap);
            categories.add(category);
          }
        }

        var place = Place(
          result['name'],
          photo,
          result['rating'],
          categories,
          result['fsq_id'],
        );
        placeList.add(place);
      }

      return placeList;
    } else {
      return [];
    }
  }

  Future<PlaceDetails?> getPlaceDetails(
    String fsq_id,
  ) async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.foursquare.com/v3/places/${fsq_id}?fields=rating,name,photos,fsq_id,categories,location,link');
    Map<String, String> requestHeaders = {
      'Authorization': 'fsq3Tz0b7lh6LtcyoIl2kbZFHMuAxGaAXs9veBuPglC2LU8='
    };
    var response = await client.get(uri, headers: requestHeaders);
    PlaceDetails? placeDetails;

    if (response.statusCode == 200) {
      var detail = jsonDecode(response.body);

      List<PlaceCategory> placeCategories = [];
      for (final each in detail["categories"]) {
        IconMap icon = IconMap(each['icon']['prefix'], each['icon']['suffix']);
        PlaceCategory placeCategory = PlaceCategory(each["name"], icon);
        placeCategories.add(placeCategory);
      }
      Location location = Location(
          detail['location']['address'],
          detail['location']['country'],
          detail['location']['cross_street'],
          detail['location']['formatted_address'],
          detail['location']['locality'],
          detail['location']['neighborhood'],
          detail['location']['postcode'],
          detail['location']['region']);

      final List photoList = detail['photos'] as List;

      List<Photo> photos = [];
      for (var each in photoList) {
        final photo = Photo(each['prefix'], each['suffix']);
        photos.add(photo);
      }
      placeDetails = PlaceDetails(
        detail['name'],
        photos,
        detail['rating'],
        placeCategories,
        detail['fsq_id'],
        detail['link'],
        location,
      );     
    }
    return placeDetails;
  }
}
