import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _controller = StreamController<QuerySnapshot>.broadcast();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  _comics() async {
    final stream = _db.collection("comics").snapshots();
    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  _excluir(String idComic) {
    _db.collection("comics").doc(idComic).delete();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _comics();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho de Compras"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<QuerySnapshot>(
            stream: _controller.stream,
            // ignore: missing_return
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  QuerySnapshot querySnapshot = snapshot.data;
                  List<DocumentSnapshot> locations =
                      querySnapshot.docs.toList();
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Carrinho Vazio"),
                    );
                  } else {
                    return ListView.builder(
                        padding: EdgeInsets.only(bottom: 75),
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot item = locations[index];
                          String id = item.id;
                          String title = item["title"];
                          String thumb = item["thumb"];
                          String extention = item["extention"];
                          int qtde = item["qtde"];

                          return Column(
                            children: [
                              Container(
                                height: 110,
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 8),
                                      child: Image.network(
                                        "${thumb}.${extention}",
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    title,
                                                    style: TextStyle(
                                                        color: Colors.grey[900],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 2,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          color: Colors.black,
                                                          icon: Icon(
                                                              Icons.remove),
                                                          onPressed: () {
                                                            setState(() {
                                                              if (qtde > 1) {
                                                                setState(() {
                                                                  qtde--;
                                                                  Map<String,
                                                                          dynamic>
                                                                      comics =
                                                                      Map();
                                                                  comics["qtde"] =
                                                                      qtde;
                                                                  _db
                                                                      .collection(
                                                                          "comics")
                                                                      .doc(id)
                                                                      .update(
                                                                          comics);
                                                                });
                                                              }
                                                            });
                                                          }),
                                                      Container(
                                                        height: 35,
                                                        width: 35,
                                                        alignment:
                                                            Alignment.center,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          color:
                                                              Colors.grey[100],
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        child: Text(
                                                          qtde.toString(),
                                                        ),
                                                      ),
                                                      IconButton(
                                                          icon: Icon(Icons.add),
                                                          onPressed: () {
                                                            qtde++;
                                                            setState(() {
                                                              Map<String,
                                                                      dynamic>
                                                                  comics =
                                                                  Map();
                                                              comics["qtde"] =
                                                                  qtde;
                                                              _db
                                                                  .collection(
                                                                      "comics")
                                                                  .doc(id)
                                                                  .update(
                                                                      comics);
                                                            });
                                                            print(qtde
                                                                .toString());
                                                          }),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete_forever,
                                              size: 35,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              _excluir(id);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider()
                            ],
                          );
                        });
                  }
                  break;
              }
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.shopping_cart),
        label: Text("Confirmar Compra"),
        onPressed: (){

        },
      ),
    );
  }
}
