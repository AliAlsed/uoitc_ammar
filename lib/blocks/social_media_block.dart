import 'package:flutter/material.dart';
import 'package:uoitc/blocks/social_media.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/iconx_icons.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/resourses/styling.dart';

class SocialMediaBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Text('تواصل معنا',
                style: AppTheme.subTitle(fixSize: 3.2)),
          ),
          Row(
            children: <Widget>[
              socialBlock(context, 'Facebook', Iconx.facebook_logo,
                  facebookBack),
              socialBlock(context, 'Instagram',
                  Iconx.instagram_logo, Colors.redAccent),
              socialBlock(context, 'Twitter', Iconx.social_media_twitter,
                  twitterBack),
            ],
          )
        ],
      ),
    );
  }
}
