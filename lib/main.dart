
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:yuktidea/getStarted.dart';
import 'package:yuktidea/signUp.dart';
import 'package:yuktidea/verifyOtp.dart';

import 'home.dart';
import 'login.dart';


void main() async {

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.yuktidea,
    systemNavigationBarColor: Colors.yuktidea,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHome(),
        routes: {

          'home' : (context) => Home(),
          'getStarted' : (context) => GetStarted(),
          'verifyOtp' : (context) => VerifyOtp(),
          'login' : (context) => Login(),
          'signUp' : (context) => SignUp(),

        },
      ));
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  late StreamSubscription subscription;
  var isDeviceConnected = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLocationPermission();
    getConnectivity();
  }

  checkLocationPermission() async {
    // locationPermission = await Geolocator.requestPermission();
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    // if(locationPermission == LocationPermission.denied){
    //   locationPermission = await Geolocator.requestPermission();
    // } else if(!isDeviceConnected){
    //   showDialogBox();
    // }
    if(!isDeviceConnected){
      showDialogBox();
    }
  } //checkLocationPermission

  getConnectivity(){
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      // if(isDeviceConnected && isAlertSet == false) {
      if(!isDeviceConnected) {
        showDialogBox();
      }
    });
  }

  showDialogBox() {
    showCupertinoDialog<String>(
      context : context,
      builder: (BuildContext context) =>
          CupertinoAlertDialog(
            title: const Text("No Internet"),
            content: const Text("Turn on internet.....Waggon does not work properly without internet"),
            actions: <Widget>[
              TextButton(onPressed: () async {
                // Fluttertoast.showToast(msg: "App");
                Navigator.pop(context);
              },
                child: const Text("OK"),
              )
            ],
          ),

    ); //showCupertinoDialog


  }

  @override
  Widget build(BuildContext context) {
    return GetStarted();
  } //build

} //_MyHomeState
