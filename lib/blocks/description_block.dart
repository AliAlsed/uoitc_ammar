import 'package:flutter/material.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/styling.dart';

class DescriptionBlock extends StatelessWidget {
  final String text;

  DescriptionBlock({this.text});
  @override
  Widget build(BuildContext context) {
        double c_width = MediaQuery.of(context).size.width*0.8;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: c_width,
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          text,
          softWrap: true,
          textDirection: TextDirection.rtl,
          style: AppTheme.subTitle(fixSize: 1.7, color: grey),
        ),
      ),
    );
  }
}
