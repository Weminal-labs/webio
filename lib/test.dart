import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:drag_anim/drag_anim.dart';
import 'package:drag_anim/drag_anim_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(MaterialApp(
    home: TestWidget(),
  ));
}

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  Color color = Color(0xff1a191b);
  late final list;
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
        key: '1',
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
          key: '1',
          mainAxisCellCount: 2,
          crossAxisCellCount: 3,
          widget: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(16),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'flamrdevs',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'UI/UX designer',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'I am a UI/UX designer from Indonesia, specializing in creating user-centric and visually appealing digital experiences. With a focus on seamless and enjoyable interactions, I aim to enhance the overall user experience through strategic design solutions.',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ],
            ),
          )),
      HomeEditCard(
          key: '1',
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
          key: '1',
          mainAxisCellCount: 2,
          crossAxisCellCount: 3,
          widget: _getText()),
      HomeEditCard(
        key: '1',
        mainAxisCellCount: 4,
        crossAxisCellCount: 3,
        widget: Text(
          'Something',
          style: TextStyle(fontSize: 36, color: Colors.white),
        ),
      ),
      HomeEditCard(
        key: '1',
        mainAxisCellCount: 2,
        crossAxisCellCount: 3,
        widget: Text(
          'Something',
          style: TextStyle(fontSize: 36, color: Colors.white),
        ),
      ),
      HomeEditCard(
        key: '1',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          list.add(
            HomeEditCard(key: '1', mainAxisCellCount: 1, crossAxisCellCount: 1),
          );
          setState(() {});
        },
      ),
      body: DragAnimNotification(
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
                      crossAxisCount: 9,
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
                      child: dragItems(MouseRegion(
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
                        child: Container(
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
                          child: element.widget,
                        ),
                      )),
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
    );
  }
}

class HomeEditCard {
  final String key;
  final num mainAxisCellCount;
  final int crossAxisCellCount;
  bool isHover = false;
  final Widget? widget;

  HomeEditCard(
      {required this.key,
      required this.mainAxisCellCount,
      required this.crossAxisCellCount,
      this.widget});
}
