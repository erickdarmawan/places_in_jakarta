import 'package:places_in_jakarta/model/model.dart';

class PlaceDetails {
  String name;
  Photo? photo;
  double? rating;
  List<PlaceCategory> categories;
  String fsq_id;
  String link;
  Location? location;

  var icon;
  PlaceDetails(
    this.name,
    this.photo,
    this.rating,
    this.categories,
    this.fsq_id,
    this.link,
    this.location,
  );
}

class Location {
  String? address;
  String? country;
  String? cross_street;
  String? formatted_address;
  String? locality;
  List? neighborhood;
  String? postcode;
  String? region;
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
