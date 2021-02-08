import 'package:flutter/material.dart';
import 'package:marvel_hq/controller/comicsController.dart';
import 'package:marvel_hq/model/comic.dart';
import 'package:marvel_hq/view/details.dart';
import 'package:marvel_hq/view/shoppingCart.dart';

import 'component/drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Size _tela;
  APIComics api = APIComics();

  ComicsGet() {
    return api.getComics();
  }

  SeriesGet() {
    return api.getSeries();
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
        title: Image.asset(
          "assets/images/logo.png",
          height: 35,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.red),
        actions: [
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ShoppingCart(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = Offset(0.0, 1.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ));
              }),
        ],
      ),
      drawer: CustomDrawer(),
      body: Container(
        height: _tela.height,
        width: _tela.width,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                "Principais HQ's",
                softWrap: true,
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
            FutureBuilder(
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
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.red),
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
                      return Container(
                        height: 320,
                        width: _tela.width,
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              List<Comic> lista = snapshot.data;
                              Comic comic = lista[index];

                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                width: 180,
                                child: InkWell(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3),
                                    topRight: Radius.circular(3),
                                  ),
                                  splashColor: Colors.red.withOpacity(.5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: Colors.white24,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(3),
                                              topRight: Radius.circular(3),
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "${comic.thumb}.${comic.extension}"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 5),
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white10,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(3),
                                            bottomRight: Radius.circular(3),
                                          ),
                                        ),
                                        child: Text(
                                          comic.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          softWrap: true,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Details(
                                          description: comic.description,
                                          title: comic.title,
                                          thumb: comic.thumb,
                                          extention: comic.extension,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                      );
                    }
                    break;
                }
                return Container();
              },
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                "Principais comics Series",
                softWrap: true,
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
            FutureBuilder(
              future: SeriesGet(),
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
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.red),
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
                      return Container(
                        height: 320,
                        width: _tela.width,
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              List<Comic> lista = snapshot.data;
                              Comic comic = lista[index];

                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                width: 180,
                                child: InkWell(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3),
                                    topRight: Radius.circular(3),
                                  ),
                                  splashColor: Colors.red.withOpacity(.5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: Colors.white24,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(3),
                                              topRight: Radius.circular(3),
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "${comic.thumb}.${comic.extension}"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 5),
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white10,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(3),
                                            bottomRight: Radius.circular(3),
                                          ),
                                        ),
                                        child: Text(
                                          comic.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          softWrap: true,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Details(
                                          description: comic.description,
                                          title: comic.title,
                                          thumb: comic.thumb,
                                          extention: comic.extension,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                      );
                    }
                    break;
                }
                return Container();
              },
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
