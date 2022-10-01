import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';

class LatlongProvider with ChangeNotifier{

  late double _picklat,_picklong,_droplat,_droplong;

  double get picklat=>_picklat;
  double get picklong=>_picklong;
  double get droplat=>_droplat;
  double get droplong=>_droplong;

  late List<Location> _piclocations,_droplocation;

  List<Location> get piclocations=>_piclocations;
  List<Location> get droplocation=>_droplocation;

  setLocationlatlong(List<Location> pickloca,List<Location> droploca){
    _piclocations=pickloca;
    _droplocation=droploca;
    notifyListeners();
  }

  setDoublelatlong(double picklatitude,double picklongitude,double droplatitude,double droplongitude){
    _picklat=picklatitude;
    _picklong=picklongitude;
    _droplat=droplatitude;
    _droplong=droplongitude;
    notifyListeners();
  }

}