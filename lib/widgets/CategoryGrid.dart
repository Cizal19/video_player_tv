import 'package:flutter/material.dart';
import 'package:video_player_tv/screens/CategoryPage.dart';

class CategoryGrid extends StatelessWidget {
  final List<String> categories = [
    'Action',
    'Drama',
    'Comedy',
    'Horror',
    'Fantasy',
    'Romance',
    'Documentary',
    'Animation',
    'Thriller',
    'Adventure',
  ];

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 16 / 9,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Focus(
            child: CategoryItem(
              categoryName: categories[index],
            ),
          );
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String categoryName;

  CategoryItem({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Define a map of background colors that complement the gold UI.
    Map<String, Color> categoryColors = {
      'Action': Colors.red,
      'Drama': Colors.blue,
      'Comedy': Colors.green,
      'Horror': Colors.purple,
      'Fantasy': Colors.orange,
      'Romance': Colors.pink,
      'Documentary': Colors.teal,
      'Animation': Colors.amber,
      'Thriller': Colors.indigo,
      'Adventure': Colors.deepOrange,
    };

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CategoryPage(title: categoryName);
        }));
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: categoryColors[categoryName], // Set the background color
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            categoryName,
            style: TextStyle(
              color: Colors.white, // Text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
