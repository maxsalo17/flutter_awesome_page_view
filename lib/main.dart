import 'package:awesome_onboading/ui/components/animated_page_item.dart';
import 'package:awesome_onboading/ui/components/animated_page_view.dart';
import 'package:awesome_onboading/ui/components/paralax_page_item.dart';
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
    final pages = [ParalaxPageItem(), ParalaxPageItem(), ParalaxPageItem()];

    return Scaffold(
      body: Center(
          child: AnimatedPageView(
              itemsCount: pages.length,
              builder: (context, index, anim) => AnimatedPageItem(
                  animation: anim,
                  logAnimationValue: index == 1,
                  child: pages[index]))),
    );
  }
}
