import 'package:akijgroup_assignment_app/domainlayer/appcolor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRResultPage extends StatelessWidget {
  Barcode barcoderesult;
  QRResultPage({super.key, required this.barcoderesult});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          //AppBar
          body: Center(
        child: Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.deepPurpleAccent[100],
          child: SizedBox(
            width: 320.w,
            height: 550.h,
            child: Padding(
              padding: EdgeInsets.all(8.0.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 108.r,
                      child: Center(
                        child: CircleAvatar(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.qr_code,
                                    size: 50.sp, color: AppColor.appcolor),
                                Text('Scan Result',
                                    style: TextStyle(fontSize: 30.sp)),
                              ]), //NetworkImage
                          radius: 100.r,
                        ),
                      ), //CircleAvatar
                    ), //CircleAvatar
                    SizedBox(
                      height: 10.h,
                    ), //SizedBox
                    Row(
                      children: [
                        Text(
                          'Barcode Type: \n${describeEnum(barcoderesult.format)}',
                          style: TextStyle(
                            fontSize: 25.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ), //Textstyle
                        ),
                      ],
                    ), //Text
                    SizedBox(
                      height: 10.h,
                    ), //SizedBox
                    Row(
                      children: [
                        Text(
                          'Data: \n${barcoderesult.code}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          maxLines: 4,
                          //Textstyle
                        ),
                      ],
                    ), //Text
                    SizedBox(
                      height: 30.h,
                    ), //SizedBox
                    SizedBox(
                      height: 60.h,
                      width: 150.w,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.touch_app,
                              size: 40.sp, color: AppColor.appcolor),
                          label: Text('Back',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.appcolor))),
                    ),
                    //SizedBox
                  ],
                ),
              ),
            ), //Padding
          ), //SizedBox
        ),
      )),
    );
  }
}
