import 'package:flutter/material.dart';
import 'package:video_player_tv/widgets/CustomAppBar.dart';
import 'package:video_player_tv/widgets/CustomTabBarView.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      initialIndex: 1,
      child: Scaffold(
          appBar: CustomAppBar(
            context: context,
          ),
          body: CustomTabBarView()),
    );
  }
}
