import 'package:flutter/material.dart';
import 'package:marvel_hq/controller/comicsController.dart';
import 'package:marvel_hq/model/comic.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Size _tela;
  APIComics api = APIComics();

  ComicsGet() {
    return api.get();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ComicsGet();
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
      body: Container(
        height: _tela.height,
        width: _tela.width,
        child: FutureBuilder(
          future: ComicsGet(),
          builder: (context, snapshot) {
            // ignore: missing_return
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Text("Sem Conexão"),
                );
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                );
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text("ERROR"),
                  );
                } else {
                  return GridView.builder(
                      shrinkWrap: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {

                        List<Comic> lista = snapshot.data;
                        Comic comic = lista[index];

                        return Container(
                          child: Image.network("${comic.thumb}.${comic.extension}"),
                        );
                      });
                }
                break;
            }
          },
        ),
      ),
    );
  }
}
