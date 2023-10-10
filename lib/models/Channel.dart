class Channel {
  String title;
  String description;
  String thumb;
  String subtitle;
  List sources;
  Channel(
      {required this.title,
      required this.description,
      required this.thumb,
      required this.sources,
      required this.subtitle});

  factory Channel.fromJson(Map<dynamic, dynamic> json) {
    return Channel(
        title: json['title'] as String,
        description: json['description'] as String,
        thumb: json['thumb'] as String,
        sources: json['sources'] as List,
        subtitle: json['subtitle'] as String);
  }

  static List<Channel> channelsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Channel.fromJson(data);
    }).toList();
  }
}
