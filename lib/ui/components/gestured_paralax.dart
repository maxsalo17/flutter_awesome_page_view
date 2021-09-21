import 'dart:math';

import 'package:flutter/material.dart';

class GesturedParalax extends StatefulWidget {
  final bool restoreOnGestureEnd;
  final double sensitivity;
  final Widget Function(BuildContext, double) builder;
  final Duration duration;
  const GesturedParalax({
    Key? key,
    this.restoreOnGestureEnd = true,
    required this.builder,
    this.duration = const Duration(milliseconds: 400),
    this.sensitivity = 1.0,
  }) : super(key: key);

  @override
  _GesturedParalaxState createState() => _GesturedParalaxState();
}

class _GesturedParalaxState extends State<GesturedParalax>
    with TickerProviderStateMixin {
  double dx = 0.0;
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        value: 0.0,
        vsync: this,
        duration: Duration.zero,
        lowerBound: -1.0,
        upperBound: 1.0);
    super.initState();
  }

  restore() {
    if (widget.restoreOnGestureEnd) {
      dx = 0.0;
      _animationController.animateTo(0.0,
          duration: widget.duration, curve: Curves.easeOutExpo);
    }
  }

  onGestureUpdate(DragUpdateDetails details, double width) {
    dx += details.delta.dx;
    final value = min(1.0, max(dx / (width / (2 * widget.sensitivity)), -1.0));
    _animationController.animateTo(value, duration: Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: LayoutBuilder(builder: (context, constr) {
        return GestureDetector(
          onHorizontalDragUpdate: (d) => onGestureUpdate(d, constr.maxWidth),
          onHorizontalDragEnd: (_) => restore(),
          onHorizontalDragCancel: () => restore(),
          child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) =>
                  widget.builder(context, _animationController.value)),
        );
      }),
    );
  }
}
