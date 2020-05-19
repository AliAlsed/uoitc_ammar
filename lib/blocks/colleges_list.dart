import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uoitc/pages/colleage_detail.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/images.dart';
import 'package:uoitc/resourses/styling.dart';
import 'package:uoitc/ui/size_config.dart';

class CollegeListBlock extends StatefulWidget {
  final String collageName;
  final String imageUrl;
  final String date;
  final String description;
  final String location;
  final int is_evening;
  final List departments;
  CollegeListBlock({this.is_evening,this.collageName,this.imageUrl,this.date,this.description,this.location,this.departments});
  @override
  _CollegeListBlockState createState() => _CollegeListBlockState();
}

class _CollegeListBlockState extends State<CollegeListBlock> {
  @override
  Widget build(BuildContext context) {
    return collegeBlock(context,widget.collageName,widget.date,widget.imageUrl,widget.description,widget.location,widget.departments);
  }
}


Widget collegeBlock(BuildContext context,String collageName , String date, String imageUrl,String description,String location,List departments){
  return Container(
    alignment: Alignment.topRight,
    child: InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CollegeDetail(description: description,collegeName: collageName,date: date,imageUrl: imageUrl,location: location,departments: departments,),
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '$collageName',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 20
                    )
                  ),
                  Text(
                    'تأسست عام $date',
                    textDirection: TextDirection.rtl,
                    style: AppTheme.subTitle(color: grey, fixSize: 1.5),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 15,),
          Expanded(
            flex: 2,
            child: Container(
              height: 125,
              margin: EdgeInsets.all(1.2 * SizeConfig.widthMultiplier),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier),
                child: imageUrl == '' ? Image.asset(Images.uoitc):ClipRRect(
                  borderRadius: BorderRadius.circular(2.5 * SizeConfig.heightMultiplier),
                  child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: imageUrl,
                        placeholder: (context, url) => Image.asset(Images.loadingImage,fit: BoxFit.cover,),
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}