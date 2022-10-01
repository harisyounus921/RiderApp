import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickClickScreen extends StatefulWidget {
  const PickClickScreen({Key? key}) : super(key: key);

  @override
  _PickClickScreenState createState() => _PickClickScreenState();
}

class _PickClickScreenState extends State<PickClickScreen> {
  BitmapDescriptor mapMarker='assets/pick.png' as BitmapDescriptor;
  Set<Marker> _markers={};
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMarker();
  }
void setCustomMarker()async{
    BitmapDescriptor mapMarker =await BitmapDescriptor.fromAssetImage(ImageConfiguration(),'assets/pick.png');
  }
void onMapCreated(GoogleMapController controller){
setState(() {
  _markers.add(const Marker(markerId: MarkerId("1"),
      position:LatLng(31.572197762446823, 74.36913417243082),
    //  icon: mapMarker!,
      infoWindow:InfoWindow(
        title: 'Home',
        snippet: "MET-1"

      ) ));
});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(/*
        markers: markers,
        onTap: (pos) {
          print(pos);
          Marker m =
          Marker(markerId: MarkerId('1'), icon: customIcon, position: pos);
          setState(() {
            markers.add(m);
          });
        },*/
        onMapCreated: onMapCreated,
        initialCameraPosition:
        CameraPosition(target: LatLng(31.572197762446823, 74.36913417243082), zoom: 18),
      ),
    );
  }
}