import 'package:flutter/material.dart';
import 'package:marvel_hq/controller/comicsController.dart';
import 'package:marvel_hq/model/comic.dart';

import 'component/drawer.dart';

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
        title: Image.asset(
          "assets/images/logo.png",
          height: 35,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(  color: Colors.red ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.shopping_cart,

              ),
              onPressed: () {})
        ],
      ),
      drawer: CustomDrawer(),
      body: Container(
        height: _tela.height,
        width: _tela.width,
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Text(
                "Veja Alguns Titulos de HQ's",
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
                      return GridView.builder(
                          shrinkWrap: true,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: .55,
                          ),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            List<Comic> lista = snapshot.data;
                            Comic comic = lista[index];

                            return Container(
                              child: InkWell(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(2),
                                  topRight: Radius.circular(2),
                                ),
                                splashColor: Colors.red.withOpacity(.5),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(2),
                                            topRight: Radius.circular(2),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "${comic.thumb}.${comic.extension}"),
                                            fit: BoxFit.cover,
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
                                            bottomLeft: Radius.circular(2),
                                            bottomRight: Radius.circular(2),
                                          ),
                                        ),
                                        child: Text(
                                          comic.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ))
                                  ],
                                ),
                                onTap: () {},
                              ),
                            );
                          });
                    }
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
