import 'package:flutter/widgets.dart';

import '../animated_stack_widget.dart';

/// Manages the children of an [AnimatedStack].
///
/// The [insert] and [removeAt] methods apply to both the internal list and
/// the animated list that belongs to [animatedStackKey].
///
class AnimatedStackManager<E> {
  AnimatedStackManager({
    required this.animatedStackKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedStackState> animatedStackKey;
  final RemovedItemBuilder<E> removedItemBuilder;
  final List<E> _items;

  AnimatedStackState? get _animatedStack => animatedStackKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedStack!.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedStack!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return removedItemBuilder(removedItem, context, animation);
        },
      );
    }
    return removedItem;
  }

  void clear() {
    for (var i = 0; i <= _items.length - 1; i++) {
      final item = _items[i];
      _animatedStack!.removeItem(
        0,
        (BuildContext context, Animation<double> animation) {
          return removedItemBuilder(item, context, animation);
        },
      );
    }
    _items.clear();
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

typedef RemovedItemBuilder<E> = Widget Function(
  E item,
  BuildContext context,
  Animation<double> animation,
);
