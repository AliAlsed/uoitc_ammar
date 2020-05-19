import 'dart:io';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {

  UrlLauncherUtils._();
  static void callNumber(String phone) async {
    var url = "tel:$phone";

    if (await UrlLauncher.canLaunch(url)) {
      await UrlLauncher.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void openLink(String link) async {
    var url = link;

    if (await UrlLauncher.canLaunch(url)) {
      await UrlLauncher.launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  static void openEmail(String email) async {
    var url = "mailto:$email?subject=News&body=New%20plugin";

    if (await UrlLauncher.canLaunch(url)) {
      await UrlLauncher.launch(url);
    } else {
      print('Could not launch $url');
    }
  }

static void facebookOpen() async {
    String facebookLink = "https://www.facebook.com/uoitc/";
    String fbProtocolUrl = "fb://page/1582026552014081/";
    String fbProtocolUrlIOS = "fb://profile/1582026552014081/";
    String facebookURL = Platform.isIOS?fbProtocolUrlIOS:fbProtocolUrl;
    String facebookURLBrowser = Platform.isIOS?fbProtocolUrlIOS:facebookLink;
    try {
      bool launched = await launch(facebookURL, forceSafariVC: false);

      if (!launched) {
        await launch(facebookURLBrowser, forceSafariVC: false);
      }
    } catch (e) {
      await launch(facebookURLBrowser, forceSafariVC: false);
    }

  
  }
}