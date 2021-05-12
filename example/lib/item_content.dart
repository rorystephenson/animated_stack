import 'package:flutter/widgets.dart';

import 'item_data.dart';

class ItemContent extends StatelessWidget {
  static const double width = 150;
  static const double height = 75;

  final ItemData itemData;

  ItemContent(this.itemData);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: itemData.color,
      width: width,
      height: height,
      child: Text("Item at: (${itemData.x}, ${itemData.y})"),
    );
  }
}
