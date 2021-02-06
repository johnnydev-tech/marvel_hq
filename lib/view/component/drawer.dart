import 'package:flutter/material.dart';
import 'package:marvel_hq/view/home.dart';

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
                decoration: BoxDecoration(color: Colors.white12), child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png")
                )
              ),
            )),

          ],
        ),
      ),
    );
  }
}
