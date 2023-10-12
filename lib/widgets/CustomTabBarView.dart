import 'package:flutter/material.dart';
import 'package:video_player_tv/screens/ChannelList.dart';

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      Center(
        child: Text("Profile Tab Content"),
      ),
      Center(
        child: Text("Home Tab Content"),
      ),
      Center(
        child: Text("Categories Tab Content"),
      ),
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
