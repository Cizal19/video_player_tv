import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key? key,
    IconButton? leading,
    TabBar? bottom,
    required BuildContext context,
  }) : super(
            key: key,
            title: Text("PlaySync"),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Profile", icon: Icon(Icons.person)),
                Tab(
                  text: "Home",
                  icon: Icon(Icons.home),
                ),
                Tab(
                  text: "Categories",
                  icon: Icon(Icons.category),
                ),
                Tab(text: "Movies", icon: Icon(Icons.movie)),
                Tab(text: "Shows", icon: Icon(Icons.tv)),
                Tab(text: "Channels", icon: Icon(Icons.live_tv))
              ],
            ));
}
