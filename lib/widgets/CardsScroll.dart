import 'package:flutter/material.dart';
import 'package:video_player_tv/models/Channel.dart';
import 'package:video_player_tv/models/channels.api.dart';

class CardsScroll extends StatefulWidget {
  const CardsScroll({super.key});

  @override
  State<CardsScroll> createState() => _CardsScrollState();
}

class _CardsScrollState extends State<CardsScroll> {
  List<Channel> channels = [];
  List<Channel> list = [];
  @override
  void initState() {
    super.initState();
    getListItems();
  }

  Future<List<Channel>> getListItems() async {
    channels = await ChannelsApi.getChannels();
    list = channels.take(7).toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getListItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return Container(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 250.0, // Adjust card width as needed
                    // margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 4.0,
                      child: Column(
                        children: <Widget>[
                          Image.network(
                            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/${list[index].thumb}",
                            fit: BoxFit.cover,
                            height: 150.0,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              list[index].title,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
