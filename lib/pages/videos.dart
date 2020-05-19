import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uoitc/Animation/faed_animatoin.dart';
import 'package:uoitc/blocks/app_bar.dart';
import 'package:uoitc/blocks/description_block.dart';
import 'package:uoitc/blocks/video_block.dart';
import 'package:uoitc/blocks/video_list.dart';
import 'package:uoitc/network/network.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/resourses/styling.dart';
import 'package:uoitc/ui/size_config.dart';
import 'package:video_player/video_player.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VideosPageState();
  }
}

class VideosPageState extends State<VideosPage> {
  String text =
      " انطلق العام الدراسي الجديد في مختلف كليات جامعة تكنولوجيا المعلومات والاتصالات ... وشهدت الساعات الاولى اقبالا كبيرا من قبل طلبتنا ";

  VideoPlayerController playerController;
  Future<void> listener;
  NetworkHelper networkHelper;

  @override
  void initState() {
    networkHelper = NetworkHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FadeAnimation(
      1.2,
      Scaffold(
        // AppBar
        appBar: appbar(
            title: ' معرض الفيديوهات', context: context, isAllowBack: false),

        //Body
        body: Container(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: FutureBuilder(
              future: networkHelper.getVideos(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Container(
                  margin: EdgeInsets.all(1 * SizeConfig.heightMultiplier),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: <Widget>[
                            VideoBlock(
                              url: snapshot.data[0].url,
                              image: snapshot.data[0].image,
                              videoModel: snapshot.data[0],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 3 * SizeConfig.heightMultiplier,
                                vertical: 3 * SizeConfig.heightMultiplier,
                              ),
                              alignment: Alignment.bottomRight,
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 1.08 * SizeConfig.heightMultiplier,
                                  horizontal: 15.0,
                                ),
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(
                                          SizeConfig.heightMultiplier),
                                      child: ListTile(
                                        title: Text(
                                          snapshot.data[0].title,
                                          textDirection: TextDirection.rtl,
                                          style: AppTheme.title(
                                              color: white,
                                              fixSize: 2,
                                              isBold: false),
                                        ),
                                        subtitle: Text(
                                          snapshot.data[0].date
                                              .toString()
                                              .substring(0, 11),
                                          textAlign: TextAlign.right,
                                          style: AppTheme.subTitle(
                                              fixSize: 1.3,
                                              color: Colors.white70),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      VideoList(
                        snapshot: snapshot,
                        videoModel: snapshot.data[0],
                      ),
                      SizedBox(
                        height: 5.4 * SizeConfig.heightMultiplier,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
