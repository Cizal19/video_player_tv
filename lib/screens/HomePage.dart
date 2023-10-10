import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:video_player_tv/models/Channel.dart';
import 'package:video_player_tv/screens/VideoPlayerScreen.dart';

class HomePage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Channel List"),
      ),
      body: Material(
        child: FutureBuilder(
          future: loadChannels(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var list = snapshot.data;
              return ListView.builder(
                  itemCount: (list == null) ? 0 : snapshot.data!.length,
                  itemBuilder: (item, index) {
                    return MaterialButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return VideoPlayerScreen(
                                videoUrl: snapshot.data![index].sources[0]);
                          }));
                        },
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.network(
                                "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/${snapshot.data![index].thumb}",
                                height: 100),
                            title: Text(snapshot.data![index].title),
                          ),
                        )));
                  });
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
