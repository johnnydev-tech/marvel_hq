import 'package:flutter/material.dart';
import 'package:marvel_hq/view/home.dart';

void main() => runApp(MaterialApp(
      title: "Marvel HQ'S",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.red,
      ),
      home: Home(),
    ));
