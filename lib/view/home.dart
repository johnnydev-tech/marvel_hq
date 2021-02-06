import 'package:flutter/material.dart';
import 'package:marvel_hq/controller/comicsController.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Size _tela;
  APIComics api = APIComics();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    api.get();
  }
  @override
  Widget build(BuildContext context) {
    _tela = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("MARVEL"),
        centerTitle: true,
      ),
      body:Container(
        height: _tela.height,
        width: _tela.width,

      ) ,
    );
  }
}
