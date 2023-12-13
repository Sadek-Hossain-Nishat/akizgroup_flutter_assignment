import 'package:akijgroup_assignment_app/domainlayer/appcolor.dart';
import 'package:akijgroup_assignment_app/uilayer/map_location/user_currentloaction.dart';
import 'package:akijgroup_assignment_app/uilayer/map_location/userpunch_list.dart';
import 'package:flutter/material.dart';

class Locationtabbar extends StatefulWidget {
  const Locationtabbar({super.key});

  @override
  State<Locationtabbar> createState() => _LocationtabbarState();
}

class _LocationtabbarState extends State<Locationtabbar> {
  int _position = 0;
  final _pages = [LocationandMapPage(), GeopunchListPage()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios, color: AppColor.appcolor)),
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Location'),
                  Tab(text: 'Geopunch List'),
                ],
              )),
          body: TabBarView(
            children: [LocationandMapPage(), GeopunchListPage()],
          )),
    ));
  }
}
