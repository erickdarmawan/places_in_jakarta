import 'package:flutter/foundation.dart';

class Place {
  String name;
  //List<Photo?> photo;
  Photo? photo;
  double? rating;
  List<PlaceCategory> categories;

  Place(this.name, this.photo, this.rating, this.categories);
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
}
