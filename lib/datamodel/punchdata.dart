import 'dart:convert';

import 'package:akijgroup_assignment_app/domainlayer/userpunchmodel.dart';
import 'package:http/http.dart' as http;

class PunchRepository {
  static Future<List<Geopunch>> fetchAlbum() async {
    final response =
        await http.get(Uri.parse('https://www.akijpipes.com/api/lat-long/455'));

    return json
        .decode(response.body)['data']
        .map<Geopunch>((e) => Geopunch.fromJson(e))
        .toList();
  }
}
