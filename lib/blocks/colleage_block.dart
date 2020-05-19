import 'package:flutter/material.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/resourses/styling.dart';
import 'package:uoitc/ui/size_config.dart';

class CollegeBlock extends StatefulWidget {
  final String date;
  final int is_evening;

  CollegeBlock({this.date, this.is_evening});

  @override
  _CollegeBlockState createState() => _CollegeBlockState();
}

class _CollegeBlockState extends State<CollegeBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(13),
      child: numOfBlock(widget.is_evening, widget.date)
    );
  }
}


Widget block(String title, String text, bool isImage) {
  return Center(
    child: Container(
      decoration: myBoxDecoration(),
      width: 30 * SizeConfig.widthMultiplier,
      height: 12.5 * SizeConfig.heightMultiplier,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: AppTheme.subTitle(fixSize: 1.7, color: grey),
          ),
          isImage ?
          Image.asset(
            text, fit: BoxFit.cover, height: 5.5 * SizeConfig.heightMultiplier,)
              :
          Text(
            text,
            style: AppTheme.title(fixSize: 3.5, color: black, isBold: true),
          ),
        ],
      ),
    ),
  );
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
      border: Border.all(
        color: black,
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(30)
  );
}
 Widget numOfBlock(is_evening,date){
  if(is_evening == 1){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        block('الدراسة المسائية', Images.darkMoon, true),
        block('الدراسة صباحية', Images.fullMoon, true),
        block('تأسست', date, false),
      ],
    );
  }else {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        block('الدراسة صباحية', Images.fullMoon, true),
        block('تأسست', date, false),
      ],
    );
  }
 }