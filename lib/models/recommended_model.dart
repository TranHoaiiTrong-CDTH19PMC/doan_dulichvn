class RecommendedModel {
  String name;
  String tagLine;
  String image;
  List<String> images;
  String description;
  int price;

  RecommendedModel(this.name, this.image);
}

List<RecommendedModel> recommendations = recommendationsData
    .map((item) => RecommendedModel(item['name'], item['image']))
    .toList();

var recommendationsData = [
  {
    "name": "Nhà thờ Đức Bà, Sài Gòn",
    "image":
        "https://image.thanhnien.vn/w2048/Uploaded/2021/cqjwqcqdh/2020_05_23/4_xshh.jpg",
  },
  {
    "name": "Hồ Hoàn Kiếm/Hồ Gươm, Hà Nội",
    "image":
        "https://cdn.vntrip.vn/cam-nang/wp-content/uploads/2017/07/ho-hoan-kiem-1.png",
  },
  {
    "name": "Đà Lạt, Thành phố Đà Lạt",
    "image":
        "https://photo-cms-plo.zadn.vn/w800/Uploaded/2021/bpcbzqvp/2020_03_04/binh-minh-da-lat-dep-nap-long-3_psse.jpg",
  },
  {
    "name": "Cha Diệp, Bạc Liêu",
    "image":
        "https://saigonstartravel.com/wp-content/uploads/2020/02/tour-cha-diep-bac-lieu-xe-giuong-nam-1.jpg",
  },
  {
    "name": "Vịnh Hạ Long, Quảng Ninh",
    "image":
        "http://baochinhphu.vn/Uploaded/duongphuonglien/2020_07_06/ha%20long.jpg",
  },
  {
    "name": "Chùa Dơi, Sóc Trăng",
    "image":
        "https://thamhiemmekong.com/wp-content/uploads/2020/03/chua-doi-soc-trang.jpg",
  },
];
