import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:marvel_hq/model/comic.dart';
import 'package:marvel_hq/services/api.dart';

class APIComics{

  Future<List<Comic>> getComics() async {
    API api = API();

    http.Response response = await http.get(api.gerarURL("comics"));

    if (response.statusCode == 200) {
      // print("resultado: " + response.body);
      Map<String, dynamic> dadosJson = json.decode(response.body);

      List<Comic> comics = dadosJson["data"]["results"].map<Comic>((map) {
        return Comic.fromJsom(map);
      }).toList();
     // print(dadosJson["data"]["results"].toString());
      return comics;
    } else {
      print("resultado:" + response.statusCode.toString());
    }
  }

  Future<List<Comic>> getSeries() async {
    API api = API();

    http.Response response = await http.get(api.gerarURL("series"));

    if (response.statusCode == 200) {
      // print("resultado: " + response.body);
      Map<String, dynamic> dadosJson = json.decode(response.body);

      List<Comic> comics = dadosJson["data"]["results"].map<Comic>((map) {
        return Comic.fromJsom(map);
      }).toList();
      // print(dadosJson["data"]["results"].toString());
      return comics;
    } else {
      print("resultado:" + response.statusCode.toString());
    }
  }
}