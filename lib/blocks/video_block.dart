import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uoitc/model/video.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/ui/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class VideoBlock extends StatefulWidget {
  VideoModel videoModel;
  String url;
  String image;

  VideoBlock({this.videoModel, this.image, this.url});

  @override
  _VideoBlockState createState() => _VideoBlockState();
}

class _VideoBlockState extends State<VideoBlock> {
  VideoPlayerController playerController;
  Future<void> listener;

  @override
  void initState() {
    super.initState();
    playerController = VideoPlayerController.network(widget.videoModel.url);
    listener = playerController.initialize();
    playerController.setVolume(1.0);
    playerController.setLooping(true);
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double widthMargin = width - 4 * SizeConfig.widthMultiplier;

    return FutureBuilder(
      future: listener,
      builder: (context, snapshot) {
          return Container(
            width: widthMargin,
            height: 28 * SizeConfig.heightMultiplier,
            margin: EdgeInsets.symmetric(horizontal: 4 * SizeConfig.widthMultiplier,vertical: SizeConfig.widthMultiplier),
            child: Stack(children: <Widget>[

              //Image
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(5, 5), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                width: widthMargin,
                height: 28 * SizeConfig.heightMultiplier,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10),
                  child: (widget.image == '') ?
                  Image.asset(Images.loadingImage)
                      : CachedNetworkImage(
                    imageUrl: widget.image,
                    fit: BoxFit.cover,
                    placeholder: (BuildContext context, String url) =>
                        Stack(children: <Widget>[
                          Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 75 * SizeConfig.imageSizeMultiplier,
                              child: Image.asset(
                                Images.loadingImage, fit: BoxFit.cover,)),
                        ],
                      ),
                  ),
                ),
              ),
              // Icon
              Container(
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      _launchURL(widget.url);
                    },
                    icon: Icon(
                      playerController.value.isPlaying
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline,
                      color: white,
                      size: 8 * SizeConfig.widthMultiplier,
                    ),
                  ),
                ),
              ),
            ]),
          );
      },
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
