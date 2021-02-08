import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marvel_hq/view/shoppingCart.dart';

class Details extends StatefulWidget {
  final String title;
  final String description;
  final String thumb;
  final String extention;

  const Details(
      {Key key, this.title, this.description, this.thumb, this.extention})
      : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Size _tela;

  @override
  Widget build(BuildContext context) {
    _tela = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Detalhes"),
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: _tela.width,
                height: _tela.height * .4,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.only(),
                  image: DecorationImage(
                    image: NetworkImage("${widget.thumb}.${widget.extention}"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    widget.description == null
                        ? Text(
                            "Esste conteúdo não descrição",
                            style:
                                TextStyle(fontSize: 14, color: Colors.white70),
                          )
                        : Text(
                            widget.description,
                            style:
                                TextStyle(fontSize: 14, color: Colors.white70),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton.icon(
                      color: Colors.red,
                      textColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      icon: Icon(Icons.add_shopping_cart),
                      label: Text(
                        "Adicionar no Carrinho",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          Map<String, dynamic> comics = Map();
                            comics["title"]= widget.title;
                            comics["thumb"]= widget.thumb;
                            comics["extention"] = widget.extention;
                            comics["qtde"] = 1;
                          _db.collection("comics").add(comics);
                          final snackbar = new SnackBar(content: Text("Adicionado no Carrinho!"));
                          _scaffoldKey.currentState.showSnackBar(snackbar);
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
