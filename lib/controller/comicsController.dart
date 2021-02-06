import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:marvel_hq/services/api.dart';

class APIComics{

  Future<List> get() async {
    API api = API();

    http.Response response = await http.get(api.gerarURL());

    if (response.statusCode == 200) {
      // print("resultado: " + response.body);
      Map<String, dynamic> dadosJson = json.decode(response.body);
      //
      // List<Anuncio> anuncios = dadosJson["anuncios"].map<Anuncio>((map) {
      //   return Anuncio.fromJsom(map);
      // }).toList();
      print(dadosJson["data"]["results"].toString());
     // return anuncios;
    } else {
      print("resultado:" + response.statusCode.toString());
    }
  }
}