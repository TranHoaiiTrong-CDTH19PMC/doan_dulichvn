// class RecommendedModel {
//   String name;
//   String tagLine;
//   String image;
//   List<String> images;
//   String description;
//   int price;

//   RecommendedModel(this.name, this.tagLine, this.image, this.images,
//       this.description, this.price);
// }

// List<RecommendedModel> recommendations = recommendationsData
//     .map((item) => RecommendedModel(item['name'], item['tagLine'],
//         item['image'], item['images'], item['description'], item['price']))
//     .toList();

// var recommendationsData = [
//   {
//     "name": "Nhà thờ Đức Bà, Sài Gòn",
//     "tagLine": "Nhà thờ Đức Bà, Sài Gòn",
//     "image":
//         "https://image.thanhnien.vn/w2048/Uploaded/2021/cqjwqcqdh/2020_05_23/4_xshh.jpg",
//     "images": [
//       "https://image.thanhnien.vn/w2048/Uploaded/2021/cqjwqcqdh/2020_05_23/4_xshh.jpg",
//       "",
//       "",
//       ""
//     ],
//     "description":
//         "Theo bài viết trên báo Business Insider (Mỹ), nhà thờ Đức Bà Sài Gòn được mô phỏng theo Nhà thờ Đức Bà ở Paris, là một trong 19 thánh đường đẹp nhất trên thế giới.",
//     "price": 100
//   },
//   {
//     "name": "Hồ Hoàn Kiếm/Hồ Gươm, Hà Nội",
//     "tagLine": "Hồ Hoàn Kiếm (Hồ Gươm), Hà Nội",
//     "image":
//         "https://cdn.vntrip.vn/cam-nang/wp-content/uploads/2017/07/ho-hoan-kiem-1.png",
//     "images": [
//       "https://cdn.vntrip.vn/cam-nang/wp-content/uploads/2017/07/ho-hoan-kiem-1.png",
//       "",
//       "",
//       ""
//     ],
//     "description":
//         "Hồ Hoàn Kiếm nằm ở trung tâm thủ đô, được bao quanh bởi 3 con phố Hàng Khay _ Lê Thái Tổ _ Đinh Tiên Hoàng.",
//     "price": 130
//   },
//   {
//     "name": "Đà Lạt, Thành phố Đà Lạt",
//     "tagLine": "Đà Lạt xứ sở ngàn hoa",
//     "image":
//         "https://photo-cms-plo.zadn.vn/w800/Uploaded/2021/bpcbzqvp/2020_03_04/binh-minh-da-lat-dep-nap-long-3_psse.jpg",
//     "images": [
//       "https://photo-cms-plo.zadn.vn/w800/Uploaded/2021/bpcbzqvp/2020_03_04/binh-minh-da-lat-dep-nap-long-3_psse.jpg",
//       "",
//       "",
//       ""
//     ],
//     "description":
//         "Với tiết trời se lạnh, khoảnh khắc ngắm bình minh lý tưởng nhất là khoảng 4-5 giờ sáng. Việc thức giấc ở một nơi xa để cùng đón ánh bình minh cảm giác thật tuyệt vời.",
//     "price": 120
//   },
//   {
//     "name": "Cha Diệp, Bạc Liêu",
//     "tagLine": "Tour Cha Diệp Bạc Liêu",
//     "image":
//         "https://saigonstartravel.com/wp-content/uploads/2020/02/tour-cha-diep-bac-lieu-xe-giuong-nam-1.jpg",
//     "images": [
//       "https://saigonstartravel.com/wp-content/uploads/2020/02/tour-cha-diep-bac-lieu-xe-giuong-nam-1.jpg",
//       "",
//       "",
//       ""
//     ],
//     "description":
//         "Một chuyến du lịch ngắn ngày là sự lựa chọn thích hợp vào những dịp cuối tuần dành cho các cặp gia đình, bạn bè cùng nhau tụ họp để gắn kết hơn. Tour Cha Diep là một gợi ý thích hợp dành cho những ai ở gần Bạc Liêu.",
//     "price": 110
//   },
//   {
//     "name": "Vịnh Hạ Long, Quảng Ninh",
//     "tagLine": "Vịnh Hạ Long kỳ quan thiên nhiên thế giới",
//     "image":
//         "http://baochinhphu.vn/Uploaded/duongphuonglien/2020_07_06/ha%20long.jpg",
//     "images": [
//       "http://baochinhphu.vn/Uploaded/duongphuonglien/2020_07_06/ha%20long.jpg",
//       "",
//       "",
//       ""
//     ],
//     "description":
//         "Vịnh Hạ Long vừa được tạp chí Insider (Mỹ) đưa vào danh sách 50 kỳ quan thiên nhiên đẹp nhất. Trước đó, Vịnh Hạ Long cũng vinh dự nằm trong danh sách xếp hạng 20 địa điểm du lịch bụi tốt nhất 2020 của Hostelworld",
//     "price": 180
//   },
//   {
//     "name": "Chùa Dơi, Sóc Trăng",
//     "tagLine": "Chùa Dơi, Điểm du lịch tâm linh nổi tiếng",
//     "image":
//         "https://thamhiemmekong.com/wp-content/uploads/2020/03/chua-doi-soc-trang.jpg",
//     "images": [
//       "https://thamhiemmekong.com/wp-content/uploads/2020/03/chua-doi-soc-trang.jpg",
//       "",
//       "",
//       ""
//     ],
//     "description":
//         "Chùa Dơi hay chùa Mã Tộc, chùa Mahatup là quần thể kiến trúc tiêu biểu trong tín ngưỡng của đồng bào Khmer. Chùa tọa lạc tại đường Văn Ngọc Chính thuộc Phường 3, thành phố Sóc Trăng. Đến đây, du khách không chỉ được chiêm ngưỡng vẻ đẹp độc đáo, diễm lệ cổ kính của ngôi chùa, mà còn được hòa mình vào thiên nhiên huyền bí với những bầy dơi treo mình trên khắp những tán cây trong khuôn viên chùa.",
//     "price": 200
//   },
// ];
