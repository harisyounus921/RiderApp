import 'dart:async';
import 'dart:typed_data';
import 'dart:ui'as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Global/GlobalPage.dart';
import '../Splash/splash_screen.dart';

class MapScreen2 extends StatefulWidget {
  double picklat,picklong,droplat,droplong;

  MapScreen2({Key? key,this.picklat=1.1,
    this.picklong=27.1,this.droplat=1.1,this.droplong=27.1,}) : super(key: key);

  @override
  _MapScreen2State createState() => _MapScreen2State();
}

class _MapScreen2State extends State<MapScreen2> {

  final Completer<GoogleMapController> _controller=Completer();
  final Set<Polyline>_polyline={};
  List<Marker> marker=[];
  Future<Uint8List> getBytesFromAssets(String path,int width)async{
    ByteData data= await rootBundle.load(path);
    ui.Codec codec=await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight: width);
    ui.FrameInfo fi=await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
set(){
setState(() {
  marker.add(Marker(
    markerId: MarkerId('1'),
    position: LatLng(widget.picklat,widget.picklong),
    infoWindow: InfoWindow(
      title: "Sorce",
    ),
   // icon: BitmapDescriptor.fromBytes(await getBytesFromAssets('assets/drop.png', 100),),
  ),);
  marker.add(Marker(
  markerId: MarkerId('2'),
  position: LatLng(widget.droplat,widget.droplong),
  infoWindow: InfoWindow(
  title: "Destination",
  ),
  //icon:    BitmapDescriptor.fromBytes(await getBytesFromAssets('assets/pick.png', 100),),
  //  icon: BitmapDescriptor.fromBytes(await getBytesFromAssets('assets/drop.png', 100)),
  ));
  _polyline.add(Polyline(
  polylineId: PolylineId(1.toString()),
  visible: true,
  points:  [
  LatLng(widget.picklat,widget.picklong),
  LatLng(widget.droplat,widget.droplong),
  ],
  color: Colors.blue,
  ));
});
}
  @override
  void initState(){
    super.initState();
    set();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver App"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
              itemBuilder: (context)=>[
                PopupMenuItem(
                    onTap: (){
                      _controller.future.then((value){
                        DefaultAssetBundle.of(context).loadString('assets/Map/silver_theme.json').then((string) {
                          setState(() {
                          });
                          value.setMapStyle(string);
                        });
                      }).catchError((error) {
                        print("error"+error.toString());
                      });
                    },
                    child: Text("Silver")),
                PopupMenuItem(
                    onTap: (){
                      _controller.future.then((value){
                        DefaultAssetBundle.of(context).loadString('assets/Map/retro_theme.json').then((string) {
                          setState(() {
                          });
                          value.setMapStyle(string);
                        });
                      }).catchError((error) {
                        print("error"+error.toString());
                      });
                    },
                    child: Text("Retro")),
                PopupMenuItem(
                    onTap: (){
                      _controller.future.then((value){
                        DefaultAssetBundle.of(context).loadString('assets/Map/night_theme.json').then((string) {
                          setState(() {
                          });
                          value.setMapStyle(string);
                        });
                      }).catchError((error) {
                        print("error"+error.toString());
                      });
                    },
                    child: Text("Night")),
                PopupMenuItem(
                    onTap: (){
                      fAuth.signOut();
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>MySplashScreen()));
                      setState(() {
                      });
                    },
                    child: Text("Sign Out")),
              ]),
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.picklat,widget.picklong),
              zoom: 14.4746),

          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          compassEnabled: true,
          polylines:_polyline,

          markers: Set<Marker>.of(marker),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
