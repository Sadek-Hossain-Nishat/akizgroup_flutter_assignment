import 'package:akijgroup_assignment_app/uilayer/makeorder/make_order.dart';
import 'package:akijgroup_assignment_app/uilayer/map_location/location_tabbar.dart';
import 'package:akijgroup_assignment_app/uilayer/map_location/user_currentloaction.dart';
import 'package:akijgroup_assignment_app/uilayer/qr_scan/qrscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import 'domainlayer/appcolor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
        designSize: Size(width, height),
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // This is the theme of your application.
              //
              // TRY THIS: Try running your application with "flutter run". You'll see
              // the application has a blue toolbar. Then, without quitting the app,
              // try changing the seedColor in the colorScheme below to Colors.green
              // and then invoke "hot reload" (save your changes or press the "hot
              // reload" button in a Flutter-supported IDE, or press "r" if you used
              // the command line to start the app).
              //
              // Notice that the counter didn't reset back to zero; the application
              // state is not lost during the reload. To reset the state, use hot
              // restart instead.
              //
              // This works for code too, not just values: Most code changes can be
              // tested with just a hot reload.
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: AppColor.appcolor,
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 150.h,
              width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.light,
                          color: Colors.transparent,
                        )),
                    Text(
                      'Home',
                      style: TextStyle(fontSize: 22.sp, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(28.r),
                      topLeft: Radius.circular(28.r))),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Welcome to Akiz',
                        style: TextStyle(
                            fontSize: 22.sp, color: AppColor.appcolor),
                      ),
                      Text(
                        'Please visit to see all of our services.',
                        style: TextStyle(
                            fontSize: 14.sp, color: Color(0xFFBBBBBB)),
                      ),
                      SizedBox(
                        height: 45.h,
                      ),
                      SizedBox(
                          height: 60.h,
                          width: 400.w,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColor.appcolor),
                              ),
                              onPressed: () {
                                handleQRScanAction();
                              },
                              icon: Icon(Icons.qr_code,
                                  size: 40.sp, color: Colors.white),
                              label: Text('Scan QR Code',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)))),
                      SizedBox(height: 20.h),
                      SizedBox(
                          height: 60.h,
                          width: 400.w,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColor.appcolor),
                              ),
                              onPressed: () {
                                handleGEOPunchAction();
                              },
                              icon: Icon(Icons.location_on,
                                  size: 40.sp, color: Colors.white),
                              label: Text('Geo Punch',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)))),
                      SizedBox(height: 20.h),
                      SizedBox(
                          height: 60.h,
                          width: 400.w,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColor.appcolor),
                              ),
                              onPressed: () {
                                handleOrderAction();
                              },
                              icon: Icon(Icons.add_box,
                                  size: 40.sp, color: Colors.white),
                              label: Text('Make Order',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)))),
                    ],
                  ),
                ),
              ),
            ))
          ],
        )));
  }

  Future<void> handleQRScanAction() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.

      await Permission.camera.onDeniedCallback(() {
        // Your code
      }).onGrantedCallback(() {
        gotoQRScranPage();
        // Your code
      }).onPermanentlyDeniedCallback(() {
        // Your code
      }).onRestrictedCallback(() {
        // Your code
      }).onLimitedCallback(() {
        // Your code
      }).onProvisionalCallback(() {
        // Your code
      }).request();
    }

    if (status.isGranted) {
      gotoQRScranPage();
    }
  }

  void gotoQRScranPage() {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, scecondayranimation) =>
                QRScanPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            }));
  }

  void handleGEOPunchAction() {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, scecondayranimation) =>
                Locationtabbar(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            }));
  }

  void handleOrderAction() {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, scecondayranimation) =>
                MakeOrderPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            }));
  }
}
