import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as latLng;
import 'currentlocation.dart';
import 'markinfowindow.dart';
import 'getjsonmapmark.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '台灣豬地圖'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //this config Map zoom
  ZoomMap zoomMap = new ZoomMap();
  //bool showInfoWindow = false;
  //this config Map Marker infoWindow Data
  InfoWindowData _infoWindowData = new InfoWindowData();

  //marker list
  var markers = <Marker>[];

  //_zoom is private function
  void _zoom() {
    zoomMap.zoom();
  }

  void _openInfoWindow({
    String name,
    String caseCode,
    String context,
    String address,
    String weekDay,
    String businessStartTime,
    String businessEndTime,
    String validDate,
    String updateDateTime,
  }){
    ///名稱	@name market_name
    ///標章代碼	@caseCode case_code
    ///介紹	@context context
    ///住址	@address addr
    ///營業天 @weekDay business_week
    ///營業時間	@businessTime business_hours business_hours_end
    ///有效日期	 @validDate ValidDate
    ///更新時間	@updateDateTime last_edited_date
    ///@isShow Show or hide
    setState(() {
      //showInfoWindow = showInfoWindow ? false : true;
      _infoWindowData.isShow = _infoWindowData.isShow ? false : true;
      if (name!=null) {
        _infoWindowData.name = name;
      }
      if (caseCode!=null) {
        _infoWindowData.caseCode = caseCode;
      }
      if (address!=null) {
        _infoWindowData.address = address;
      }
      if (weekDay!=null) {
        _infoWindowData.weekDay = weekDay;
      }
      if (validDate!=null) {
        _infoWindowData.validDate = validDate;
      }
      if (updateDateTime!=null) {
        _infoWindowData.updateDateTime = updateDateTime;
      }
      if ((businessStartTime!=null)&&(businessEndTime!=null)) {
        _infoWindowData.businessTime = '$businessStartTime ~ $businessEndTime';
      }
      if (context!=null) {
        _infoWindowData.context = removeAllHtmlTags(context);
      }

    });
  }

  //remove html tags function
  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );
    return htmlText.replaceAll(exp, '');
  }

  _MyHomePageState() : super() {
    var getMark = new GetJsonMapMark();
    //feature aysnc then
    getMark.getMarkList().then((value) => _updateMakers(value));
    //getMark.getMarkList().then((value){_updateMakers(value);});
    //print(getMark.markList);
  }

  void _updateMakers(List data){
    for(final map in data){
      //print(map['Latitude']);
      //print(map['Lontitude']);
      var point = latLng.LatLng( map['Latitude'] , map['Lontitude'] );
      //var point = latLng.LatLng( double.parse(map['Latitude']) , double.parse(map['Lontitude']) );
      Marker m  =Marker(
        width: 30.0,
        height: 30.0,
        point: point,
        anchorPos: AnchorPos.align( AnchorAlign.top),
        builder: (ctx) => Container(
            child: InkWell(
              child: Icon(Icons.maps_ugc,color: Colors.red,size:30),
              onTap: (){
                _openInfoWindow(
                  name: map['market_name'],
                  caseCode: map['case_code'],
                  context: map['context'],
                  address: map['addr'],
                  weekDay: map['business_week'],
                  businessStartTime: map['business_hours'],
                  businessEndTime: map['business_hours_end'],
                  validDate: map['ValidDate'],
                  updateDateTime: map['last_edited_date'],
                );
              },
            )
          // Icon(Icons.maps_ugc,
          //   color: Colors.red,
          //   size:
          //   20.0), //Icon(Icons.map_rounded , size: 24.0,color: Colors.red),
        ),
      );
      markers.add(m);
    }
    _zoom(); //refresh map
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Flexible(
                  child: FlutterMap(
                    mapController: zoomMap.mapController,
                    options: MapOptions(
                      center: zoomMap.currentCenter,
                      zoom: zoomMap.currentZoom,
                      maxZoom: 18,
                      minZoom: 6,
                      //crs: CrsSimple()
                      //bounds: LatLngBounds(LatLng(58.8, 6.1), LatLng(59, 6.2)),
                      //boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(8.0)),
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                        'https://wmts.nlsc.gov.tw/wmts/EMAP/default/GoogleMapsCompatible/{z}/{y}/{x}',
                        subdomains: ['a', 'b', 'c'],
                        // For example purposes. It is recommended to use
                        // TileProvider with a caching and retry strategy, like
                        // NetworkTileProvider or CachedNetworkTileProvider
                        tileProvider: NonCachingNetworkTileProvider(),
                      ),
                      MarkerLayerOptions(markers: markers)
                      //MarkerLayerOptions(markers: markers)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 100,
              child: Row(children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      //color: Colors.pink,
                      height: 56.0,
                      width: 56.0,
                      decoration: new BoxDecoration(
                        color: Colors.pink,
                        shape: BoxShape.circle,
                      ),
                      child: CurrentLocation(zoomMap.mapController, zoomMap),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton(
                      onPressed: _zoom,
                      tooltip: 'zoom',
                      child: Icon(Icons.aspect_ratio),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          MarkInfoWindow(
            isShow:_infoWindowData.isShow,
            address:_infoWindowData.address,
            businessTime:_infoWindowData.businessTime,
            caseCode:_infoWindowData.caseCode,
            context:_infoWindowData.context,
            name:_infoWindowData.name,
            updateDateTime:_infoWindowData.updateDateTime,
            validDate:_infoWindowData.validDate,
            weekDay:_infoWindowData.weekDay,
            boolCallback: (val) => setState(() => _infoWindowData.isShow = val)
          ),
        ],
      ),
      //floatingActionButton: , // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
