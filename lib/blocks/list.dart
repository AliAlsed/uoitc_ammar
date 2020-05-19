import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uoitc/model/gallery.dart';
import 'package:uoitc/model/news.dart';
import 'package:uoitc/network/network.dart';
import 'package:uoitc/pages/detail_page.dart';
import 'package:uoitc/pages/gallery_Details.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/resourses/styling.dart';
import 'package:uoitc/ui/size_config.dart';

class ListViewItem extends StatefulWidget {
  final String title;
  final String subTitle;
  List<News> news;
  List<Gallery> gallery;
  final bool isGallery;
  List images;

  ListViewItem(
      {this.news,
      this.gallery,
      this.title,
      this.subTitle,
      this.isGallery,
      this.images});

  @override
  _ListViewItemState createState() => _ListViewItemState();
}

class _ListViewItemState extends State<ListViewItem> {
  NetworkHelper networkHelper = NetworkHelper();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 20,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount:
              widget.isGallery ? widget.gallery.length : widget.news.length,
          physics: ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (!widget.isGallery) {
              if (index == 0) {
                return SizedBox();
              }
            }
            return Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget.isGallery
                          ? GalleryDetails(
                              isTitle: true,
                              isGal: true,
                              images: widget.gallery[index].images,
                              title: widget.gallery[index].title,
                              date: widget.gallery[index].date,
                              des: widget.gallery[index].id.toString(),
                            )
                          : DetailsPage(
                            section: widget.news[index].section,
                              isTitle: true,
                              isGal: false,
                              images: widget.news[index].images,
                              imageUrl: widget.news[index].images[0]['path'],
                              title: widget.news[index].title,
                              date: widget.news[index].date.toString(),
                              des: widget.news[index].content,
                            ),
                    ),
                  );
                  if (widget.isGallery == false) {
                    networkHelper
                        .incrementViews(int.parse(widget.news[index].id));
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // Text
                    Container(
                      width: width - 40 * SizeConfig.widthMultiplier,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                                widget.isGallery
                                    ? widget.gallery[index].title
                                    : widget.news[index].title,
                                textDirection: TextDirection.rtl,
                                style: AppTheme.title(
                                    color: black, fixSize: 1.7, isBold: true)),
                            subtitle: widget.isGallery
                                ? detail(widget.gallery[index].date,
                                    widget.gallery[index].images.length)
                                : detailWithoutNum(widget.news[index].date,widget.news[index].section),
                          ),
                        ],
                      ),
                    ),

                    // Image
                    Container(
                      margin: EdgeInsets.only(top: 7, bottom: 7, left: 7),
                      width: 15 * SizeConfig.heightMultiplier,
                      height: 15 * SizeConfig.heightMultiplier,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.isGallery
                                ? widget.gallery[index].images[0]['path']
                                : widget.news[index].images[0]['path'],
                            placeholder: (context, url) => Stack(
                              children: <Widget>[
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 75 * SizeConfig.imageSizeMultiplier,
                                    child: Image.asset(
                                      Images.loadingImage,
                                      fit: BoxFit.cover,
                                    )),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

Widget detailWithoutNum(String subTitle,String section) {
  String date = subTitle.substring(0, 11);
  String date1 = section + "            " + subTitle.substring(0, 11);
  return Container(
    alignment: Alignment.topRight,
    child: Text(date1,
        textDirection: TextDirection.rtl,
        style: AppTheme.title(color: grey, fixSize: 1.3, isBold: true)),
  );
}

Widget detail(String subTitle, int numOfPic) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      // Num of pic
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          ' $numOfPic صورة ',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            color: grey,
            fontSize: 1.5 * SizeConfig.textMultiplier,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      SizedBox(
        width: 4 * SizeConfig.widthMultiplier,
      ),

      // department and release date
      Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(right: 0),
        child: Text(
          subTitle.substring(0, 11),
          textDirection: TextDirection.rtl,
          style: AppTheme.title(color: grey, fixSize: 1.3, isBold: true),
        ),
      ),
    ],
  );
}
