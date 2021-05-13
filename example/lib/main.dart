import 'package:animated_stack_widget/animated_stack_widget.dart';
import 'package:animated_stack_widget_example/sliding_item.dart';
import 'package:flutter/material.dart';

import 'fading_item.dart';
import 'item_data.dart';

void main() {
  runApp(AnimatedStackExample());
}

class AnimatedStackExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimatedStack Demo',
      home: AnimatedStackExampleHomePage(title: 'AnimatedStack Demo'),
    );
  }
}

class AnimatedStackExampleHomePage extends StatefulWidget {
  AnimatedStackExampleHomePage({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _AnimatedStackExampleHomePageState createState() =>
      _AnimatedStackExampleHomePageState();
}

class _AnimatedStackExampleHomePageState
    extends State<AnimatedStackExampleHomePage> {
  final GlobalKey<AnimatedStackState> _animatedStackKey =
      GlobalKey<AnimatedStackState>();
  late AnimatedStackManager<ItemData> _animatedStackManager;

  @override
  void initState() {
    super.initState();
    _animatedStackManager = AnimatedStackManager<ItemData>(
      animatedStackKey: _animatedStackKey,
      removedItemBuilder: _buildRemovedItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete_sweep),
        onPressed: () => _animatedStackManager.clear(),
      ),
      body: Center(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: (tapDetails) {
            _insert(tapDetails.localPosition.dx, tapDetails.localPosition.dy);
          },
          child: Container(
            child: LayoutBuilder(
              builder: (context, constraints) => AnimatedStack(
                key: _animatedStackKey,
                initialItemCount: 0,
                itemBuilder: (context, index, animation) =>
                    _buildItem(context, index, animation, constraints),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index,
      Animation<double> animation, BoxConstraints constraints) {
    return SlidingItem(
      itemData: _animatedStackManager[index],
      animation: animation,
      onTap: () => _remove(_animatedStackManager[index]),
      constraints: constraints,
    );
  }

  Widget _buildRemovedItem(
      ItemData itemData, BuildContext context, Animation<double> animation) {
    return FadingItem(
      itemData: itemData,
      animation: animation,
    );
  }

  void _insert(double x, double y) {
    _animatedStackManager.insert(
        _animatedStackManager.length, ItemData(x: x, y: y));
  }

  void _remove(ItemData item) {
    final index = _animatedStackManager.indexOf(item);
    _animatedStackManager.removeAt(index);
  }
}
