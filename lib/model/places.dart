import 'package:flutter/foundation.dart';

class Place {
  String name;
  Photo? photo;
  double? rating;
  List<PlaceCategory> categories;
  String fsq_id;
  String link;
  String location;
  Place(this.name, this.photo, this.rating, this.categories, this.fsq_id,
      this.link, this.location);
}

class Photo {
  String prefix;
  String suffix;
  Photo(this.prefix, this.suffix);

  String constructImageUrl() {
    return prefix + '400x500' + suffix;
  }
}

class PlaceCategory {
  String name;
  IconMap icon;
  PlaceCategory(this.name, this.icon);
}

class IconMap {
  String prefix;
  String suffix;
  IconMap(this.prefix, this.suffix);

  String constructIcon() {
    return prefix + '44' + suffix;
  }
}

class GetPlaceDetails {
  String fsq_id;

  Map location;

  GetPlaceDetails(this.fsq_id, this.location);
}

class Location {
  String address;
  String country;
  String? cross_street;
  String formatted_address;
  String locality;
  List neighborhood;
  int postcode;
  String region;
  Location(
    this.address,
    this.country,
    this.cross_street,
    this.formatted_address,
    this.locality,
    this.neighborhood,
    this.postcode,
    this.region,
  );
}
