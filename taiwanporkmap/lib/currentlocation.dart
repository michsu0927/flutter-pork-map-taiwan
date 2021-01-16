import 'package:latlong/latlong.dart' as latLng;
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';

class ZoomMap {
  double currentZoom = 15.0;
  latLng.LatLng currentCenter = latLng.LatLng(25.0330, 121.5654);

  //getter setter
  latLng.LatLng get currentCenterLatLng => currentCenter;
  set currentCenterLatLng(latLng.LatLng value) {
    currentCenter = value;
  }

  MapController mapController = MapController();
  int floatBtn = 1;
  ZoomMap();

  //_zoom is private function
  void zoom() {
    if (floatBtn == 1) {
      currentZoom = currentZoom + 1;
    }
    if (floatBtn == 0) {
      currentZoom = currentZoom - 1;
    }
    if (currentZoom >= 18) {
      floatBtn = 0;
    }
    if (currentZoom <= 7) {
      floatBtn = 1;
    }
    print(currentCenter);
    print(currentZoom);
    mapController.move(currentCenter, currentZoom);
  }
}

//ignore: must_be_immutable
class CurrentLocation extends StatefulWidget {
  MapController mapController;
  ZoomMap zoomMap;

  CurrentLocation(MapController mapController, ZoomMap zoomMap, {Key key})
      : super(key: key) {
    this.zoomMap = zoomMap;
    this.mapController = mapController;
  }

  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  var icon = Icons.gps_not_fixed;

  void _moveToCurrent() async {
    var location = Location();

    try {
      var currentLocation = await location.getLocation();

      widget.zoomMap.currentCenter =
          latLng.LatLng(currentLocation.latitude, currentLocation.longitude);
      widget.zoomMap.currentZoom = 16;
      widget.mapController.move(
          latLng.LatLng(currentLocation.latitude, currentLocation.longitude),
          widget.zoomMap.currentZoom);

      setState(() {
        icon = Icons.gps_fixed;
      });
      await widget.mapController.position.first;
      setState(() {
        icon = Icons.gps_not_fixed;
      });
    } catch (e) {
      setState(() {
        icon = Icons.gps_off;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: _moveToCurrent,
    );
  }
}