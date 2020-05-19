import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uoitc/Animation/faed_animatoin.dart';
import 'package:uoitc/blocks/app_bar.dart';
import 'package:uoitc/blocks/description_block.dart';
import 'package:uoitc/blocks/title_image_block.dart';
import 'package:uoitc/network/URLan.dart';
import 'package:uoitc/network/network.dart';
import 'package:uoitc/pages/college.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/iconx_icons.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/resourses/styling.dart';
import 'package:uoitc/ui/size_config.dart';

class ContactUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactUsState();
  }
}

class ContactUsState extends State<ContactUs> {
  List<Map<String, String>> installedApps;
  List<Map<String, String>> iOSApps = [
    {"app_name": "Calendar", "package_name": "calshow://"},
    {"app_name": "Facebook", "package_name": "fb://"},
    {"app_name": "Whatsapp", "package_name": "whatsapp://"}
  ];

  Future<void> getApps() async {
    List<Map<String, String>> _installedApps;
    if (Platform.isAndroid) {
      // Returns: true
    } else if (Platform.isIOS) {
      // iOS doesn't allow to get installed apps.
      _installedApps = iOSApps;
    }
    setState(() {
      installedApps = _installedApps;
    });
  }

  NetworkHelper networkHelper = NetworkHelper();

  @override
  void initState() {
    var item = networkHelper.getUtilities();
    print(item);
    item.then((onValue) {
      for (var i in onValue) {
        print('${i.value} ${i.property} ${i.extra_information} ');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);


    return Scaffold(
      appBar: appbar(title: 'التواصل', context: context, isAllowBack: true),
      body: FadeAnimation(
        1.2,
        FutureBuilder(
            future: networkHelper.getUtilities(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(2.8 * SizeConfig.widthMultiplier),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Image
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 35 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset:
                                    Offset(2, 2), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ImageTitle(snapshot.data[7].value, context),
                        ),
                        //  Title Image
                        Container(
                          margin:
                              EdgeInsets.all(1.2 * SizeConfig.heightMultiplier),
                          alignment: Alignment.centerRight,
                          child: Text(
                            snapshot.data[6].value,
                            textDirection: TextDirection.rtl,
                            style: AppTheme.title(
                                color: black, fixSize: 2.5, isBold: false),
                          ),
                        ),

                        // Des
                        Container(
                          child: ListTile(
                            subtitle: Text(
                              snapshot.data[6].extra_information,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),

                        ////////////////////////
                        Container(
                          margin:
                              EdgeInsets.all(1.2 * SizeConfig.heightMultiplier),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'تواصل مع الجامعة',
                            textDirection: TextDirection.rtl,
                            style: AppTheme.title(
                                color: black, fixSize: 2.5, isBold: false),
                          ),
                        ),

                        // Blocks
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              socialContent(2, messageColor2, Images.mail,
                                  snapshot.data[4].extra_information),
                              socialContent(
                                  4,
                                  facebookBack,
                                  Images.facebookLogo,
                                  snapshot.data[0].extra_information),
                              socialContent(3, Colors.blue, Images.tele,
                                  snapshot.data[2].extra_information),
                              socialContent(3, twitterBack, Images.twitterLogo,
                                  snapshot.data[1].extra_information),
                              socialContent(3, youtubeColor, Images.you,
                                  snapshot.data[3].extra_information),
                              socialContent(3, youtubeColor, Images.webLogo,
                                  snapshot.data[12].value),
                            ],
                          ),
                        ),
                        // Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: <Widget>[
                        //       socialContent(3, twitterBack, Images.twitterLogo,
                        //           snapshot.data[1].extra_information),
                        //       socialContent(3, youtubeColor, Images.you,
                        //           snapshot.data[3].extra_information),
                        //       socialContent(3, youtubeColor, Images.webLogo,
                        //           snapshot.data[4].extra_information),
                        //     ],
                        //   ),
                        // ),
                        ListTile(
                          title: Text(
                            snapshot.data[11].value.toString().toUpperCase(),
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 1.8 * SizeConfig.heightMultiplier,
                                color: Colors.black45),
                          ),
                        )
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}

Widget socialContent(
    int i, Color backgroundColor, String imageURL, String link) {
  return InkWell(
    onTap: () {
      switch (i) {
        case 1:
          UrlLauncherUtils.callNumber(link);
          break;
        case 2:
          UrlLauncherUtils.openEmail(link);
          break;
        case 3:
          UrlLauncherUtils.openLink(link);
          break;
        case 4:
          UrlLauncherUtils.facebookOpen();
          break;
      }
    },
    child: Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          width: 12 * SizeConfig.widthMultiplier,
          height: 12 * SizeConfig.widthMultiplier,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                imageURL,
                fit: BoxFit.contain,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
