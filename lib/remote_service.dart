import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:places_in_jakarta/model/model.dart';

class callService {
  Future<List<Place>> getPlaceList() async {
    Map<String, String> requestHeaders = {
      'Authorization': 'fsq3Tz0b7lh6LtcyoIl2kbZFHMuAxGaAXs9veBuPglC2LU8='
    };
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.foursquare.com/v3/places/search?query=jakarta&fields=rating,name,photos,fsq_id,categories');
    var response = await client.get(uri, headers: requestHeaders);
    //print('DEBUG BODY ${response.body}');

    if (response.statusCode == 200) {
      var place = json.decode(response.body);
      var results = place['results'] as List;
      List<Place> placeList = [];

      for (var result in results) {
        //List<Photo> photo = [];
        Photo? photo;
        List photoResult = result['photos'];
        if (photoResult.isNotEmpty) {
          //photo = Photo(
          //[0]['prefix'], result['photos'][0]['suffix']);
          //photo = photoResult[0]['prefix'] + photoResult[0]['suffix'];
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

        // for (var locate in result['location']) {
        //   var crossStreet = result['cross_street'];
        //   if (crossStreet.isNotEmpty) {
        //     crossStreet.add(locate);
        //     Location _location = Location(
        //         locate['address'],
        //         locate['country'],
        //         locate['cross street'],
        //         locate['formatted address'],
        //         locate['locality'],
        //         locate['neighorhood'],
        //         locate['postcode'],
        //         locate['region']);
        //     GetPlaceDetails getPlaceDetails =
        //         GetPlaceDetails(locate['fsq_id'], locate['location']);
        //     // placeDetails.add(getPlaceDetails);
        //   }
        // }

        // var locate = Location(
        //     result['address'],
        //     result['country'],
        //     result['cross_street'],
        //     result['formatted_address'],
        //     result['locality'],
        //     result['neighborhood'],
        //     result['postcode'],
        //     result['region']);

        var place = Place(result['name'], photo, result['rating'], categories,
            result['fsq_id'], result['link'], result['location']);

        placeList.add(place);
      }
      // print(placeList.map((e) => e.name));

      return placeList;
    } else {
      return [];
    }
  }
}
