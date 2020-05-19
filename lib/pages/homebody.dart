import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uoitc/Animation/faed_animatoin.dart';
import 'package:uoitc/blocks/app_bar.dart';
import 'package:uoitc/blocks/description_block.dart';
import 'package:uoitc/blocks/list.dart';
import 'package:uoitc/blocks/social_media_block.dart';
import 'package:uoitc/blocks/title_image_block.dart';
import 'package:uoitc/model/news.dart';
import 'package:uoitc/pages/detail_page.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/styling.dart';
import 'package:http/http.dart' as http;
import 'package:uoitc/ui/size_config.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key key}) : super(key: key);

  static final String id = 'Home_ID';

  @override
  State<StatefulWidget> createState() {
    return HomePageBodyState();
  }
}

class HomePageBodyState extends State<HomePageBody> {
  String title =
      " انطلق العام الدراسي الجديد في مختلف كليات جامعة تكنولوجيا المعلومات والاتصالات ... وشهدت الساعات الاولى اقبالا كبيرا من قبل طلبتنا ";
  String subTitle = ' كلية الهندسة - 12/10/2019 ';
  String text =
      " انطلق العام الدراسي الجديد في مختلف كليات جامعة تكنولوجيا المعلومات والاتصالات ... وشهدت الساعات الاولى اقبالا كبيرا من قبل طلبتنا ";

  Future<List<News>> getNews() async {
    try {
      String url =
          "https://uoitc.3eyon-host.net/__mobile_app_data_10122019/rest_api/news.php";

      http.Response data = await http.post(url, body: {'operation': 'news'});
      var newsResult = json.decode(data.body);
      // print(newsResult);
      List<News> news = [];

      for (var i in newsResult['news']) {
        News g1 = News(
            id: i['id'],
            title: i['title'],
            url: i['url'],
            date: i['date'],
            content: i['content'],
            section: i['section'],
            views: i['views'],
            images: i['images'],
            files: i['files']);
        news.add(g1);
      }
      print(news[0].title);

      return news;
    } catch (e) {
      print(e);
    }
  }

  var _conictivityState = 'Unknown';
  Connectivity conictivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    getNews();
    conictivity = Connectivity();
    subscription =
        conictivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _conictivityState = result.toString();
      print(_conictivityState);
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        try {} on Exception catch (e) {
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    double width = MediaQuery.of(context).size.width;
    return FadeAnimation(
      1.2,
      Scaffold(
        // Appbar
        appBar:
            appbar(title: ' الرئيسية ', context: context, isAllowBack: false),

        // Body
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: FutureBuilder(
                future: getNews(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(child: CircularProgressIndicator()));
                  }
                  return Column(
                    children: <Widget>[
                      // Title Image
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 3,
                              offset:
                                  Offset(2, 2), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin:
                            EdgeInsets.all(2.5 * SizeConfig.heightMultiplier),
                        width: width - 20,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: <Widget>[
                            // Image
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                        section: snapshot.data[0].section,
                                        imageUrl: snapshot.data[0].images[0]
                                            ['path'],
                                        images: snapshot.data[0].images,
                                        title: snapshot.data[0].title,
                                        date: snapshot.data[0].date.toString(),
                                        des: snapshot.data[0].content,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 42.8 * SizeConfig.heightMultiplier,
                                  width: MediaQuery.of(context).size.width,
                                  child: ImageTitle(
                                      snapshot.data[0].images[0]['path'],
                                      context),
                                )),

                            // Image Title
                            Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.black45.withOpacity(0.3),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(
                                          2.8 * SizeConfig.heightMultiplier),
                                      bottomRight: Radius.circular(
                                          2.8 * SizeConfig.heightMultiplier),
                                    )),
                                padding: EdgeInsets.symmetric(
                                  vertical: 1.08 * SizeConfig.heightMultiplier,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 2.9*SizeConfig.heightMultiplier),
                                      padding: EdgeInsets.only(
                                        bottom:
                                            1.2 * SizeConfig.heightMultiplier,
                                      ),
                                      child: Text(
                                        snapshot.data[0].title,
                                        textAlign: TextAlign.right,
                                        style: AppTheme.title(
                                            color: white,
                                            fixSize: 2,
                                            isBold: true),
                                      ),
                                    ),
                                    // description
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      padding: EdgeInsets.only(
                                          right: 1.2 *
                                              SizeConfig.heightMultiplier),
                                      child: Text(
                                        snapshot.data[0].section,
                                        style: AppTheme.subTitle(
                                            fixSize: 1.3,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                )),
                            //date        
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 1.08 * SizeConfig.heightMultiplier),
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                snapshot.data[0]?.date
                                    .toString()
                                    .substring(0, 11),
                                textAlign: TextAlign.right,
                                style: AppTheme.subTitle(
                                    fixSize: 1.3, color: Colors.white70),
                              ),
                            )
                          ],
                        ),
                      ),

                      // List
                      ListViewItem(
                        news: snapshot.data,
                        isGallery: false,
                      ),

                      SizedBox(
                        height: 4.4 * SizeConfig.heightMultiplier,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
