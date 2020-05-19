import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uoitc/Animation/faed_animatoin.dart';
import 'package:uoitc/blocks/app_bar.dart';
import 'package:uoitc/blocks/carosal_sliders.dart';
import 'package:uoitc/blocks/list.dart';
import 'package:uoitc/model/gallery.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/ui/size_config.dart';
import 'package:http/http.dart' as http;

class GalleryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GalleryPageState();
  }
}

class GalleryPageState extends State<GalleryPage> {
  Map<String, List> galleryData;
  Future<Map<String, List>> getGallery() async {
    try {
      String url =
          "https://uoitc.3eyon-host.net/__mobile_app_data_10122019/rest_api/gallery.php";
      http.Response data = await http.post(url, body: {'operation': 'gallery'});
      var res = json.decode(data.body);
      List<Gallery> gallery = [];
      List images = [];
      int index = 0;
      for (var g in res['gallery']) {
        Gallery g1 = Gallery(
            id: int.parse(g['id']),
            title: g['title'],
            date: g['date'],
            images: g['images']);
        gallery.add(g1);
        index++;
      }
      for (var i = 0; i < gallery.length; i++) {
        images.add(gallery[i].images[0]['path']);
      }
      galleryData = {"images": images, "gallery": gallery};
      return galleryData;
    } catch (e) {
      List<Gallery> gallery = [];
      List images = [];
      int index = 0;
      for (int g = 0; g < 1; g++) {
        Gallery g1 = Gallery(
            id: g,
            title: 'title',
            date: 'dd/mm/yy',
            images: [Images.loadingImage]);
        gallery.add(g1);
        index++;
      }
      for (var i = 0; i < gallery.length; i++) {
        images.add(gallery[i].images[0]['path']);
      }
      galleryData = {"images": images, "gallery": gallery};
      return galleryData;
    }
  }

  var _conictivityState = 'Unknown';
  Connectivity conictivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    conictivity = Connectivity();
    subscription =
        conictivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _conictivityState = result.toString();
      print(_conictivityState);
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        try {
          getGallery();
        } on Exception catch (e) {
          print(e.toString());
        }
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Widget ifNull(snap) {
    snap = [Images.loadingImage, Images.loadingImage];

    return Caru(
      images: snap,
      isDetail: false,
      gallery: snap.data['gallery'],
    );
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    getGallery();
    double width = MediaQuery.of(context).size.width;
    return FadeAnimation(
      1.2,
      Scaffold(
        appBar:
            appbar(title: 'معرض الصور ', context: context, isAllowBack: false),
        body: Container(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: FutureBuilder(
                future: getGallery(),
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.data == null) {
                    return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(child: CircularProgressIndicator()));
                  }
                  return Column(
                    children: <Widget>[
                      // Scroll Image
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        width: width,
                        height: 78 * SizeConfig.imageSizeMultiplier,
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Caru(
                                  images: snap.data["images"],
                                  isDetail: false,
                                  gallery: snap.data['gallery'],
                                ),
                        ),
                      ),

                      // List
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        child: ListViewItem(
                        images: snap.data["images"],
                        gallery: snap.data["gallery"],
                        isGallery: true,
                      ),),

                      SizedBox(height: 6.4 * SizeConfig.heightMultiplier)
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
