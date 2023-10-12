import 'package:flutter/material.dart';
import 'package:video_player_tv/screens/ChannelList.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChannelList(),
    theme: ThemeData(
        appBarTheme: AppBarTheme(
      color: Color(0xffffd700),
    )),
  ));
}
