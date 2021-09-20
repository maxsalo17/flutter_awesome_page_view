import 'package:flutter/material.dart';

class AnimatedPageView extends StatefulWidget {
  final int itemsCount;
  final Function(BuildContext, int, double) builder;

  const AnimatedPageView(
      {Key? key, required this.itemsCount, required this.builder})
      : super(key: key);
  @override
  _AnimatedPageViewState createState() => _AnimatedPageViewState();
}

class _AnimatedPageViewState extends State<AnimatedPageView> {
  // ignore: prefer_final_fields
  PageController _controller = PageController();

  // ignore: prefer_final_fields
  double _offset = 0.0;
  int _currentPage = 0;
  Size _currentSize = Size.zero;

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.hasClients) {
        setState(() {
          _offset = _controller.offset;
          _currentPage = _controller.page?.toInt() ?? 0;
        });
      }
    });
    super.initState();
  }

  _getAnimValue(
    double offset,
    double itemWidth,
    int index,
  ) {
    final value = offset - (itemWidth * index);
    return value / itemWidth;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: LayoutBuilder(builder: (context, constr) {
        return PageView(
          controller: _controller,
          children: List.generate(
              widget.itemsCount,
              (index) => widget.builder(context, index,
                  _getAnimValue(_offset, constr.maxWidth, index))),
        );
      }),
    );
  }
}
