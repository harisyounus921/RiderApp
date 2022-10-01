import 'package:driver_app_user/helper/provider/latlongProvider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import '../MapScreen/MapScreen.dart';
import '../MapScreen/MapScreen2.dart';
import '../MapScreen/PickClickScreen.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({Key? key}) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  TextEditingController pickLocationcontroler=TextEditingController();
  TextEditingController dropLocationcontroler=TextEditingController();
//  bool pickText=false,dropText=false;
  double picklat=0,picklong=0,droplat=0,droplong=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.apps_outlined,color: Colors.black,),
        onPressed: (){},
        backgroundColor: Colors.white,

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Pickup location",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 30,),)),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: pickLocationcontroler,
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                   // labelText: " NAME",
                    hintText: " Enter Your Pickup location....",
                    //enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey,),),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                    //labelStyle: TextStyle(color: Colors.grey,fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 40,),
            Text("Pick Latitudes"+picklat.toString()),
            Text("Pick Longitude"+picklong.toString()),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: dropLocationcontroler,
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    // labelText: " NAME",
                    hintText: " Enter Your Drop location....",
                    //enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey,),),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                    //labelStyle: TextStyle(color: Colors.grey,fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 40,),
            Text("Drop Latitudes"+droplat.toString()),
            Text("Drop Longitude"+droplong.toString()),
              SizedBox(height: 80,),
             // (pickText==false&&dropText==false)? SearchButton(title: "Please enter Pick And Drop Location", onTap:(){}):
              SearchButton(title: "Search Location", onTap: ()async{
                List<Location> piclocations = await locationFromAddress(pickLocationcontroler.toString());
                List<Location> droplocations = await locationFromAddress(dropLocationcontroler.toString());

                setState(() {
                  picklong=piclocations.last.longitude;
                  picklat=piclocations.last.latitude;
                  droplat=droplocations.last.latitude;
                  droplong=droplocations.last.longitude;
                });
                Consumer<LatlongProvider>(
                    builder: (context,LatlongProvider,child) {
                      return LatlongProvider.setLocationlatlong(piclocations,droplocations);
                    });
                Consumer<LatlongProvider>(
                    builder: (context,LatlongProvider,child) {
                      return LatlongProvider.setDoublelatlong(piclocations.last.latitude,
                          piclocations.last.longitude,
                          droplocations.last.latitude,
                          droplocations.last.longitude);
                    });

                Navigator.push(context, MaterialPageRoute(builder: (_)=>MapScreen2(picklat: picklat,
                  picklong: picklong,
                  droplat: droplat,
                  droplong: droplong,)));

              }),
              SizedBox(height: 40,),
              SearchButton(title: "Go To MAP", onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (_)=>MapScreen()));
              }),
              SizedBox(height: 40,),
              SearchButton(title: "Go To Location Picker", onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (_)=>PickClickScreen()));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
class SearchButton extends StatelessWidget {

  final String title;
  final VoidCallback onTap;
  SearchButton({required this.title,required this.onTap});
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 1.0,right: 1),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xff1aa260),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text(title)),
            ),
          ),
        ),
      );
  }
}