import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:video_player_tv/models/Channel.dart';

class ChannelsApi {
  static Future<List<Channel>> getCarouselItems() async {
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
}
