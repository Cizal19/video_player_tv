import 'package:flutter/material.dart';
import 'package:video_player_tv/screens/HomePage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(
        appBarTheme: AppBarTheme(
      color: Color(0xffffd700),
    )),
  ));
}
