class search_model {
  int? price;
  int? space;
  int? regionId;
  int? governorateId;

  search_model({this.price, this.space, this.regionId, this.governorateId});

  search_model.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    space = json['space'];
    regionId = json['region_id'];
    governorateId = json['governorate_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = price;
    data['space'] = space;
    data['region_id'] = regionId;
    data['governorate_id'] = governorateId;
    return data;
  }
}
