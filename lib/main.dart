import 'package:flutter/material.dart';
import 'package:video_player_tv/screens/Main.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Main(),
    theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xffffd700),
        ),
        focusColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
        tabBarTheme: TabBarTheme(
            labelColor: const Color.fromARGB(255, 10, 137, 240),
            indicatorColor: Colors.blue,
            unselectedLabelColor: Color(0xff36454f))),
  ));
}
