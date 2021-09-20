import 'package:flutter/material.dart';

class AnimatedPageItem extends InheritedWidget {
  final double animation;
  final bool logAnimationValue;
  const AnimatedPageItem(
      {Key? key,
      this.animation = 1.0,
      this.logAnimationValue = false,
      required Widget child})
      : super(key: key, child: child);

  static AnimatedPageItem? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AnimatedPageItem>();
  }

  @override
  bool updateShouldNotify(AnimatedPageItem oldWidget) {
    return true;
  }
}
