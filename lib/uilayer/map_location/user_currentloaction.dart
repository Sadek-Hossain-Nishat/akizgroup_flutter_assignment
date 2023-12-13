import 'dart:convert';

import 'package:akijgroup_assignment_app/domainlayer/appcolor.dart';
import 'package:akijgroup_assignment_app/domainlayer/distancebettwolocation.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

class LocationandMapPage extends StatefulWidget {
  const LocationandMapPage({super.key});

  @override
  State<LocationandMapPage> createState() => _LocationandMapPageState();
}

class _LocationandMapPageState extends State<LocationandMapPage> {
  String locationMessage = 'Current user information';

  late String lat;
  late String long;

  double distance = 0.0;

  bool showgooglemap = false;

  static const targetlat = 23.7696;
  static const targetlong = 90.4103;

  @override
  void initState() {
    // TODO: implement initState
    _liveLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   leading: IconButton(
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //       icon: Icon(Icons.arrow_back_ios, color: AppColor.appcolor)),
          // ),
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0.w),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 50.h),
            Icon(Icons.location_on, color: AppColor.appcolor, size: 100.sp),
            Text('Location & Maps',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColor.appcolor)),
            SizedBox(height: 50.h),
            Text(locationMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey)),
            SizedBox(height: 50.h),
            ElevatedButton(
                onPressed: () {
                  _getCurrentLocation().then((value) {
                    lat = '${value.latitude}';
                    long = '${value.longitude}';

                    setState(() {
                      locationMessage = 'Latitude: $lat , Longitude: $long';
                      showgooglemap = true;
                      distance = distancebettwoLocation(targetlat, targetlong,
                          double.parse(lat), double.parse(long));
                      submitsuccess = false;
                    });

                    _liveLocation();
                  });
                },
                child: Text('Get Current Location',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ))),
            SizedBox(height: 20),
            showgooglemap == true
                ? Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            showgoogleMap();
                          },
                          child: Text('Show Location in Map',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ))),
                      SizedBox(height: 20),
                      Text(
                          distance <= 100.00
                              ? 'You are in Akiz House'
                              : 'You are far from Akiz House',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey)),
                      SizedBox(height: 20),
                      distance <= 100.00
                          ? ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: submitsuccess == true
                                  ? () {}
                                  : () {
                                      submitGeoPunch();
                                    },
                              icon: Icon(
                                  submitsuccess == true
                                      ? Icons.done
                                      : Icons.push_pin,
                                  size: 20.sp,
                                  color: AppColor.appcolor),
                              label: Text(
                                  submitsuccess == true
                                      ? 'Success'
                                      : 'Geo Punch',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.appcolor)))
                          : Container()
                    ],
                  )
                : Container()
          ]),
        ),
      )),
    );
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {}

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    LocationSettings locationSettings =
        const LocationSettings(accuracy: LocationAccuracy.high);

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      setState(() {
        // locationMessage = 'Latitude: $lat , Longitude: $long';
        lat = position.latitude.toString();
        long = position.longitude.toString();
      });
    });
  }

  Future<void> showgoogleMap() async {
    String googleURL =
        "https://www.google.com/maps/search/?api=1&query=$lat,$long";
    await canLaunchUrlString(googleURL)
        ? await launchUrlString(googleURL)
        : throw 'Could not launch $googleURL';
  }

  bool submitsuccess = false;

  Future<void> submitGeoPunch() async {
    final response = await http.post(
      Uri.parse('https://www.akijpipes.com/api/lat-long'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "user_id": 455,
        "lat": double.parse(lat),
        "long": double.parse(long)
      }),
    );
    print(response.statusCode);

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      setState(() {
        submitsuccess = true;
      });
    } else {
      setState(() {
        submitsuccess = false;
      });
    }
  }
}
