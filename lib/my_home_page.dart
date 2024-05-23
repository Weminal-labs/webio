import 'package:flutter/material.dart';

import 'my_grid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  GlobalKey<MyGridState> myKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          myKey.currentState?.addItem();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: MyGrid(
          key: myKey,
        ),
      ),
    );
  }
}
