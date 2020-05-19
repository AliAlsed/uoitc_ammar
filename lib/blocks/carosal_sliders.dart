import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:uoitc/pages/detail_page.dart';
import 'package:uoitc/pages/gallery_Details.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/ui/size_config.dart';

class Caru extends StatefulWidget {
  List images;
  bool isDetail;
  var gallery;

  Caru({this.images, this.isDetail, this.gallery});

  @override
  State<StatefulWidget> createState() {
    return CaruState();
  }
}

class CaruState extends State<Caru> {
  int _current = 0;
  List imageURL = [];

  navigate(int x) {
    print(x);
  }

  @override
  Widget build(BuildContext context) {
    imageURL = widget.images;
    if (imageURL.length == 0) {
      imageURL = [Images.loadingImage];
    }
    bool zeroLen = (imageURL == [Images.loadingImage]);
    return Container(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CarouselSlider(
            height: widget.isDetail ? MediaQuery
                .of(context)
                .size
                .height : 75 * SizeConfig.imageSizeMultiplier,
            initialPage: 0,
            enlargeCenterPage: true,
            autoPlay: true,
            reverse: false,
            autoPlayInterval: Duration(seconds: 5),
            pauseAutoPlayOnTouch: Duration(seconds: 15),
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
            items: imageURL.map((images) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: widget.isDetail ? EdgeInsets.all(0) : EdgeInsets
                        .symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: widget.isDetail
                          ? BorderRadius.circular(0)
                          : BorderRadius.circular(20),
                      child: InkWell(
                        onTap: () {
                          zeroLen ? print(_current) :Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) =>
                                GalleryDetails(
                                  isTitle: false,
                                  isGal: true,
                                  images: widget.gallery[_current].images,
                                  title: widget.gallery[_current].title,
                                  date: widget.gallery[_current].date,
                                  des: widget.gallery[_current].id
                                      .toString(),),),);
                        },
                        child: zeroLen ? Image.asset(imageURL[_current],fit: BoxFit.cover,) : CachedNetworkImage(
                          fit: widget.isDetail ? BoxFit.fitHeight : BoxFit.cover,
                          imageUrl: images,
                          placeholder: (context, url) =>
                              Stack(children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 75 * SizeConfig.imageSizeMultiplier,
                                  child: Image.asset(Images.loadingImage, fit: BoxFit.cover,),
                                ),
                              ],
                              ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
