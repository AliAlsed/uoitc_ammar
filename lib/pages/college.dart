import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uoitc/Animation/faed_animatoin.dart';
import 'package:uoitc/blocks/app_bar.dart';
import 'package:uoitc/blocks/colleges_list.dart';
import 'package:uoitc/blocks/google_map.dart';
import 'package:uoitc/blocks/image_asset.dart';
import 'package:uoitc/model/college.dart';
import 'package:uoitc/model/utilities.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/styling.dart';
import 'package:uoitc/ui/size_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class College extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return CollegeState();
  }
}

class CollegeState extends State<College> {
  String _text = 'انطلق العام الدراسي الجديد في مختلف كليات جامعة تكنولوجيا المعلومات  والاتصالات  وشهدت الساعات الأولى اقبلا كبيرا من طلبيتنا انطلق العام الدراسي الجديد في مختلف كليات جامعة تكنولوجيا المعلومات والاتصالات  وشهدت الساعات الأولى اقبلا كبيرا من طلبيتنا انطلق العام الدراسي الجديد في مختلف كليات جامعة تكنولوجيا المعلومات ';

  Future<Map<String,List>> getColleges() async {
    try{
      String url = "https://uoitc.3eyon-host.net/__mobile_app_data_10122019/rest_api/colleges.php";
      http.Response data = await http.post(url, body: {
        'operation': 'news'
      });
      var res = json.decode(data.body);

      List<Colleges> college = [];
      List<Utilities> utilit = [];

      for (var k in res['utilities']){
        Utilities utilities =Utilities(property: k['property'],value: k['value'],extra_information: k['extra_information']);
        utilit.add(utilities);
      }

      for (var g in res['colleges']) {
        // print(g);
        Colleges colleges = Colleges(collegeid: g['id'],
            title: g['title'],
            location: g['location'],
            description: g['description'],
            year: g['year'],
            is_evening: int.parse(g['is_evening']),
            images: g['images'],
            departments: g['departments']);
        college.add(colleges);
      }
      print(utilit[0].extra_information);
      print(utilit[1].value);
      Map<String,List> mydata= {
        "college":college,
        "utilities":utilit
      };
      return mydata;
    }catch(e){
      return e;
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
            setState(() {});
            try {
              getColleges();
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

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);


    final double width = MediaQuery
        .of(context)
        .size
        .width;


    return Scaffold(
      appBar: appbar(title: ' نبذة عن الجامعة ', context: context, isAllowBack: true),
      body: FadeAnimation(
        3,
        FutureBuilder(
            future: getColleges(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.all(2.5 * SizeConfig.heightMultiplier),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: width,
                            height: 35* SizeConfig.heightMultiplier,
                            child: ImageTitleAsset(
                                snapshot.data["utilities"][1].value),
                          ),

                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          //  Title Image
                          Container(
                            margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier,horizontal: 10),
                            alignment: Alignment.centerRight,
                            child: Text(
                              snapshot.data["utilities"][0].extra_information,
                              textAlign: TextAlign.right,
                              style: AppTheme.subTitle(fixSize: 1.7, color: grey),
                            ),
                          ),


                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          // Map
                          Container(
                            width: width,
                            height: 25 * SizeConfig.heightMultiplier,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    2.3 * SizeConfig.heightMultiplier),
                                child: GoogleMapBlock(location: snapshot.data["college"][2].location,title: "جامعة تكنولوجيا المعلومات والاتصالات",)
                            ),
                          ),

                          SizedBox(
                            height: 2.74 * SizeConfig.heightMultiplier,
                          ),
                          //Colleges
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: snapshot.data["college"].length,
                              itemBuilder: (BuildContext context, int index) {
                                return CollegeListBlock(
                                  departments: snapshot.data["college"][index].departments,
                                  is_evening: snapshot.data["college"][index].is_evening,
                                  collageName: snapshot.data["college"][index].title,
                                  imageUrl: snapshot.data["college"][index].images,
                                  date: snapshot.data["college"][index].year,
                                  description: snapshot.data["college"][index].description,
                                  location: snapshot.data["college"][index].location,
                                );
                              }
                          ),

                        ],
                      ),
                    ),
                  )
              );
            }),
      ),
    );
  }
}
