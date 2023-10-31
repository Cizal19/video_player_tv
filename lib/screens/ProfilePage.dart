import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ProfileAvatarCard(),
          ),
          Expanded(
            flex: 2,
            child: ProfileInfoCard(),
          ),
        ],
      ),
    );
  }
}

class ProfileAvatarCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 100.0,
              child: Icon(
                Icons.person,
                size: 120.0,
                color: Colors.white,
              ),
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.blue,
              ),
              title: Text('JohnDoe'),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text('john.doe@example.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blue),
              title: Text('+1234567890'),
            ),
            ListTile(
              leading: Icon(Icons.wc, color: Colors.blue),
              title: Text('Male'),
            )
          ],
        ),
      ),
    );
  }
}
