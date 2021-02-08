import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:marvel_hq/view/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: "Marvel HQ'S",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.red,
      ),
      home: Home(),
    ),
  );
}
