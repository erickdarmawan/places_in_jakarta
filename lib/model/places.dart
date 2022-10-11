class Place {
  String name;
  Photo? photo;
  double? rating;
  List<PlaceCategory> categories;
  String fsq_id;
  // String link;
  // String location;
  Place(
    this.name,
    this.photo,
    this.rating,
    this.categories,
    this.fsq_id,
    // this.link, this.location
  );
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
