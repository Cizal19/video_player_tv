import 'package:flutter/material.dart';
import 'package:video_player_tv/screens/ChannelList.dart';
import 'package:video_player_tv/screens/Home.dart';
import 'package:video_player_tv/screens/ProfilePage.dart';
import 'package:video_player_tv/widgets/CategoryGrid.dart';

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      ProfileScreen(),
      Home(),
      CategoryGrid(),
      ChannelList(),
      ChannelList(),
      ChannelList(),
    ]);
  }
}
