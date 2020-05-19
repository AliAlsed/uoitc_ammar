import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uoitc/blocks/video_block.dart';
import 'package:uoitc/model/gallery.dart';
import 'package:uoitc/model/news.dart';
import 'package:uoitc/model/video.dart';
import 'package:uoitc/pages/detail_page.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/resourses/styling.dart';
import 'package:uoitc/ui/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoList extends StatefulWidget {
  AsyncSnapshot snapshot;
  VideoModel videoModel;

  VideoList({this.videoModel, this.snapshot});

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      width: width - 20,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.snapshot.data.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if(index == 0){
              return SizedBox(width: 0);
            }
            return  Center(
              child: InkWell(
                onTap: () {
                  _launchURL(widget.snapshot.data[index].url);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // Text
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.centerRight,
                          height: 15 * SizeConfig.heightMultiplier,
                          child: ListTile(
                            title: Text(
                                widget.snapshot.data[index].title,
                                textDirection: TextDirection.rtl,
                                style: AppTheme.title(
                                    color: black, fixSize: 1.7, isBold: false)),
                            subtitle: Text(
                              widget.snapshot.data[index].date.substring(0, 11),
                              textDirection: TextDirection.rtl,
                              style: AppTheme.title(color: grey, fixSize: 1.3, isBold: true)),
                          )
                      ),
                    ),

                    // Image
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: 15 * SizeConfig.heightMultiplier,
                        height: 15 * SizeConfig.heightMultiplier,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2.5 *
                              SizeConfig.heightMultiplier),
                          child: VideoBlock(videoModel: widget.videoModel,
                            image: widget.snapshot.data[index].image,
                            url: widget.snapshot.data[index].url,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }


  _launchURL(String _url) async {
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }
}

Widget detail(String subTitle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      // department and release date
      Expanded(
        child: Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier),
          child: Text(
            subTitle.substring(0, 11),
            textDirection: TextDirection.rtl,
            style: AppTheme.title(color: grey, fixSize: 1.3, isBold: true),
          ),
        ),
      ),
    ],
  );
}
