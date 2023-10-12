import 'package:flutter/material.dart';
import 'package:video_player_tv/widgets/CustomAppBar.dart';
import 'package:video_player_tv/widgets/CustomTabBarView.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
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
