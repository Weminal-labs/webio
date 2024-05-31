import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
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
    await Future.delayed(const Duration(milliseconds: 500));
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
    print('media width: ${MediaQuery.of(context).size.width}');

    return Material(
      color: const Color(0xff121113),
      child: Stack(
        children: [
          Container(
            foregroundDecoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  Colors.black12,
                  Colors.black26,
                  Colors.black38,
                  Colors.black45,
                  Colors.black54,
                  Colors.black87,
                  Colors.black,
                ],
                tileMode: TileMode.decal,
                center: Alignment.center,
                radius: 1.2,
                stops: [0.75, 0.76, 0.77, 0.78, 0.79, 0.80, 0.8, 0.9],
              ),
            ),
            child: ZoomIn(
              duration: const Duration(milliseconds: 500),
              animate: zoomIn,
              child: Stack(
                children: [
                  SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: Image(
                      image: _getImage(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Image.asset(
              'assets/images/bg_circle.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInUp(
                  delay: Duration(milliseconds: 100),
                  duration: const Duration(milliseconds: 500),
                  animate: zoomIn,
                  child: Text(
                    name ?? '',
                    style: GoogleFonts.alegreya(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                FadeInUp(
                  delay: Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 500),
                  animate: zoomIn,
                  child: Text(
                    des ?? '',
                    style: GoogleFonts.arimo(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
