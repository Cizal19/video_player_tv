import 'package:flutter/material.dart';
import 'package:video_player_tv/screens/ChannelList.dart';
import 'package:video_player_tv/screens/Home.dart';
import 'package:video_player_tv/widgets/CategoryGrid.dart';

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      Center(
        child: Text("Profile Tab Content"),
      ),
      Home(),
      CategoryGrid(),
      Center(
        child: Text("Movies Tab Content"),
      ),
      Center(
        child: Text("Shows Tab Content"),
      ),
      ChannelList()
    ]);
  }
}
