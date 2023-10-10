import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show LogicalKeyboardKey, RawKeyDownEvent, rootBundle;
import 'package:video_player_tv/models/Channel.dart';
import 'package:video_player_tv/screens/VideoPlayerScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Channel>> channelsFuture;
  int selectedItemIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    channelsFuture = loadChannels();
  }

  static Future<List<Channel>> loadChannels() async {
    final jsonString = await rootBundle.loadString('lib/data/videos.json');
    final data = json.decode(jsonString);

    List dataList = [];

    if (data['videos'] != null) {
      for (var i = 0; i < data["videos"].length; i++) {
        dataList.add(data["videos"][i]);
      }
    }

    return Channel.channelsFromSnapshot(dataList);
  }

  void handleUpNavigation(List<Channel> list) {
    if (selectedItemIndex > 0) {
      setState(() {
        selectedItemIndex--;
      });
      _scrollToItem(selectedItemIndex);
    }
  }

  void handleDownNavigation(List<Channel> list) {
    if (selectedItemIndex < list.length - 1) {
      setState(() {
        selectedItemIndex++;
      });
      _scrollToItem(selectedItemIndex);
    }
  }

  void handleSelect(List<Channel> list) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return VideoPlayerScreen(videoUrl: list[selectedItemIndex].sources[0]);
    }));
  }

  void _scrollToItem(int index) {
    _scrollController.animateTo(
      index * 50, // Adjust as needed
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Channel List"),
      ),
      body: Material(
        child: FutureBuilder(
          future: channelsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var list = snapshot.data;
              return FocusTraversalGroup(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: (list == null) ? 0 : snapshot.data!.length,
                  itemBuilder: (item, index) {
                    return Focus(
                      onKey: (node, event) {
                        if (event is RawKeyDownEvent) {
                          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                            handleUpNavigation(list!);
                          } else if (event.logicalKey ==
                              LogicalKeyboardKey.arrowDown) {
                            handleDownNavigation(list!);
                          } else if (event.logicalKey ==
                              LogicalKeyboardKey.select) {
                            handleSelect(list!);
                          }
                        }
                        return KeyEventResult.handled;
                      },
                      child: Card(
                        color: selectedItemIndex == index
                            ? Colors.blue // Highlight the selected item
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.network(
                              "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/${snapshot.data![index].thumb}",
                              height: 100,
                            ),
                            title: Text(snapshot.data![index].title),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
