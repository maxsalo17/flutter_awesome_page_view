import 'dart:math';

import 'package:awesome_onboading/ui/components/animated_page_item.dart';
import 'package:flutter/material.dart';

class ParalaxItem {
  final Widget child;
  final double depth;
  final Paralax paralax;

  ParalaxItem(
      {required this.child,
      this.depth = 1.0,
      this.paralax = const RotatedParalax()});
}

abstract class Paralax {
  Widget getTransformedWidget(
      {required Widget child,
      double animationX = 0.0,
      double animationY = 0.0,
      double? width,
      double? height,
      double depth = 0.0,
      double maxDepth = 100.0,
      Paralax? parent});
}

class NoneParalax implements Paralax {
  const NoneParalax();
  Widget getTransformedWidget(
      {required Widget child,
      double animationX = 0.0,
      double animationY = 0.0,
      double? width,
      double? height,
      double depth = 0.0,
      double maxDepth = 100.0,
      Paralax? parent}) {
    if (parent != null)
      return parent.getTransformedWidget(
          animationX: animationX,
          animationY: animationY,
          width: width,
          height: height,
          depth: depth,
          maxDepth: maxDepth,
          child: child);
    else
      return child;
  }
}

class RotatedParalax implements Paralax {
  final double rotationSweepAngle;

  const RotatedParalax({
    this.rotationSweepAngle = 90.0,
  });

  Matrix4 _getTransform(double angle, double depth, double maxDepth) {
    return Matrix4.identity()
      // ..scale(1.0 - (1 / maxDepth * depth))
      ..setEntry(3, 2, 0.005)
      ..rotateY((max(-rotationSweepAngle, min(angle, rotationSweepAngle)) /
              rotationSweepAngle) *
          (pi));
  }

  _getAngleFromAnimValue(
    double animation,
  ) {
    return animation * rotationSweepAngle;
  }

  Widget getTransformedWidget(
      {required Widget child,
      double animationX = 0.0,
      double animationY = 0.0,
      double? width,
      double? height,
      double depth = 0.0,
      double maxDepth = 100.0,
      Paralax? parent}) {
    final _child = Transform(
        transform:
            _getTransform(_getAngleFromAnimValue(animationX), depth, maxDepth),
        alignment: FractionalOffset.center,
        child: child);
    if (parent != null)
      return parent.getTransformedWidget(
          animationX: animationX,
          animationY: animationY,
          width: width,
          height: height,
          depth: depth,
          maxDepth: maxDepth,
          child: _child);
    else
      return _child;
  }
}

class SlideParalax implements Paralax {
  const SlideParalax();

  Widget getTransformedWidget(
      {required Widget child,
      double animationX = 0.0,
      double animationY = 0.0,
      double? width,
      double? height,
      double depth = 0.0,
      double maxDepth = 100.0,
      Paralax? parent}) {
    final offset = animationX * depth * (width ?? 0.0);
    final _child = Positioned.fill(left: offset, right: -offset, child: child);
    if (parent != null)
      return parent.getTransformedWidget(
          animationX: animationX,
          animationY: animationY,
          width: width,
          height: height,
          depth: depth,
          maxDepth: maxDepth,
          child: _child);
    else
      return _child;
  }
}

class ScrollParalax implements Paralax {
  const ScrollParalax();

  Widget getTransformedWidget(
      {required Widget child,
      double animationX = 0.0,
      double animationY = 0.0,
      double? width = 0.0,
      double? height = 0.0,
      double depth = 0.0,
      double maxDepth = 100.0,
      Paralax? parent}) {
    final offset = animationX * (width! - (1000 / max(depth + 1.0, 1.0)));
    final _child = Positioned.fill(left: offset, right: -offset, child: child);
    if (parent != null)
      return parent.getTransformedWidget(
          animationX: animationX,
          animationY: animationY,
          width: width,
          height: height,
          depth: depth,
          maxDepth: maxDepth,
          child: _child);
    else
      return _child;
  }
}

class ParalaxPage extends StatelessWidget {
  final List<ParalaxItem> items;
  final Color backgroundColor;
  final BoxDecoration? decoration;
  final Paralax paralax;
  final double maxDepth;
  final Widget Function(BuildContext, double)? frontBuilder;
  const ParalaxPage(
      {Key? key,
      this.items = const [],
      this.backgroundColor = Colors.transparent,
      this.decoration,
      this.paralax = const SlideParalax(),
      this.maxDepth = 20.0,
      this.frontBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation = AnimatedItem.of(context)?.animation ?? 0.0;
    var _items = [...items];
    _items.sort((a, b) => a.depth.compareTo(b.depth));
    _items = _items.reversed.toList();
    return ClipRRect(
      child: Container(
        decoration: decoration ??
            BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: const Color(0xFFCCCCCC))),
        child: LayoutBuilder(builder: (context, constr) {
          return Stack(children: [
            ...List.generate(
                _items.length,
                (index) => _items[index].paralax.getTransformedWidget(
                    child: _items[index].child,
                    parent: paralax,
                    width: constr.maxWidth,
                    height: constr.maxHeight,
                    depth: _items[index].depth,
                    maxDepth: maxDepth,
                    animationX: animation)),
            if (frontBuilder != null)
              Positioned.fill(child: frontBuilder!(context, animation))
          ]);
        }),
      ),
    );
  }
}
