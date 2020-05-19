import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapBlock extends StatefulWidget {
  final String title;
  final String location;

  GoogleMapBlock({this.title, this.location});

  @override
  _GoogleMapBlockState createState() => _GoogleMapBlockState();
}

class _GoogleMapBlockState extends State<GoogleMapBlock> {
  Completer<GoogleMapController> _controller = Completer();


  @override
  Widget build(BuildContext context) {
    List locations = widget.location.split(',');
    return Container(
      color: Colors.indigo,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(double.parse(locations[0]),double.parse(locations[1])), zoom: 16),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          _newyorkMark(locations,widget.title),
        },
      ),
    );
  }

  Marker _newyorkMark(List loc,String title) {
    return Marker(
        markerId: MarkerId('newyork1'),
        position: LatLng(double.parse(loc[0]),double.parse(loc[1])),
        infoWindow: InfoWindow(title: title)
    );
  }

}

