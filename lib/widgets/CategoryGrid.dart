import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class CategoryItem extends StatefulWidget {
  final String categoryName;

  CategoryItem({required this.categoryName});

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  final FocusNode _focusNode = FocusNode();
  bool isSelected = false;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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

    return FocusTraversalGroup(
      child: Focus(
        focusNode: _focusNode,
        onKey: (node, event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.select) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CategoryPage(title: widget.categoryName);
              }));
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
        child: Builder(
          builder: (context) {
            if (Focus.of(context).hasPrimaryFocus) {
              isSelected = true;
            } else {
              isSelected = false;
            }
            return InkWell(
              onTap: () {
                _focusNode.requestFocus();
              },
              child: Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: categoryColors[
                      widget.categoryName], // Set the background color
                  borderRadius: BorderRadius.circular(8.0),
                  border: isSelected
                      ? Border.all(
                          color: Colors.blue, // Border color for selected item
                          width: 2.0, // Border width
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    widget.categoryName,
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


// class CategoryItem extends StatefulWidget {
//   final String categoryName;

//   CategoryItem({required this.categoryName});

//   @override
//   _CategoryItemState createState() => _CategoryItemState();
// }

// class _CategoryItemState extends State<CategoryItem> {
//   bool isSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     // Define a map of background colors that complement the gold UI.
//     Map<String, Color> categoryColors = {
//       'Action': Colors.red,
//       'Drama': Colors.blue,
//       'Comedy': Colors.green,
//       'Horror': Colors.purple,
//       'Fantasy': Colors.orange,
//       'Romance': Colors.pink,
//       'Documentary': Colors.teal,
//       'Animation': Colors.amber,
//       'Thriller': Colors.indigo,
//       'Adventure': Colors.deepOrange,
//     };

//     return InkWell(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return CategoryPage(title: widget.categoryName);
//         }));
//       },
//       onFocusChange: (hasFocus) {
//         setState(() {
//           isSelected = hasFocus;
//         });
//       },
//       child: Focus(
//         child: Container(
//           margin: EdgeInsets.all(8.0),
//           padding: EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color:
//                 categoryColors[widget.categoryName], // Set the background color
//             borderRadius: BorderRadius.circular(8.0),
//             border: isSelected
//                 ? Border.all(
//                     color: Colors.blue, // Border color for selected item
//                     width: 2.0, // Border width
//                   )
//                 : null,
//           ),
//           child: Center(
//             child: Text(
//               widget.categoryName,
//               style: TextStyle(
//                 color: Colors.white, // Text color
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
