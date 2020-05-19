import 'package:flutter/material.dart';

class News{
            String id;
            String title;
            String url;
            String date;
            String content;
            String section;
            String views;
            List images;
            List files;

            News({
              @required this.id,
              @required this.title,
              @required this.url,
              @required this.date,
              @required this.content,
              @required this.section,
              @required this.views,
              @required this.images,
              this.files
            });

}