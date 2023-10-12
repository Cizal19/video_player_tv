import 'package:flutter/material.dart';
import 'package:video_player_tv/widgets/CardsScroll.dart';
import 'package:video_player_tv/widgets/HomePageCarousel.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [HomePageCarousel(), CardsScroll()]),
    );
  }
}
