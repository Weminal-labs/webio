import 'package:animate_gradient/animate_gradient.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:drag_anim/drag_anim.dart';
import 'package:drag_anim/drag_anim_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color color = const Color(0xff1a191b);
  bool shareBtnHover = false;
  late final List<HomeEditCard> list;
  Widget _getText() {
    const colorizeColors = [
      Colors.green,
      Colors.greenAccent,
      Colors.lightGreenAccent,
      Colors.grey,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Horizon',
    );

    return SizedBox(
      child: AnimatedTextKit(
        animatedTexts: [
          ColorizeAnimatedText(
            'Wenimal Team',
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
          ColorizeAnimatedText(
            'Webio',
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
          ColorizeAnimatedText(
            'PhatLH - HienPhan',
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
        ],
        isRepeatingAnimation: true,
        onTap: () {
          print("Tap Event");
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = [
      HomeEditCard(
        key: 'card0',
        mainAxisCellCount: 4,
        crossAxisCellCount: 3,
        widget: SizedBox(
          height: 300,
          width: 300,
          child: Image.network(
            'assets/images/logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
      HomeEditCard(
          key: 'card1',
          mainAxisCellCount: 2,
          crossAxisCellCount: 3,
          widget: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  maxLines: null,
                  controller: TextEditingController(text: 'flamrdevs'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    fillColor: Colors.transparent,
                    filled: true,
                    hoverColor: Colors.grey,
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  maxLines: null,
                  controller: TextEditingController(text: 'UI/UX designer'),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 30),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    fillColor: Colors.transparent,
                    filled: true,
                    hoverColor: Colors.grey,
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  maxLines: null,
                  controller: TextEditingController(
                    text:
                        'I am a UI/UX designer from Indonesia, specializing in creating user-centric and visually appealing digital experiences. With a focus on seamless and enjoyable interactions, I aim to enhance the overall user experience through strategic design solutions.',
                  ),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    fillColor: Colors.transparent,
                    filled: true,
                    hoverColor: Colors.grey,
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          )),
      HomeEditCard(
          key: 'card2',
          mainAxisCellCount: 2,
          crossAxisCellCount: 3,
          widget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                          side: BorderSide(color: Color(0xff323035)),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {},
                  child: ListTile(
                    leading: Icon(
                      Icons.image_outlined,
                      color: Color(0xff7c7a85),
                      size: 24,
                    ),
                    title: Text(
                      'astrolinkt',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text('Astro template'),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                          side: BorderSide(color: Color(0xff323035)),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {},
                  child: ListTile(
                    leading: Icon(
                      Icons.image_outlined,
                      color: Color(0xff7c7a85),
                      size: 24,
                    ),
                    title: Text(
                      'astrolinkt',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text('Astro template'),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                          side: BorderSide(color: Color(0xff323035)),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {},
                  child: ListTile(
                    leading: Icon(
                      Icons.image_outlined,
                      color: Color(0xff7c7a85),
                      size: 24,
                    ),
                    title: Text(
                      'astrolinkt',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text('Astro template'),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          )),
      HomeEditCard(
          key: 'card3',
          mainAxisCellCount: 2,
          crossAxisCellCount: 3,
          widget: _getText()),
      HomeEditCard(
        key: 'card4',
        mainAxisCellCount: 4,
        crossAxisCellCount: 3,
        widget: Text(
          'Something',
          style: TextStyle(fontSize: 36, color: Colors.white),
        ),
      ),
      HomeEditCard(
        key: 'card5',
        mainAxisCellCount: 2,
        crossAxisCellCount: 3,
        widget: Text(
          'Something',
          style: TextStyle(fontSize: 36, color: Colors.white),
        ),
      ),
      HomeEditCard(
        key: 'card6',
        mainAxisCellCount: 2,
        crossAxisCellCount: 3,
        widget: Text(
          'Something',
          style: TextStyle(fontSize: 36, color: Colors.white),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.96;
    var width = MediaQuery.of(context).size.width * 0.96;

    return Scaffold(
      backgroundColor: const Color(0xff121113),
      body: Stack(
        children: [
          DragAnimNotification(
            child: Center(
              child: SizedBox(
                height: height,
                width: width,
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    DragAnim<HomeEditCard>(
                      scrollDirection: Axis.horizontal,
                      buildItems: (List<Widget> children) {
                        return StaggeredGrid.count(
                          crossAxisCount: _getResize(),
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          children: children,
                        );
                      },
                      items: (HomeEditCard element, DragItems dragItems) {
                        return StaggeredGridTile.count(
                          key: ValueKey<String>(element.key ?? ''),
                          mainAxisCellCount: element.mainAxisCellCount,
                          crossAxisCellCount: element.crossAxisCellCount,
                          child: dragItems(
                            MouseRegion(
                              onHover: (event) {
                                setState(() {
                                  element.isHover = true;
                                });
                              },
                              onExit: (event) {
                                setState(() {
                                  element.isHover = false;
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin: element.isHover
                                        ? EdgeInsets.zero
                                        : const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: const Color(0xff1a191b),
                                        borderRadius: BorderRadius.circular(36),
                                        border: Border.all(
                                            width: 3,
                                            color: element.isHover
                                                ? Colors.green
                                                : const Color(0xff323035))),
                                    alignment: Alignment.center,
                                    child: Container(
                                        child: SingleChildScrollView(
                                            child: element.widget)),
                                  ),
                                  if (element.isHover)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    list.remove(element);
                                                  });
                                                },
                                                icon: const Icon(Icons.delete),
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      element.mainAxisCellCount =
                                                          1;
                                                      element.crossAxisCellCount =
                                                          1;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.square_outlined,
                                                    size: 16,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      element.mainAxisCellCount =
                                                          2;
                                                      element.crossAxisCellCount =
                                                          3;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      Icons.rectangle_outlined),
                                                  color: Colors.white,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      element.mainAxisCellCount =
                                                          4;
                                                      element.crossAxisCellCount =
                                                          3;
                                                    });
                                                  },
                                                  icon: const ImageIcon(
                                                    AssetImage(
                                                      'assets/images/rectangle_vertical.png',
                                                    ),
                                                    size: 24,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      // buildFeedback: (data, child, size) {
                      //   return Container(
                      //     width: 250,
                      //     height: 250,
                      //     color: Colors.red,
                      //   );
                      // },
                      dataList: list,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MouseRegion(
                    onHover: (event) {
                      setState(() {
                        shareBtnHover = true;
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        shareBtnHover = false;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AnimateGradient(
                          primaryBeginGeometry:
                              const AlignmentDirectional(0, 1),
                          primaryEndGeometry: const AlignmentDirectional(0, 2),
                          secondaryBeginGeometry:
                              const AlignmentDirectional(2, 0),
                          secondaryEndGeometry:
                              const AlignmentDirectional(0, -0.8),
                          textDirectionForGeometry: TextDirection.rtl,
                          primaryColors: shareBtnHover
                              ? [Colors.green, Colors.green, Colors.green]
                              : const [
                                  Colors.green,
                                  Colors.greenAccent,
                                  Colors.white,
                                ],
                          secondaryColors: shareBtnHover
                              ? [Colors.green, Colors.green, Colors.green]
                              : const [
                                  Colors.white,
                                  Colors.lightGreen,
                                  Colors.lightGreenAccent,
                                ],
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Share My Profile',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      list.add(
                        HomeEditCard(
                            key: 'card ${list.length}',
                            mainAxisCellCount: 1,
                            crossAxisCellCount: 1),
                      );
                    },
                    icon: const Icon(
                      Icons.square_outlined,
                      size: 16,
                    ),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      list.add(
                        HomeEditCard(
                            key: 'card ${list.length}',
                            mainAxisCellCount: 2,
                            crossAxisCellCount: 3),
                      );
                    },
                    icon: const Icon(Icons.rectangle_outlined),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      list.add(
                        HomeEditCard(
                            key: 'card ${list.length}',
                            mainAxisCellCount: 4,
                            crossAxisCellCount: 3),
                      );
                    },
                    icon: const ImageIcon(
                      AssetImage(
                        'assets/images/rectangle_vertical.png',
                      ),
                      size: 24,
                    ),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getResize() {
    var size = MediaQuery.of(context).size.width;
    if (size > 1500) {
      return 9;
    }
    if (size > 950) {
      return 6;
    }
    return 3;
  }
}

class HomeEditCard {
  final String key;
  num mainAxisCellCount;
  int crossAxisCellCount;
  bool isHover = false;
  final Widget? widget;

  HomeEditCard(
      {required this.key,
      required this.mainAxisCellCount,
      required this.crossAxisCellCount,
      this.widget});
}
