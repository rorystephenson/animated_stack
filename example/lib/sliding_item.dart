import 'dart:math';

import 'package:flutter/material.dart';

import 'item_content.dart';
import 'item_data.dart';

class SlidingItem extends StatelessWidget {
  final ItemData itemData;
  final Animation<double> animation;
  final BoxConstraints constraints;
  final VoidCallback? onTap;

  SlidingItem({
    required this.itemData,
    required this.animation,
    required this.constraints,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: animation.drive((CurveTween(curve: Curves.elasticOut))).drive(
            RelativeRectTween(
              begin: _begin,
              end: _end,
            ),
          ),
      child: _tapHandler(
        child: Align(
          alignment: Alignment.topLeft,
          child: ItemContent(itemData),
        ),
      ),
    );
  }

  RelativeRect get _begin => RelativeRect.fromLTRB(
        -ItemContent.width,
        -ItemContent.height,
        0,
        0,
      );

  RelativeRect get _end => RelativeRect.fromLTRB(
        itemData.x,
        itemData.y,
        min(0.0, constraints.maxWidth - itemData.x - ItemContent.width * 2),
        min(0.0, constraints.maxHeight - itemData.y - ItemContent.height * 2),
      );

  Widget _tapHandler({required Widget child}) {
    if (onTap == null) {
      return IgnorePointer(child: child);
    } else {
      return GestureDetector(onTap: onTap, child: child);
    }
  }
}
