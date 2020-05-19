
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uoitc/Animation/faed_animatoin.dart';
import 'package:uoitc/blocks/description_block.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/resourses/styling.dart';
import 'package:uoitc/ui/size_config.dart';
import 'package:carousel_pro/carousel_pro.dart';

class GalleryDetails extends StatefulWidget {
 final String title;
 final String des;
 final String date;
 final String section;
 final List images;
 final String imageUrl;
 final bool isGal;
 final bool isTitle;


 GalleryDetails(
     {this.imageUrl, this.isGal, this.title, this.des, this.date, this.images, this.isTitle,this.section});

 static final String path = "lib/src/pages/ecommerce/ecommerce_detail3.dart";

 @override
 State<StatefulWidget> createState() {
   return GalleryDetailsState();
 }
}

class GalleryDetailsState extends State<GalleryDetails> {
 @override
 Widget build(BuildContext context) {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

   int currentIndex = 0;
   List<Widget> list;

   Widget _getImages() {
     list = new List<Widget>();
     for (var i = 0; i < widget.images.length; i++) {
       list.add(
         Container(
           color: Colors.black,
           child: CachedNetworkImage(
           fit: BoxFit.fitWidth,
           imageUrl: widget.images[i]['path'],
           placeholder: (context, url) =>
               Image.asset(
                 Images.loadingImage,
                 fit: BoxFit.fitWidth,
               ),
         ),),);
     }

     return Carousel(
       images: list,
       boxFit: BoxFit.fill,
       //autoplay: true,
       animationCurve: Curves.fastOutSlowIn,
       animationDuration: Duration(milliseconds: 1000),
       dotSize: 6.0,
       dotIncreasedColor: Colors.white,
       dotBgColor: Colors.transparent,
       dotPosition: DotPosition.bottomCenter,
       dotVerticalPadding: 10.0,
       showIndicator: true,
       indicatorBgPadding: 7.0,
     );
   }


   void _next() {
     setState(() {
       if (currentIndex < list.length - 1) {
         currentIndex++;
       } else {
         currentIndex = 0;
       }
     });
   }

   void _prev() {
     setState(() {
       if (currentIndex > 0) {
         currentIndex--;
       } else {
         currentIndex = 0;
       }
     });
   }


   return Scaffold(
     body: FadeAnimation(
       1.2,
       Stack(
         children: <Widget>[
           GestureDetector(
             onHorizontalDragEnd: (DragEndDetails details) {
               if (details.velocity.pixelsPerSecond.dx > 0) {
                 _prev();
               } else if (details.velocity.pixelsPerSecond.dx < 0) {
                 _next();
               }
             },
             child: Container(
               height: double.infinity,
               child: widget.isGal ? _getImages() : CachedNetworkImage(
                 colorBlendMode: BlendMode.hardLight,
                 color: Colors.black,
                 imageUrl: widget.imageUrl,
                 fit: BoxFit.cover,
               ),
             ),
           ),
           Column(
             children: <Widget>[
               // Back Arrow
               Row(
                 children: [
                   SafeArea(
                     child: MaterialButton(
                       enableFeedback: false,
                       padding: EdgeInsets.all(8.0),
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10.0)),
                       textColor: Colors.white,
                       minWidth: 0,
                       height: 40,
                       onPressed: () => Navigator.pop(context),
                       child: Icon(Icons.arrow_back),
                     ),
                   ),
                 ],
               ),

               Spacer(),
               // Content
              //  Expanded(
              //    flex: widget.isGal ? 0 : 1,
              //    child: Container(
              //      decoration: BoxDecoration(
              //        borderRadius: BorderRadius.only(
              //            topLeft:
              //            Radius.circular(4 * SizeConfig.heightMultiplier),
              //            topRight:
              //            Radius.circular(4 * SizeConfig.heightMultiplier)),
              //        color: white,
              //      ),
              //      child: SingleChildScrollView(
              //        physics: BouncingScrollPhysics(),
              //          child: Column(
              //            children: <Widget>[
              //              const SizedBox(height: 30.0),
              //              SingleChildScrollView(
              //                physics: BouncingScrollPhysics(),
              //                child: Column(
              //                  mainAxisSize: MainAxisSize.min,
              //                  children: <Widget>[
              //                    ListTile(
              //                      title: Text(
              //                        widget.title,
              //                        textDirection: TextDirection.rtl,
              //                        style: AppTheme.title(
              //                            color: black, fixSize: 3.5, isBold: true),
              //                      ),
              //                      subtitle: Text(
              //                        widget.date.substring(0, 11),
              //                        textDirection: TextDirection.rtl,
              //                        style: AppTheme.subTitle(
              //                            color: grey, fixSize: 2),
              //                      ),
              //                    ),
              //                    widget.isGal ? Container() :
              //                    DescriptionBlock(text: widget.section.toString()),
              //                    widget.isGal ? Container() :
              //                    DescriptionBlock(text: widget.des),
              //                  ],
              //                ),
              //              ),
              //            ],
              //        ),
              //      ),
              //    ),
              //  ),


             ],
           ),
         ],
       ),
     ),
   );
 }

}