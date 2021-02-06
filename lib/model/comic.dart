class Comic{
  String thumb;
  String extension;

  Comic({this.thumb, this.extension });

  factory Comic.fromJsom(Map<String, dynamic> json) {
    return Comic(
      thumb: json["thumbnail"]["path"],
      extension: json["thumbnail"]["extension"],
    );
  }
}