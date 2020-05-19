import 'package:flutter/material.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/ui/size_config.dart';

class AppTheme {
  AppTheme._();



  static TextStyle title({Color color,double fixSize,bool isBold }){
    return TextStyle(
      color: color,
      fontFamily: 'DINARB',
      fontSize: fixSize * SizeConfig.textMultiplier,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );
  }

  static TextStyle subTitle({double fixSize,Color color}){
    return TextStyle(
      color: color,
      fontFamily: 'DINARB',
      fontSize: fixSize * SizeConfig.textMultiplier,
    );
  }

  static final TextStyle _buttonLight = TextStyle(
    color: Colors.black,
    fontSize: 2.5 * SizeConfig.textMultiplier,
  );

  static final TextStyle _greetingLight = TextStyle(
    color: Colors.black,
    fontSize: 2.0 * SizeConfig.textMultiplier,
  );

  static final TextStyle _searchLight = TextStyle(
    color: Colors.black,
    fontSize: 2.3 * SizeConfig.textMultiplier,
  );

  static final TextStyle _selectedTabLight = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 2 * SizeConfig.textMultiplier,
  );

  static final TextStyle _unSelectedTabLight = TextStyle(
    color: Colors.grey,
    fontSize: 2 * SizeConfig.textMultiplier,
  );


  static final TextStyle _searchDark = _searchDark.copyWith(color: Colors.black);

  static final TextStyle _selectedTabDark = _selectedTabDark.copyWith(color: Colors.white);

}

