import 'package:flutter/material.dart';

class AnimatedItem extends InheritedWidget {
  final double animation;
  final bool logAnimationValue;
  const AnimatedItem(
      {Key? key,
      this.animation = 1.0,
      this.logAnimationValue = false,
      required Widget child})
      : super(key: key, child: child);

  static AnimatedItem? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AnimatedItem>();
  }

  @override
  bool updateShouldNotify(AnimatedItem oldWidget) {
    return true;
  }
}
