import 'package:flutter/material.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MapController mapController;
  List<Point> points = [
    Point(-45.463604, 167.154470),
    Point(-45.463431, 167.154813),
    Point(-45.463619, 167.155961),
    Point(-45.462799, 167.156884),
    Point(-45.462791, 167.157560),
    Point(-45.463905, 167.157861),
  ];

  ///Generates the markers that get placed on the map
  List<Marker> getMarkers() {
    List<Marker> markers = List<Marker>();

    for (Point point in points) {
      markers.add(
        Marker(
          width: 20.0,
          height: 20.0,
          point: LatLng(point.x, point.y),
          builder: (context) => Container(
                child: IconButton(
                  icon: Icon(Icons.access_alarm),
                  color: Theme.of(context).accentColor,
                  iconSize: 45.0,
                  onPressed: () {},
                ),
              ),
        ),
      );
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map Example"),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: LatLng(-45.463983, 167.155695),
          minZoom: 14.0,
          maxZoom: 18.0,
          zoom: 16.0,
          swPanBoundary: LatLng(-45.486373, 167.134838),
          nePanBoundary: LatLng(-45.441585, 167.176552),
          plugins: [
            MarkerClusterPlugin(),
          ],
        ),
        layers: [
          TileLayerOptions(
            tileProvider: MBTilesImageProvider.fromAsset("assets/map.mbtiles"),
            maxZoom: 18.0,
            backgroundColor: Color(0xFF262626),
            tms: true,
          ),
          MarkerClusterLayerOptions(
            maxClusterRadius: 39,
            height: 40,
            width: 40,
            // fitBoundsOptions: FitBoundsOptions(
            //   padding: EdgeInsets.all(40),
            // ),
            markers: getMarkers(),
            showPolygon: false,
            builder: (context, markers) {
              return FloatingActionButton(
                child: Text(markers.length.toString()),
                onPressed: null,
              );
            },
          ),
        ],
      ),
    );
  }
}
