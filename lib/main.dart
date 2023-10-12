import 'package:flutter/material.dart';
import 'package:video_player_tv/screens/ChannelList.dart';
import 'package:video_player_tv/screens/Home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData(
        appBarTheme: AppBarTheme(
      color: Color(0xffffd700),
    )),
  ));
}
