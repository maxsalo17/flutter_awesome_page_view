import 'dart:math';

import 'package:awesome_onboading/ui/components/animated_page_item.dart';
import 'package:flutter/material.dart';

class ParalaxPageItem extends StatelessWidget {
  const ParalaxPageItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final xoffset = 200.0;
    final animation = AnimatedPageItem.of(context)?.animation ?? 0.0;
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF0F0F0),
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Transform(
                transform: Matrix4.identity()..rotateZ(animation * (pi / 2)),
                child: Text(
                  'Title',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Color(0xFF131313)),
                ),
              ))
        ],
      ),
    );
  }
}
