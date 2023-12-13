class Geopunch {
  String? id;
  String? user_id;
  String? lat;
  String? long;

  Geopunch({
    this.id,
    this.user_id,
    this.lat,
    this.long,
  });

  Geopunch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = user_id;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
