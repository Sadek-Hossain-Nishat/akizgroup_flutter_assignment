import 'package:akijgroup_assignment_app/datamodel/punchdata.dart';
import 'package:akijgroup_assignment_app/domainlayer/appcolor.dart';
import 'package:akijgroup_assignment_app/domainlayer/userpunchmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeopunchListPage extends StatefulWidget {
  const GeopunchListPage({super.key});

  @override
  State<GeopunchListPage> createState() => _GeopunchListPageState();
}

class _GeopunchListPageState extends State<GeopunchListPage> {
  late Future<List<Geopunch>> futureGeopunch;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureGeopunch = PunchRepository.fetchAlbum();
    print('data=> ${PunchRepository.fetchAlbum()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Geopunch List',
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.appcolor)),
          Icon(Icons.push_pin, color: AppColor.appcolor, size: 25.sp),
        ],
      ),
      SizedBox(height: 30.h),
      AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: EdgeInsets.all(20.0.w),
            child: Container(
                child: FutureBuilder<List<Geopunch>>(
              future: futureGeopunch,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            color: Colors.deepPurpleAccent[100],
                            child: ListTile(
                              leading: Icon(Icons.location_on,
                                  color: Colors.white, size: 14.sp),
                              title: Text(
                                  'User id:${snapshot.data![index].user_id as String}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp)),
                              trailing: Text(
                                  'Long:${snapshot.data![index].long as String} ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp)),
                              subtitle: Text(
                                  'Lat:${snapshot.data![index].lat as String}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp)),
                            ),
                          ),
                          SizedBox(height: 10.h)
                        ],
                      );
                    },
                  );

                  // return ListTile(
                  //     leading: Icon(Icons.location_on),
                  //     title: Text('User id:${snapshot.data!.user_id}'),
                  //     subtitle: Text('Lat:${snapshot.data!.lat}'),
                  //     trailing: Text('Long:${snapshot.data!.long}'));
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            )),
          ))
    ]));
  }
}
