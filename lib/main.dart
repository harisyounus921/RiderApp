import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MapScreen/MapScreen2.dart';
import 'Splash/splash_screen.dart';
import 'helper/provider/latlongProvider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MyApp(
        child:MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=>LatlongProvider()),
          ],
          child: Builder(builder: (BuildContext context) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              debugShowCheckedModeBanner: false,
              home: MySplashScreen(),
            );
            },
          ),),),
  );}

class MyApp extends StatefulWidget {
  final Widget? child;
  const MyApp({Key? key,this.child}) : super(key: key);

  static void restartApp(BuildContext context){
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Key key =UniqueKey();
  void restartApp(){
    setState(() {
      key=UniqueKey();
    });
  }
  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,);
  }
}
