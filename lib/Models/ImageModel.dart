class Image {
  final int unit;
  final String image;

  Image({this.unit, this.image});

  factory Image.fromJson(Map<String, dynamic> parsedJson){
    return Image(
        unit:parsedJson['unit'],
        image:parsedJson['image']
    );
  }
}