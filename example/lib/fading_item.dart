import 'package:flutter/widgets.dart';

import 'item_content.dart';
import 'item_data.dart';

class FadingItem extends StatelessWidget {
  final ItemData itemData;
  final Animation<double> animation;
  final VoidCallback? onTap;

  FadingItem({
    required this.itemData,
    required this.animation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: itemData.y,
      left: itemData.x,
      child: _tapHandler(
        child: FadeTransition(
          opacity: animation.drive((CurveTween(curve: Curves.bounceInOut))),
          child: ItemContent(itemData),
        ),
      ),
    );
  }

  Widget _tapHandler({required Widget child}) {
    if (onTap == null) {
      return IgnorePointer(child: child);
    } else {
      return GestureDetector(onTap: onTap, child: child);
    }
  }
}
