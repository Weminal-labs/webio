import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BackgroundWidget extends StatefulWidget {
  const BackgroundWidget({super.key});

  @override
  State<BackgroundWidget> createState() => BackgroundWidgetState();
}

class BackgroundWidgetState extends State<BackgroundWidget> {
  NetworkImage? networkImage;
  String? name;
  String? des;
  bool zoomIn = false;

  void setContent({
    NetworkImage? networkImage,
    String? name,
    String? des,
  }) async {
    if (zoomIn) {
      setState(() {
        zoomIn = false;
      });
    }
    print('start await');
    await Future.delayed(Duration(milliseconds: 500));
    print('await done');
    setState(() {
      zoomIn = true;
      this.networkImage = networkImage;
      this.name = name;
      this.des = des;
    });
  }

  _getImage() {
    return networkImage ?? const AssetImage('assets/images/logo.png');
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');

    return Material(
      child: Stack(
        children: [
          ZoomIn(
            duration: const Duration(milliseconds: 500),
            animate: zoomIn,
            child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Image(
                image: _getImage(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            // decoration: BoxDecoration(
            //     color: Colors.blue,
            //     image: DecorationImage(image: _getImage(), fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? '',
                    style: GoogleFonts.alegreya(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w600)),
                  ),
                  Text(
                    des ?? '',
                    style: GoogleFonts.arimo(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
