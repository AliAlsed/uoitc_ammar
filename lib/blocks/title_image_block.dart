
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/ui/size_config.dart';

Widget ImageTitle(String imageUrl,[context]){
  return ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    child: Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 43.5 * SizeConfig.heightMultiplier,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 50,
            offset: Offset(10, 10), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(2.9*SizeConfig.heightMultiplier),
      ),
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: imageUrl,
        placeholder: (context, url) => Image.asset(Images.loadingImage,fit: BoxFit.fill,),
      ),
    ),
  );
}