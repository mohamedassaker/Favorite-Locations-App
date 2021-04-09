class Favorite{
  String locationName;
  String theme;
  String fullDesc;
  String imageurl;
  String locationurl;

  Favorite(
      this.locationName,
      this.theme,
      this.fullDesc,
      this.imageurl,
      this.locationurl
      );

  Map<String, dynamic> toJson() => {
    'locationName': locationName,
    'theme': theme,
    'fullDesc': fullDesc,
    'imageurl': imageurl,
    'locationurl': locationurl,
  };
}