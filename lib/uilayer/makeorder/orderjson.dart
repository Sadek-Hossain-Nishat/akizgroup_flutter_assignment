import 'dart:convert';

import 'package:akijgroup_assignment_app/domainlayer/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderJsonPage extends StatefulWidget {
  String? stringjson;
  OrderJsonPage({super.key, this.stringjson});

  @override
  State<OrderJsonPage> createState() => _OrderJsonPageState();
}

class _OrderJsonPageState extends State<OrderJsonPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon:
                        Icon(Icons.arrow_back_ios, color: AppColor.appcolor))),
            body: Padding(
              padding: EdgeInsets.all(20.0.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      'JSON Result',
                      style: TextStyle(
                          color: AppColor.appcolor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 30.h),
                    Text('${json.encode(json.decode(widget.stringjson!))}',
                        style: TextStyle(
                            color: AppColor.appcolor, fontSize: 18.sp)),
                  ],
                ),
              ),
            )));
  }
}
