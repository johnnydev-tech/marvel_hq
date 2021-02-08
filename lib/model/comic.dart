class Comic {
  String id;
  String thumb;
  String extension;
  String title;
  String description;


  Comic({this.title, this.description, this.thumb, this.extension, this.id});

  factory Comic.fromJsom(Map<String, dynamic> json) {
    return Comic(
      thumb: json["thumbnail"]["path"],
      title: json["title"],
      id: json["title"],
      description: json["description"],
      extension: json["thumbnail"]["extension"],
    );
  }
}
