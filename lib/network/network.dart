import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uoitc/model/utilities.dart';
import 'package:uoitc/model/video.dart';

class NetworkHelper {
  Future<List<VideoModel>> getVideos() async {
    try{
      String url = "http://uoitc.3eyon-host.net/__mobile_app_data_10122019/rest_api/video.php?operation=video";
      http.Response data = await http.post(url);
      var res = json.decode(data.body);
      List<VideoModel> videos = [];
      for (var item in res['video']) {
        videos.add(VideoModel(id: item['id'],title: item['title'],date: item['date'],url: item['url'],image: item['image']));
      }
      return videos;
    }catch(e){
      return e;
    }
  }

  incrementViews(int id) async {
    String url = "http://uoitc.3eyon-host.net/__mobile_app_data_10122019/rest_api/news.php";
    http.Response data = await http.post(url, body: {
      'operation': 'views',
      'news_id': '$id'
    });
    var res = json.decode(data.body);
    print(res);
  }

  sendPhoneData(String device, String model, String osVersion) async {
    String url = "https://uoitc.3eyon-host.net/__mobile_app_data_10122019/rest_api/devices.php";
    http.Response data = await http.post(url, body: {
      'operation': 'add',
      'device':device,
      'model':model,
      'os_version':osVersion
    });
    var res = json.decode(data.body);
    print(res);
  }


  Future<List<Utilities>> getUtilities() async {
    try{
      String url = "https://uoitc.3eyon-host.net/__mobile_app_data_10122019/rest_api/utilities.php";
      http.Response data = await http.post(url, body: {
        'operation': 'utilities',
      });
      var res = json.decode(data.body);
      List<Utilities> utilities = [];
      for (var i in res['utilities']) {
        Utilities g1 = Utilities(property: i['property'],value: i['value'],extra_information: i['extra_information']);
        utilities.add(g1);
      }
      print(utilities[0].value);
      return utilities;
    }catch(e){
      return e;
    }
  }
}