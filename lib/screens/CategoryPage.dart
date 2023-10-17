import 'package:flutter/material.dart';
import 'package:video_player_tv/screens/ChannelList.dart';

class CategoryPage extends StatelessWidget {
  final String title;

  CategoryPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ChannelList());
  }
}
