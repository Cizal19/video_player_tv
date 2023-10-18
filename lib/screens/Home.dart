import 'package:flutter/material.dart';
import 'package:video_player_tv/widgets/CardsScroll.dart';
import 'package:video_player_tv/widgets/HomePageCarousel.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Featured".toUpperCase(),
            style: TextStyle(
                color: Colors.grey[700], fontSize: 20.0, letterSpacing: 2.0),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        HomePageCarousel(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.arrow_upward,
                color: Colors.red,
              ),
              const SizedBox(
                width: 2.0,
              ),
              Text(
                "Trending".toUpperCase(),
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20.0,
                    letterSpacing: 2.0),
              ),
            ],
          ),
        ),
        CardsScroll(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.thumb_up,
                color: Colors.red,
              ),
              const SizedBox(
                width: 2.0,
              ),
              Text(
                "Recommended".toUpperCase(),
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20.0,
                    letterSpacing: 2.0),
              ),
            ],
          ),
        ),
        // CardsScroll(),
      ]),
    );
  }
}
