import 'dart:io';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uoitc/Animation/faed_animatoin.dart';
import 'package:uoitc/pages/gallery.dart';
import 'package:uoitc/pages/homebody.dart';
import 'package:uoitc/pages/videos.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/iconx_icons.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentPage = 1;
  List<Widget> pages = [GalleryPage(), HomePageBody(), VideosPage()];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return
      Scaffold(
      // Body
      body: pages[currentPage],
      // Bottom Nav bar

      bottomNavigationBar:

      Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
        FancyBottomNavigation(

        inactiveIconColor: iconDeActiveColor,
        initialSelection: currentPage,
        circleColor: iconActiveColor,
        tabs: [
          TabData(
            iconData: Iconx.motivational,
            title: " ",
          ),
          TabData(
            iconData: Iconx.home_icon_silhouette,
            title: " ",
          ),
          TabData(
            iconData: Iconx.video,
            title: " ",
          ),
        ],
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
            Container(height: 8,color: Colors.white,),
]

    ),);
  }
}

class _Clipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, -size.height, size.width, size.height * 2);

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
