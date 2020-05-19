import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uoitc/model/gallery.dart';
import 'package:uoitc/model/news.dart';

class NotificationHelper {
Future<News> getNews(String id) async{
    try{
      String url = "http://uoitc.3eyon-host.net/__mobile_app_data_10122019/rest_api/id.php";
      http.Response data = await http.post(url, body: {
      'operation': 'news',
      'id': '$id'
    });
    var res = json.decode(data.body);

    print(res['news'][0]['title']);


    News news =News(id: res['news'][0]['id'],title: res['news'][0]['title'],url: res['news'][0]['url'],date: res['news'][0]['date'],content: res['news'][0]['content'],section: res['news'][0]['section'],views: res['news'][0]['views'],images: res['news'][0]['images']);
    return(news);
    }catch(e){
      return e;
    }
}

Future<Gallery> getGallery(String id) async{
    try{
      String url = "http://uoitc.3eyon-host.net/__mobile_app_data_10122019/rest_api/id.php";
      http.Response data = await http.post(url, body: {
      'operation': 'gallery',
      'id': '$id'
    });
    var res = json.decode(data.body);

    print(res['gallery'][0]['title']);


    Gallery gallery =Gallery(id: int.parse(res['gallery'][0]['id']),title: res['gallery'][0]['title'],date: res['gallery'][0]['date'],images: res['gallery'][0]['images']);
    print(gallery);
    return gallery;
    }catch(e){
      print(e);
    }
}


}