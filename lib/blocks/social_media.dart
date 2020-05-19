import 'package:flutter/material.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/ui/size_config.dart';


Widget socialBlock(context , String name , IconData imageURL ,Color backgroundColor){
  double width = MediaQuery.of(context).size.width;
  return Container(
    margin: EdgeInsets.all(5),
    width: (width - 40) / 3,
    height: 15 * SizeConfig.heightMultiplier,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: backgroundColor,
        child: socialMedia(name,
            imageURL),
      ),
    ),
  );
}


Widget socialMedia(String name, IconData imageURL) {
  return Container(
    margin: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(imageURL,color: white,),
        SizedBox(
          height: 1.2 * SizeConfig.heightMultiplier,
        ),
        Text(
          '$name',
          style: TextStyle(
              color: white, fontSize: 1.6 * SizeConfig.textMultiplier),
        ),
        Text(
          '@CTU_Iraq',
          style: TextStyle(
            color: white,
            fontSize: 1.6 * SizeConfig.textMultiplier,
          ),
        ),
      ],
    ),
  );
}
