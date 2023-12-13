import 'dart:convert';

import 'package:akijgroup_assignment_app/domainlayer/appcolor.dart';
import 'package:akijgroup_assignment_app/uilayer/makeorder/orderjson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MakeOrderPage extends StatefulWidget {
  const MakeOrderPage({super.key});

  @override
  State<MakeOrderPage> createState() => _MakeOrderPageState();
}

class _MakeOrderPageState extends State<MakeOrderPage> {
  TextEditingController shopname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();

  var items = [];

  int count = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    shopname.dispose();
    phonenumber.dispose();
    print('init dispose called');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init called');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios, color: AppColor.appcolor))),
          body: Center(
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text('Make Order',
                      style:
                          TextStyle(color: AppColor.appcolor, fontSize: 25.sp)),
                  SizedBox(height: 30.h),
                  Container(
                    height: 60.h,
                    width: 200.w,
                    child: TextField(
                      controller: shopname,
                      decoration: InputDecoration(hintText: 'Shop name'),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    height: 60.h,
                    width: 200.w,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: phonenumber,
                      decoration: InputDecoration(hintText: 'Phone number'),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  count < 10
                      ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              count = items.length + 1;
                              showDialogWithFields(count);
                            });
                          },
                          child: Text('Add Item',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              )))
                      : Text(
                          'No more item will be added\nPlease submit the order',
                          style: TextStyle(color: AppColor.appcolor)),
                  ElevatedButton(
                      onPressed: () {
                        var stirngjson = jsonEncode({
                          "shop_name": "${shopname.text}",
                          "phone_number": phonenumber.text,
                          "products": "$items"
                        });

                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (context, animation,
                                        scecondayranimation) =>
                                    OrderJsonPage(stringjson: '$stirngjson'),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(0.0, 1.0);
                                  const end = Offset.zero;
                                  final tween = Tween(begin: begin, end: end);
                                  final offsetAnimation =
                                      animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                }));
                      },
                      child: Text('Submit Order',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          )))
                ])),
          )),
    );
  }

  var itemController = TextEditingController();
  var quantityController = TextEditingController();

  void showDialogWithFields(int count) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Item $count'),
          content: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: itemController,
                decoration: InputDecoration(hintText: 'Item name'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: quantityController,
                decoration: InputDecoration(hintText: 'Quantity'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  count = items.length;
                });
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Send them to your email maybe?
                var itemname = itemController.text;
                var quantity = quantityController.text;

                setState(() {
                  items.add(jsonEncode({"$itemname": quantity}));
                  count = items.length;
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
