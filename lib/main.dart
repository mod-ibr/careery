import 'dart:math';

import 'package:flutter/material.dart';
import 'package:profile_1/CustomButton.dart';
import 'package:profile_1/NavBar.dart';
import 'package:profile_1/PageIndicator.dart';
import 'package:profile_1/TopLeftButton.dart';
import 'package:profile_1/resolution/MobilePage.dart';
import 'package:profile_1/resolution/WebPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Careery',
      home: MyHomePage(),
    );
  }
}

List<String> images = [
  'assets/images/02_AI.png',
  'assets/images/02_ES.png',
  'assets/images/01_ES.png',
  'assets/images/02_flutter.png',
];

List<Color?> colors = [
  Color.fromARGB(255, 116, 104, 0),
  Color.fromARGB(255, 0, 99, 180),
  Color.fromARGB(255, 31, 170, 235),
  Color.fromARGB(255, 22, 75, 25)
];

bool mobilePage = false;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController? _pageController;
  PageController? _colorController;
  void initState() {
    super.initState();
    _pageController = PageController();
    _colorController = PageController();
  }

  int index = 0;
  List subtitle = [
    "The Power Of AI",
    "Obedient Embedd Systems",
    'IOT And Smart World',
    'The Beauty Of Flutter'
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                mobilePage = true;
              } else {
                mobilePage = false;
              }
              return Stack(
                children: [
                  // To Chage the background Color By Button or Scroll
                  Align(
                    alignment: Alignment.topLeft,
                    child: Transform.rotate(
                      angle: pi,
                      child: Container(
                        height: mobilePage
                            ? height * MobilePage.backgroundColorHeightFactor
                            : height * WebPage.backgroundColorHeightFactor,
                        width: mobilePage
                            ? height * MobilePage.backgroundColorWidthFactor
                            : width * WebPage.backgroundColorWidthFactor,
                        child: PageView(
                          //scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          controller: _colorController,
                          children: colors
                              .map(
                                (e) => Container(
                                  color: e,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  // To Change the background Image By Button or Scroll
                  Align(
                    alignment:
                        mobilePage ? MobilePage.imageAlign : WebPage.imageAlign,
                    child: Container(
                      height: mobilePage
                          ? height * MobilePage.imageHeightFactor
                          : height * WebPage.imageHeightFactor,
                      width: mobilePage
                          ? width * MobilePage.imageWidthFactor
                          : width * WebPage.imageWidthFactor,
                      child: PageView(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        children: images
                            .map(
                              (e) => Container(
                                child: Image.asset(
                                  e,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  // To Change the Title of Page 'Head Text'
                  Align(
                    alignment: mobilePage
                        ? MobilePage.headTextAlign
                        : WebPage.headTextAlign,
                    child: Text(
                      'Careery',
                      style: TextStyle(
                        fontSize: mobilePage
                            ? MobilePage.headTextFontSize
                            : WebPage.headTextFontSize,
                        fontFamily: "Times New Roman",
                      ),
                    ),
                  ),
                  // For SubText
                  Align(
                    alignment: mobilePage
                        ? MobilePage.subTextAlign
                        : WebPage.subTextAlign,
                    child: Container(
                      height: 100.0,
                      width: mobilePage
                          ? MobilePage.subTextContainerWidth
                          : WebPage.subTextContainerWidth,
                      child: Text(
                        subtitle[index],
                        style: TextStyle(
                          fontSize: 25,
                          wordSpacing: 3.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  // Nav Bar
                  Align(
                    alignment: Alignment.topRight,
                    child: NavBar(
                      mobilePage: mobilePage,
                    ),
                  ),
                  // Page Indecator Buttons prev,next
                  Align(
                    alignment: Alignment(0.72, 0.92),
                    child: PageIndicator(
                      prevButtonTap: () {
                        setState(() {
                          index = index - 1;
                          if (index < 0) {
                            index = 3;
                          }
                          _pageController!.animateToPage(index,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeOut);
                          _colorController!.animateToPage(index,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeOut);
                        });
                      },
                      nextButtonTap: () {
                        setState(() {
                          index = index + 1;
                          if (index > 3) {
                            index = 0;
                          }
                          _pageController!.animateToPage(index,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeOut);
                          _colorController!.animateToPage(index,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeOut);
                        });
                      },
                    ),
                  ),
                  // Custom Button
                  Align(
                    alignment: mobilePage
                        ? MobilePage.customButtonAlignment
                        : WebPage.customButtonAlignment,
                    child: CustomButton(
                      mobilePage: mobilePage,
                    ),
                  ),
                  // //
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: TopLeftButton(
                  //     mobilePage: mobilePage,
                  //   ),
                  // ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
