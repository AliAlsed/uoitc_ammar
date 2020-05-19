import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/resourses/styling.dart';
import 'package:uoitc/ui/size_config.dart';

class DetailsPage extends StatelessWidget {
  final String title;
  final String des;
  final String date;
  final String section;
  final List images;
  final String imageUrl;
  final bool isGal;
  final bool isTitle;


  DetailsPage(
      {this.imageUrl, this.isGal, this.title, this.des, this.date, this.images, this.isTitle, this.section});

  int currentIndex = 0;
  List<Widget> list;
  Widget _getImages() {
    list = new List<Widget>();
    for (var i = 0; i < images.length; i++) {
      list.add(
        CachedNetworkImage(
          colorBlendMode: BlendMode.hardLight,
          color: Colors.black.withOpacity(0.2),
          fit: BoxFit.fill,
          imageUrl: images[i]['path'],
          placeholder: (context, url) =>
              Image.asset(
                Images.loadingImage,
                fit: BoxFit.cover,
              ),
        ),);
    }

    return Carousel(
      images: list,
      boxFit: BoxFit.scaleDown,
      autoplay: true,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),
      showIndicator: false,
      indicatorBgPadding: 7.0,
    );
  }

  @override
  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);



    final topContent = Stack(
      children: <Widget>[
        Container(
          height: 39.9 * SizeConfig.heightMultiplier,
//          decoration: new BoxDecoration(
//            image: new DecorationImage(
//              image: new NetworkImage(imageUrl),
//              fit: BoxFit.fill,
//            ),
//          ),
          child: _getImages(),
        ),
        Container(
          height: 39.9 * SizeConfig.heightMultiplier,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .3)),
          child: Center(),
        ),
        Positioned(
          left: 8.0,
          top: 15.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ],
    );


    final DesBloc = Container(
      padding: EdgeInsets.only(bottom: 10),
        width: MediaQuery
            .of(context)
            .size
            .width * 1.5,
        child: RichText(
          textAlign: TextAlign.justify,
          textDirection: TextDirection.rtl,
          text: TextSpan(
            text: des,
            style: AppTheme.subTitle(fixSize: 2, color: Colors.grey),
          ),
        )
    );

    final titleBloc = Container(
      margin: EdgeInsets.only(bottom: 5),
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Text(
        title,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: AppTheme.title(color: black, fixSize: 2.5, isBold: false),
      ),
    );

    final sectionBloc = Container(
      padding: EdgeInsets.only(bottom: 15),

      width: MediaQuery
          .of(context)
          .size
          .width * 1.1,
      child: Text(
          '$section- ${date?.substring(0, 11)}',
          textAlign: TextAlign.right,
          style: AppTheme.subTitle(
              color: Colors.grey, fixSize: 2)),
    );


    final bottomContent = Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.all(40.0),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[titleBloc, sectionBloc,
            DesBloc],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}

