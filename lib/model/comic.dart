class Comic{
  String thumb;
  String extension;
  String title;

  Comic({this.title, this.thumb, this.extension });

  factory Comic.fromJsom(Map<String, dynamic> json) {
    return Comic(
      thumb: json["thumbnail"]["path"],
      title: json["title"],
      extension: json["thumbnail"]["extension"],
    );
  }
}