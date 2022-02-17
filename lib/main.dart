import 'package:flutter_awesome_page_view/ui/components/animated_page_item.dart';
import 'package:flutter_awesome_page_view/ui/components/animated_page_view.dart';
import 'package:flutter_awesome_page_view/ui/components/paralax_page_item.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      ParalaxPage(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF5F4F4), Color(0xFFBBBBBB)])),
        items: [
          ParalaxItem(
            depth: 3.0,
            child: Container(decoration: BoxDecoration()),
          )
        ],
      ),
      ParalaxPage(
        backgroundColor: Color(0xF5F4F4),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF5F4F4), Color(0xFFBBBBBB)])),
        items: [
          ParalaxItem(
              depth: 1.5,
              child: Center(
                child: Text(
                  'Rectangle',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                      color: Colors.black.withOpacity(0.6)),
                ),
              )),
          ParalaxItem(
              depth: 2.0,
              child: Center(
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Color(0xFF2192F0)),
                ),
              )),
          ParalaxItem(
              depth: 2.5,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Awesome Page',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30.0,
                            color: Color(0xFF999999)),
                      ),
                    ),
                  )))
        ],
      ),
      ParalaxPage(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF262626), Color(0xFF343434)])),
        items: [
          ParalaxItem(
              depth: 1.5,
              child: Center(
                child: Text(
                  'Rectangle',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                      color: Colors.white.withOpacity(0.35)),
                ),
              )),
          ParalaxItem(
              depth: 2.0,
              child: Center(
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Color(0xFF131313)),
                ),
              )),
          ParalaxItem(
              depth: 2.5,
              paralax: NoneParalax(),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Awesome Dark Page',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30.0,
                            color: Color(0xFF2192F0)),
                      ),
                    ),
                  ))),
        ],
      ),
      ParalaxPage(
        paralax: ScrollParalax(),
        frontBuilder: (context, animation) =>
            LayoutBuilder(builder: (context, constr) {
          final width = constr.maxWidth;
          return Stack(
            children: [
              Positioned.fill(
                left: -4 * width * animation,
                right: 4 * width * animation,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'It\'s a magic!',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24.0,
                            color: Color(0xFF525252)),
                      )),
                ),
              ),
            ],
          );
        }),
        items: List.generate(
            5,
            (index) => ParalaxItem(
                depth: index / 2,
                paralax: NoneParalax(),
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                        left: 20.0 * index,
                        bottom: 20.0 * index,
                        child: Center(
                          child: Opacity(
                            opacity: 1.0 - (index / 10.0),
                            child: Container(
                              width: 140,
                              height: 70,
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Like',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Icon(
                                      Icons.thumb_up,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.orange),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))),
      )
    ];

    // return Scaffold(
    //   body: Center(
    //       child: GesturedParalax(
    //           sensitivity: 0.2,
    //           builder: (context, anim) =>
    //               AnimatedItem(animation: anim, child: pages[0]))),
    // );

    return Scaffold(
      body: Center(
          child: ParalaxAnimatedPageView(
              itemsCount: pages.length,
              builder: (context, index, anim) => AnimatedItem(
                  animation: anim,
                  logAnimationValue: index == 1,
                  child: pages[index]))),
    );
  }
}
