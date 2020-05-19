import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uoitc/pages/college.dart';
import 'package:uoitc/pages/contactUs.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/iconx_icons.dart';
import 'package:uoitc/ui/size_config.dart';

Widget appbar({String title, BuildContext context, bool isAllowBack}) {
  if (!isAllowBack) {
    return AppBar(
      backgroundColor: white,
      actions: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: extend(title,context),
        ),
      ],
    );
  } else {
    return AppBar(
      backgroundColor: white,
      centerTitle: true,
      iconTheme: IconThemeData(color: iconDeActiveColor),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'DINARB',
          color: black,
        ),
      ),
    );
  }
}


Widget extend(String title,BuildContext context){
  return Row(
    children: <Widget>[
      // College Icon
      Expanded(
        flex: 1,
        child: IconButton(
            alignment: Alignment.center,
            color: iconDeActiveColor,
            icon: Icon(Iconx.dots_menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUs()),
              );
            }),
      ),
      // Title
      Expanded(
        flex: 3,
        child: Text(
          '$title',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'DINARB',
            color: black,
            fontSize: 2.5 * SizeConfig.textMultiplier,
          ),
        ),
      ),
      // Contact Us Icon
      Expanded(
        flex: 1,
        child: IconButton(
            alignment: Alignment.center,
            color: iconDeActiveColor,
            icon: Icon(Iconx.sitemap),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => College()),
              );
            }),
      )
    ],
  );
}
