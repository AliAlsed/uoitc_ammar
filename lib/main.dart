import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uoitc/model/news.dart';
import 'package:uoitc/network/network.dart';
import 'package:uoitc/network/notificationhelper.dart';
import 'package:uoitc/pages/detail_page.dart';
import 'package:uoitc/pages/gallery_Details.dart';
import 'package:uoitc/pages/homebody.dart';
import 'package:uoitc/splash_screen.dart';
import 'package:uoitc/ui/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey(
    debugLabel: "Main Navigator");

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PharX',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.grey,
          primaryTextTheme: TextTheme(
              title: TextStyle(
                  color: Colors.grey
              )
          )
      ),
      home: MyHomePage(),

    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final FirebaseMessaging _fcm = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  String imei;
  String platform;
  String brand;
  String model;
  String device;
  String manufacturer;
  String physical;


  // iOS
  StreamSubscription iosSubscription;
  NotificationHelper _notification = NotificationHelper();
  NetworkHelper networkHelper = NetworkHelper();



  @override
  void initState() {
    super.initState();

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print(message);
        print(message['data']['id']);

        print("FFFFF55FFFFF");
        try{
        _showNotification(message).then((onValue) {
          print(onValue);
          print("FFFFF66FFFFF");


          /*
              MaterialPageRoute(
                builder: (context) => SingleNotification("DDDDD","VVVVV"),
              ));
*/

        });
        } catch(err){
          print(err);
        }



        if (message['data']['category'] == "news") {
          News news;
          var result = _notification.getNews(message['data']['id']);
          result.then((onValue) {
            /*
            Navigator.push(context,
                MaterialPageRoute(
                  builder: (_) =>
                      DetailsPage(
                        isGal: false,
                        title: onValue.title,
                        des: onValue.content,
                        date: onValue.date,
                        images: onValue.images,
                        isTitle: true,
                        section: onValue.section,
                        imageUrl: onValue.images[0]['path'],
                      ),
                )
            );

            */
          });
        }else if(message['data']['category'] == "gallery"){
          var result = _notification.getGallery(message['data']['id']);
          result.then((onValue) {
            print(onValue);
            /*
            Navigator.push(context,
                MaterialPageRoute(
                  builder: (_) =>
                      DetailsPage(
                        isGal: false,
                        title: onValue.title,
                        des: onValue.content,
                        date: onValue.date,
                        images: onValue.images,
                        isTitle: true,
                        section: onValue.section,
                        imageUrl: onValue.images[0]['path'],
                      ),
                )
            );

            */
          });

        }else if(message['data']['category'] == "video"){
          print(message['data']);

        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("3");

        print("onLaunch: $message");
        if (message['data']['category'] == "news") {
          News news;
          var result = _notification.getNews(message['data']['id']);
          result.then((onValue) {
            navigatorKey.currentState.pushReplacement(
                MaterialPageRoute(
                  builder: (_) =>
                      DetailsPage(
                        isGal: false,
                        title: onValue.title,
                        des: onValue.content,
                        date: onValue.date,
                        images: onValue.images,
                        isTitle: true,
                        section: onValue.section,
                        imageUrl: onValue.images[0]['path'],
                      ),
                )
            );
          });
        }else if(message['data']['category'] == "gallery"){

          /// TODO Here Change to Gallery


          var result = _notification.getGallery(message['data']['id']);
          result.then((onValue) {
            navigatorKey.currentState.pushReplacement(
                MaterialPageRoute(
                  builder: (_) =>


    //                GalleryDetails(
    //  {this.imageUrl, this.isGal, this.title, this.des, this.date, this.images, this.isTitle,this.section});
                      GalleryDetails(
                        imageUrl: onValue.images[0]['path'],
                         isTitle: true,
                         isGal: true,
                         images: onValue.images,
                         title: onValue.title,
                         date: onValue.date,
                         des: '',
                         section: '',
                      ),
                )
            );
          });

        }else if(message['data']['category'] == "video"){
                    print(message['data']);
                    _launchURL(message['data']['url']);
                              print(message['data']['url']);

        }
      },
      onResume: (Map<String, dynamic> message) async {
        print("4");

        print("onResume: $message");

        print("onLaunch: $message");
        if (message['data']['category'] == "news") {
          News news;
          var result = _notification.getNews(message['data']['id']);
          result.then((onValue) {
            navigatorKey.currentState.pushReplacement(
                MaterialPageRoute(
                  builder: (_) =>
                      DetailsPage(
                        isGal: false,
                        title: onValue.title,
                        des: onValue.content,
                        date: onValue.date,
                        images: onValue.images,
                        isTitle: true,
                        section: onValue.section,
                        imageUrl: onValue.images[0]['path'],
                      ),
                )
            );
          });
        }
        else if(message['data']['category'] == "gallery"){

          /// TODO Here Change to Gallery


          var result = _notification.getGallery(message['data']['id']);
          result.then((onValue) {
            navigatorKey.currentState.pushReplacement(
                MaterialPageRoute(
                  builder: (_) =>
                      GalleryDetails(
                        imageUrl: onValue.images[0]['path'],
                         isTitle: true,
                         isGal: true,
                         images: onValue.images,
                         title: onValue.title,
                         date: onValue.date,
                         des: '',
                         section: '',
                      ),
                )
            );
          });

        }else if(message['data']['category'] == "video"){

          /// TODO Here Change to Video
          print(message['data']['url']);
          print(message['data']);
          _launchURL(message['data']['url']);


        }

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


  Future _showNotification(Map<String, dynamic> message) async {
    var android = new AndroidNotificationDetails(
        'channel_id', "CHANNEL NAME", "Channel Description");
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);

    // Read Data
    String title = message['notification']['title'];
    String description = message['notification']['body'];
    try {
          await flutterLocalNotificationsPlugin.show(0, title, description, platform);
    } catch (e) {
      print(e);
    }
    return "uuuuu";
  }
  void firebaseCloudMessaging_Listeners() {


  }
  void iOS_Permission() {
    _fcm.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _fcm.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      // print("Settings registered: $settings");
    });
  }


  Future<String> _getId() async {

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;

      imei = iosDeviceInfo.identifierForVendor;
      platform = "iOS";
      brand = iosDeviceInfo.name;
      model = iosDeviceInfo.localizedModel;
      device = iosDeviceInfo.systemVersion;
      manufacturer = iosDeviceInfo.systemName;
      physical = iosDeviceInfo.isPhysicalDevice.toString();
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      imei = androidDeviceInfo.androidId;
      platform = "Android";
      brand = androidDeviceInfo.brand;
      model = androidDeviceInfo.model;
      device = androidDeviceInfo.device;
      manufacturer = androidDeviceInfo.manufacturer;
      physical = androidDeviceInfo.isPhysicalDevice.toString();

      return androidDeviceInfo.androidId;
      // unique ID on Android
    }
  }
  sendPhoneData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSend = prefs.getBool('send');
    if(isSend == null){
      networkHelper.sendPhoneData( model ,platform, device);
      prefs.setBool('send', true);
    } else{
      print(platform);
      print(model);
      print(device);
    }
  }




  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> navigatorKey = GlobalKey(
        debugLabel: "Main Navigator");

    _fcm.subscribeToTopic('notification');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _getId();
    sendPhoneData();
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              theme: ThemeData(
                  fontFamily: 'DINARB'
              ),
              debugShowCheckedModeBanner: false,
              title: 'UOITC',
              navigatorKey: navigatorKey,


              home: SplashScreen(),
              routes: {
                HomePageBody.id: (context) => HomePageBody(),
              },
            );
          },
        );
      },
    );

  }
}

