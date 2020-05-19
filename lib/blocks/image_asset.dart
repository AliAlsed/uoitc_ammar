
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/ui/size_config.dart';

Widget ImageTitleAsset(String imageUrl){
  return ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    child: Container(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context,url) => Stack(children: <Widget>[
          Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 75 * SizeConfig.imageSizeMultiplier,
              child: Image.asset(
                Images.loadingImage, fit: BoxFit.cover,)),
        ],),
      )
    ),
  );
}