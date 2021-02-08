import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.white12),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"))),
              ),
            ),

            FlatButton(
                padding: EdgeInsets.all(16.0),
                colorBrightness: Brightness.dark,
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      semanticLabel: "Carrinho de compras",
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left:16.0),
                      child: Text("Meu Carrinho", style: TextStyle(fontSize: 18),),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
