import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Working extends StatefulWidget {
  @override
  _WorkingState createState() => _WorkingState();
}

class _WorkingState extends State<Working> with TickerProviderStateMixin {
  MapController mapController;
  Widget currentPage;
  FlutterMap three;
  LatLng location = LatLng(-45.470442, 167.165120); 

  @override
  void initState() {
    super.initState();
    three = map();
    currentPage = three;
    mapController = MapController();
  }

  ///returns the map
  FlutterMap map() {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: LatLng(-45.463983, 167.155695),
        minZoom: 14.0,
        maxZoom: 18.0,
        zoom: 16.0,
        swPanBoundary: LatLng(-45.486373, 167.134838),
        nePanBoundary: LatLng(-45.441585, 167.176552),
      ),
      layers: [
        TileLayerOptions(
          tileProvider: MBTilesImageProvider.fromAsset("assets/map.mbtiles"),
          maxZoom: 18.0,
          backgroundColor: Color(0xFF262626),
          tms: true,
        ),
      ],
    );
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Working Example')),
      body: currentPage == three ? map() : currentPage,
      floatingActionButton: FloatingActionButton.extended(
        icon: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 4.0, 0),
          child: Icon(Icons.ac_unit),
        ),
        label: Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 2.0, 8.0, 2.0),
          child: Text(
            "Move",
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        onPressed: () => _animatedMapMove(location, 18.0),
        backgroundColor: Theme.of(context).accentColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
