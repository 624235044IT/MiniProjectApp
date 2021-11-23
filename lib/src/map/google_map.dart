import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  State<GoogleMapPage> createState() => GoogleMapPageState();
}

class GoogleMapPageState extends State<GoogleMapPage> {
  Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = {};

  static final CameraPosition _initMap = CameraPosition(
    target: LatLng(7.961096730226103, 98.3351921834269),//จังหวัด
    zoom: 14.4746,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.blueGrey,

      ),
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: _initMap,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _dummyLoction();
        },
      ),
    );
  }
  Future<void> _dummyLoction() async {
    await Future.delayed(Duration(seconds: 2));
    List<LatLng> data = [
      LatLng(7.962672885740416, 98.38567058465816), //โบ๊ทลากูน รีสอร์ท
      LatLng(7.8855055242727286,98.39479065459089), //เรสซิเดนท์ ภูเก็ต
      LatLng(7.862049849501009, 98.36395579396253), //เจริญสินธานี
      LatLng(7.949219534933044, 98.28470803740129), //เอดีเอ็ม แพลทินัม เบย์
      LatLng(7.985141839413489, 98.2964827680852), // โมโน เรสซิเดนซ์ บางเทา บีช
      LatLng(7.986250316256298, 98.29625011878868), // โเดอะ ไทเทิ้ล วี
      LatLng(7.9912689541433775, 98.28137633727829), //ทวินปาล์ม เรสซิเดนซ์ มอนท์เอซัวร์
      LatLng(7.887357423177088, 98.40177159053628), //บ้านพรจันทร์
      LatLng(7.8126020342537155, 98.33030465907095), //บ้านร่่มเย็น
      LatLng(7.91155064160331, 98.39021139546992), //บเพชรรัตน์แมนชั่น
      LatLng(7.864492504253087, 98.37927921266625), //ณัฐทิชา แมนชั่น ภูเก็ต
    ];

    List<String> placeName = ['โบ๊ทลากูน รีสอร์ท','เรสซิเดนท์ ภูเก็ต ','เจริญสินธานี วิชิต','เอดีเอ็ม แพลทินัม เบย์','โมโน เรสซิเดนซ์ บางเทา บีช','เดอะ ไทเทิ้ล วี','ทวินปาล์ม เรสซิเดนซ์ มอนท์เอซัวร์','บ้านพรจันทร์'
    ,'บ้านร่มเย็น','เพชรรัตน์แมนชั่น','ณัฐทิชา แมนชั่น ภูเก็ต '
    ];
    for(int i=0; i<data.length; i++){
      await _addMarker(
        data[i],
        title: placeName[i],
        snippet: 'Go !!!!!!!',
        isShowInfo: true,
      );
    }
    _controller.future.then((controller) => controller.moveCamera(
        CameraUpdate.newLatLngBounds(_boundsFromLatLngList(data), 32)));
    setState(() {});
  }
  Future<Uint8List> _getBytesFromAsset(
      String path, {
        int width,
      }) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future<void> _addMarker(
      LatLng position, {
        String title = 'none',
        String snippet = 'none',
        String pinAsset = 'assets/images/pin.png',
        bool isShowInfo = false,
      }) async {
    final Uint8List markerIcon = await _getBytesFromAsset(
      pinAsset,
      width: 150,
    );
    final BitmapDescriptor bitmap = BitmapDescriptor.fromBytes(markerIcon);

    _markers.add(
      Marker(
        // important. unique id
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: isShowInfo
            ? InfoWindow(
          title: title,
          snippet: snippet,
          onTap: () => _launchMaps(
            lat: position.latitude,
            lng: position.longitude,
          ),
        )
            : InfoWindow(),
        icon: bitmap,
        onTap: () async {
          //todo
        },
      ),
    );
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double x0, x1, y0, y1 = 0;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1, y1),
      southwest: LatLng(x0, y0),
    );
  }

  void _launchMaps({double lat, double lng}) async {
    final parameter = '?z=16&q=$lat,$lng';

    if (Platform.isIOS) {
      final googleMap = 'comgooglemaps://';
      final appleMap = 'https://maps.apple.com/';
      if (await canLaunch(googleMap)) {
        await launch(googleMap + parameter);
        return;
      }
      if (await canLaunch(appleMap)) {
        await launch(appleMap + parameter);
        return;
      }
    } else {
      final googleMapURL = 'https://maps.google.com/';
      if (await canLaunch(googleMapURL)) {
        await launch(googleMapURL + parameter);
        return;
      }
    }
    throw 'Could not launch url';
  }


}//end class