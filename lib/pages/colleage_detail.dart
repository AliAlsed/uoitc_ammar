import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uoitc/blocks/colleage_block.dart';
import 'package:uoitc/blocks/description_block.dart';
import 'package:uoitc/blocks/google_map.dart';
import 'package:uoitc/resourses/colors.dart';
import 'package:uoitc/resourses/styling.dart';
import 'package:uoitc/ui/size_config.dart';

class CollegeDetail extends StatelessWidget {
  final String collegeName;
  final String date;
  final String imageUrl;
  final String description;
  final String location;
  final int is_evening;
  final List departments;

  CollegeDetail(
      {this.collegeName,
      this.departments,
      this.date,
      this.imageUrl,
      this.description,
      this.location,
      this.is_evening});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    double width = MediaQuery.of(context).size.width;
    final topContent = Stack(
      children: <Widget>[
        Container(
          height: 39.9 * SizeConfig.heightMultiplier,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new NetworkImage(imageUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: 39.9 * SizeConfig.heightMultiplier,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .3)),
          child: Center(),
        ),
        Positioned(
          left: 8.0,
          top: 15.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        Positioned(
          top: 35.5 * SizeConfig.heightMultiplier,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2.9 * SizeConfig.heightMultiplier),
                  topRight: Radius.circular(2.9 * SizeConfig.heightMultiplier),
                ),
                color: Colors.white),
            height: 50,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ],
    );

    final DesBloc = Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20),
        child: RichText(
          textAlign: TextAlign.justify,
          textDirection: TextDirection.rtl,
          text: TextSpan(
            text: description,
            style: AppTheme.subTitle(fixSize: 1.7, color: Colors.grey),
          ),
        ));

    final titleBloc = Container(
      margin: EdgeInsets.only(bottom: 5),
      width: MediaQuery.of(context).size.width,
      child: ListTile(
        title: Text(
          collegeName,
          textDirection: TextDirection.rtl,
          style: AppTheme.title(color: black, fixSize: 3.5, isBold: true),
        ),
      ),
    );

    final blocks = CollegeBlock(
      date: date,
      is_evening: is_evening,
    );

    final mapBlock = Container(
      margin: EdgeInsets.all(1.2 * SizeConfig.heightMultiplier),
      width: width - 3 * SizeConfig.heightMultiplier,
      height: 25 * SizeConfig.heightMultiplier,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.3 * SizeConfig.heightMultiplier),
        child: GoogleMapBlock(location: location, title: collegeName),
      ),
    );

    final collegeListTitle = Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        right: 2.7 * SizeConfig.heightMultiplier,
        left: 2.7 * SizeConfig.heightMultiplier,
      ),
      child: Text(
        "الأقسام",
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: AppTheme.title(color: black, fixSize: 3.5, isBold: true),
      ),
    );

    final collegeList = SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: PageScrollPhysics(),
        itemCount: departments.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              departments[index]['title'],
              textDirection: TextDirection.rtl,
            ),
            subtitle: DescriptionBlock(
              text: departments[index]['description'],
            ),
          );
        },
      ),
    );

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[titleBloc, DesBloc, blocks,mapBlock ,collegeListTitle , collegeList],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:uoitc/Animation/faed_animatoin.dart';
// import 'package:uoitc/blocks/colleage_block.dart';
// import 'package:uoitc/blocks/description_block.dart';
// import 'package:uoitc/blocks/google_map.dart';
// import 'package:uoitc/resourses/colors.dart';
// import 'package:uoitc/resourses/images.dart';
// import 'package:uoitc/resourses/styling.dart';
// import 'package:uoitc/ui/size_config.dart';

// class CollegeDetail extends StatefulWidget {
//   final String collegeName;
//   final String date;
//   final String imageUrl;
//   final String description;
//   final String location;
//   final int is_evening;
//   final List departments;

//   CollegeDetail(
//       {this.collegeName, this.departments, this.date, this.imageUrl, this.description, this.location, this.is_evening});

//   @override
//   _CollegeDetailState createState() => _CollegeDetailState();
// }

// class _CollegeDetailState extends State<CollegeDetail>
//     with TickerProviderStateMixin {
//   AnimationController _controller;
//   Animation<double> _animation;
//   Animation<double> _PicAnimation;
//   bool isAnimComplete = false;

//   String _text = "specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//     _animation = Tween<double>(begin: -40.5 * SizeConfig.heightMultiplier, end: -13.6 * SizeConfig.heightMultiplier).animate(_controller);
//     _PicAnimation = Tween<double>(begin: 0.7, end: 0.4).animate(_controller);
//   }

//   animationInit() {
//     (isAnimComplete) ? _controller.reverse() : _controller.forward();

//     isAnimComplete = !isAnimComplete;
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery
//         .of(context)
//         .size
//         .width;
//     return Container(
//       child: Scaffold(
//         body: FadeAnimation(
//           1.5,
//           Stack(
//             fit: StackFit.expand,
//             children: <Widget>[
//               FractionallySizedBox(
//                 alignment: Alignment.topCenter,
//                 heightFactor: _PicAnimation.value,
//                 child: Container(
//                     height: double.infinity,
//                     child: CachedNetworkImage(
//                       imageUrl: widget.imageUrl,
//                       fit: BoxFit.fill,
//                       placeholder: (context, url) =>
//                           Image.asset(Images.loadingImage,fit: BoxFit.fill,),
//                     )
//                 ),
//               ),

//               // Back Arrow
//               Positioned(
//                 top: 5,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       SafeArea(
//                         child: MaterialButton(
//                           padding: EdgeInsets.all(8.0),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20)),
//                           child: Icon(Icons.arrow_back),
//                           textColor: Colors.white,
//                           minWidth: 0,
//                           height: 40,
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Content
//               Positioned(
//                 bottom: _animation.value,
//                 child: GestureDetector(
//                   onVerticalDragStart: (DragStartDetails details) {
//                     animationInit();
//                   },
//                   onVerticalDragUpdate: (DragUpdateDetails details) {
//                     setState(() {});
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(
//                                 4 * SizeConfig.heightMultiplier),
//                             topLeft: Radius.circular(
//                                 4 * SizeConfig.heightMultiplier)
//                         )
//                     ),
//                     alignment: Alignment.bottomCenter,
//                     height: MediaQuery.of(context).size.height,
//                     width: MediaQuery.of(context).size.width,
//                     child: Container(
//                       alignment: Alignment.topCenter,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           SizedBox(height: 4.5 * SizeConfig.heightMultiplier,),
//                           ListTile(
//                             title: Text(
//                               widget.collegeName,
//                               textDirection: TextDirection.rtl,
//                               style: AppTheme.title(color: black,
//                                   fixSize: 3.5,
//                                   isBold: true),
//                             ),
//                           ),

//                           SizedBox(
//                             width: MediaQuery.of(context).size.width,
//                             child: SingleChildScrollView(
//                               physics: BouncingScrollPhysics(),
//                               child: Column(
//                                 children: <Widget>[
//                                   // blocks
//                                   CollegeBlock(date: widget.date,
//                                     is_evening: widget.is_evening,),
//                                   // Map
//                                   Container(
//                                     margin: EdgeInsets.all(1.2 *
//                                         SizeConfig.heightMultiplier),
//                                     width: width -
//                                         3 * SizeConfig.heightMultiplier,
//                                     height: 25 * SizeConfig.heightMultiplier,
//                                     child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(
//                                             2.3 * SizeConfig.heightMultiplier),
//                                         child: GoogleMapBlock(
//                                           location: widget.location,title:widget.collegeName)
//                                     ),
//                                   ),
//                                   Container(
//                                     width: MediaQuery
//                                         .of(context)
//                                         .size
//                                         .width,
//                                     margin: EdgeInsets.only(
//                                       right: 2.7 * SizeConfig.heightMultiplier,
//                                       left: 2.7 * SizeConfig.heightMultiplier,),
//                                     child: Text(
//                                       "الأقسام",
//                                       textAlign: TextAlign.right,
//                                       textDirection: TextDirection.rtl,
//                                       style: AppTheme.title(color: black,
//                                           fixSize: 3.5,
//                                           isBold: true),
//                                     ),
//                                   ),

//                                   // Description
//                                   SizedBox(
//                                     width: MediaQuery
//                                         .of(context)
//                                         .size
//                                         .width,
//                                     child: ListView.builder(
//                                       shrinkWrap: true,
//                                       physics: PageScrollPhysics(),
//                                       itemCount: widget.departments.length,
//                                       itemBuilder: (BuildContext context,
//                                           int index) {
//                                         return ListTile(
//                                           title: Text(
//                                             widget.departments[index]['title'],
//                                             textDirection: TextDirection.rtl,),
//                                           subtitle: DescriptionBlock(
//                                             text: widget
//                                                 .departments[index]['description'],),
//                                         );
//                                       },
//                                     ),
//                                   )

//                                 ],
//                               ),
//                             ),
//                           ),

//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
