import 'dart:math' as math;
import 'package:flutter/widgets.dart';

@immutable
class ItemData {
  final double x;
  final double y;
  final Color color;

  ItemData({required this.x, required this.y,})
      : this.color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}