import 'dart:async';
import 'package:driver_app_user/Login/LoginPage.dart';
import 'package:driver_app_user/introduction/introduction.dart';
import 'package:driver_app_user/locationPicker/locationPicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Global/GlobalPage.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  startTimer(){
    Timer(const Duration(seconds: 3),()async{
      if(await fAuth.currentUser==null){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>introductionScreen()));
      }else{
        crrentFirebaseUser=fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (_)=>LocationPicker()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/splash/splash2.json"),
              const SizedBox(height: 10,),
              const Text("Uber and InDriver",style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),

            ],
          ),
        ),
      ),
    );
  }
}
