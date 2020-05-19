import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uoitc/Animation/faed_animatoin.dart';
import 'package:uoitc/pages/homa.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/resourses/styling.dart';
import 'package:uoitc/ui/size_config.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 7), () {
      Navigator.pushAndRemoveUntil(
        context,
        _createRoute(),
        ModalRoute.withName('Home_ID'),
      );
    });
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: FadeAnimation(
        1.2,
        Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: white,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FadeAnimation2(
                  5,
                  800,
                  Image.asset(
                    Images.uoitc,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: 6 * SizeConfig.heightMultiplier),
                ),
                FadeAnimation2(
                  7,
                  300,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal:SizeConfig.heightMultiplier),
                    child: Text(
                      Strings.uoitcNameA,
                      textAlign: TextAlign.center,
                      style: AppTheme.title(
                        color: grey,
                        fixSize: 3,
                        isBold: true,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 4 * SizeConfig.heightMultiplier),
                ),
                FadeAnimation2(
                  7,
                  300,
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.3,
                    child: Text(
                      Strings.uoitcNameE,
                      textAlign: TextAlign.center,
                      style: AppTheme.title(
                          color: grey, fixSize: 2, isBold: true),
                    ),
                  ),
                ),

              ],
            ),

            Container(
              margin: EdgeInsets.all(9.8 * SizeConfig.heightMultiplier),
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: SizeConfig.heightMultiplier,),
                  Text('قسم الاعلام والعلاقات العامة')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
