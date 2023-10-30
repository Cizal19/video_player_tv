import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player_tv/models/Channel.dart';
import 'package:video_player_tv/models/channels.api.dart';
import 'package:video_player_tv/screens/VideoPlayerScreen.dart';

class HomePageCarousel extends StatefulWidget {
  const HomePageCarousel({super.key});

  @override
  State<HomePageCarousel> createState() => _HomePageCarouselState();
}

class _HomePageCarouselState extends State<HomePageCarousel> {
  List<Channel> channels = [];
  List<Channel> carouselList = [];
  @override
  void initState() {
    super.initState();
    getCarouselItems();
  }

  Future<List<Channel>> getCarouselItems() async {
    channels = await ChannelsApi.getChannels();
    carouselList = channels.take(5).toList();
    return carouselList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Channel>>(
        future: getCarouselItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return CarouselSlider(
              options: CarouselOptions(
                height: 350.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
              items: carouselList.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/${item.thumb}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(
                                      0.0), // Transparent background
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      item.title,
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                        focusNode:
                                            FocusNode(canRequestFocus: true),
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return VideoPlayerScreen(
                                                videoUrl: item.sources[0]);
                                          }));
                                        },
                                        icon: Icon(
                                          Icons.play_arrow,
                                          size: 36.0,
                                          color: Colors.black,
                                        ),
                                        label: Text(
                                          "Watch Now",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors
                                                .white, // Button background color
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ));
                  },
                );
              }).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
