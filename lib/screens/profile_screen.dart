import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app_flutter/screens/doimatkhau.dart';
import 'package:travel_app_flutter/screens/home_screen.dart';
import 'package:travel_app_flutter/widgets/bottom_navigation_bar.dart';
import '../api.dart';
import 'package:map_launcher/map_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Profile createState() => Profile();
}

class Profile extends State<ProfileScreen> {
  String ten = "";
  String email = "";
  String phone = "";
  bool modeFind = true;
  Iterable s = [];
  Iterable s_hinh = [];
  bool isFavorite = false;
  bool isUpdate = true;
  String thoigian = "";
  String chiasethanhcong = "";
  final _pageController = PageController(viewportFraction: 0.877);
  Future<void> _ggmap() async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(10.7797879, 106.6989794),
      title: "Nhà thờ đức bà",
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isUpdate == true) {
      API(url: "http://10.0.2.2:8000/api/dia_danh")
          .getDataString()
          .then((value) {
        s_hinh = json.decode(value);
        print(value);
        isUpdate = false;
        setState(() {});
      });
    }

    if (isUpdate == true) {
      API(url: "http://10.0.2.2:8000/api/layten").getDataString().then((value) {
        ten = value;
        print(value);
        isUpdate = false;
        setState(() {});
      });
      API(url: "http://10.0.2.2:8000/api/layemail")
          .getDataString()
          .then((value) {
        email = value;
        print(value);
        isUpdate = false;
        setState(() {});
      });
      API(url: "http://10.0.2.2:8000/api/layphone")
          .getDataString()
          .then((value) {
        phone = value;
        print(value);
        isUpdate = false;
        setState(() {});
      });
      API(url: "http://10.0.2.2:8000/api/danhsachbaiviettaikhoan")
          .getDataString()
          .then((value) {
        s = json.decode(value);
        print(value);
        isUpdate = false;
        setState(() {});
      });
    }
    timkiem(int i) {
      return Container(
        child: Stack(
          children: <Widget>[
            /// PageView for Image
            PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                s.elementAt(i)["images"].toString().length,
                (int index) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          s.elementAt(i)["images"].toString()),
                    ),
                  ),
                ),
              ),
            ),

            /// Custom Button
            SafeArea(
              child: Container(
                height: 57.6,
                margin: EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 57.6,
                        width: 57.6,
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.6),
                          color: Color(0x10000000),
                        ),
                        child:
                            SvgPicture.asset('assets/svg/icon_left_arrow.svg'),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        height: 57.6,
                        width: 57.6,
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.6),
                          color: Color(0x10000000),
                        ),
                        child: SvgPicture.asset(isFavorite
                            ? 'assets/svg/icon_heart_fill_red.svg'
                            : 'assets/svg/icon_heart_fill.svg'),
                      ),
                      onTap: () {
                        print('click => $isFavorite');
                        setState(() {
                          isFavorite = !isFavorite;
                          print('click => $isFavorite');
                        });
                      },
                    ),
                    Container(
                        child: GestureDetector(
                      child: Container(
                        height: 57.6,
                        width: 57.6,
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.6),
                          color: Color(0x10000000),
                        ),
                        child: SvgPicture.asset('assets/svg/icon-share.svg'),
                      ),
                      onTap: () {
                        API(
                                url: "http://10.0.2.2:8000/api/chiasebaiviet/" +
                                    s.elementAt(i)["id"].toString())
                            .getDataString()
                            .then((value) {
                          chiasethanhcong = value;
                          print(value);

                          setState(() {
                            Fluttertoast.showToast(msg: "Chia sẻ thành công");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          });
                        });
                      },
                    )),
                  ],
                ),
              ),
            ),

            /// Content
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.4,
                    maxHeight: MediaQuery.of(context).size.height * 0.5),
                padding: EdgeInsets.only(left: 28.8, bottom: 48, right: 28.8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ///tag line
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Stack(
                          children: <Widget>[
                            Text(
                              s.elementAt(i)["tagLine"].toString(),
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              style: GoogleFonts.playfairDisplay(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color = Colors.black),
                            ),
                            Text(
                              s.elementAt(i)["tagLine"].toString(),
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),

                    ///description
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Stack(
                          children: <Widget>[
                            Text(
                              s.elementAt(i)["description"].toString(),
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                              style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 3
                                    ..color = Colors.black),
                            ),
                            Text(
                              s.elementAt(i)["description"].toString(),
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                              style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 40,
                    ),

                    /// Đi ngay
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                        Container(
                            height: 62.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9.6),
                                color: Colors.white),
                            child: ElevatedButton(
                              onPressed: _ggmap,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding:
                                      EdgeInsets.only(left: 28.8, right: 28.8),
                                  child: FittedBox(
                                    child: Text(
                                      'Đi ngay >>',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    TextEditingController _controller = TextEditingController();
    laythoigian(String i) {
      API(url: "http://10.0.2.2:8000/api/thoigianchiasebaiviet/" + i.toString())
          .getDataString()
          .then((value) {
        thoigian = value;
        return thoigian;

        // setState(() {});
      });
      return thoigian;
    }

    Widget baichiase() {
      return Container(
        child: Column(children: [
          for (int i = 0; i < s.length; i++) ...[
            TextField(),
            Row(
              children: [
                IconButton(
                  iconSize: 50,
                  onPressed: () => {},
                  icon: CircleAvatar(
                    radius: 80.0,
                    backgroundImage: NetworkImage(
                        'https://www.pinclipart.com/picdir/middle/91-919500_individuals-user-vector-icon-png-clipart.png'),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ten,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        spacing: 10.0,
                        children: [
                          Text(
                            s.elementAt(i)["created_at"].toString(),
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Icon(Icons.public),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    (Icons.more_horiz_outlined),
                    size: 30,
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Tui ghét chỗ này",
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => timkiem(i)),
                      );
                    },
                    child: Container(
                      width: 400,
                      height: 220,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              s.elementAt(i)["image"].toString()),
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 19.2,
                            left: 19.2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.8),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaY: 19.2, sigmaX: 19.2),
                                child: Container(
                                  height: 36,
                                  padding:
                                      EdgeInsets.only(left: 16.72, right: 14.4),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                          'assets/svg/icon_location.svg'),
                                      SizedBox(
                                        width: 9.52,
                                      ),
                                      Text(
                                        s.elementAt(i)["name"].toString(),
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: 16.8),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      (Icons.thumb_up_alt_outlined),
                    ),
                    Text(
                      '12',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      (Icons.message_outlined),
                    ),
                    Text('10', style: TextStyle(fontSize: 18.0)),
                  ],
                ),
              ],
            ),
          ]
        ]),
      );
    }

    Widget trangchu() {
      double height = MediaQuery.of(context).size.height;
      return ListView(
        children: [
          Center(
              child: Column(
            children: [
              Container(
                height: 255,
                width: 400,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    GestureDetector(
                      onTap: () => {},
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            width: 400,
                            margin: EdgeInsets.only(top: 10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: Image(
                                image: NetworkImage(
                                    'https://anhnendep.net/wp-content/uploads/2016/07/anh-dep-thien-nhien-the-gioi-04.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10.0,
                      left: 140.0,
                      child: Container(
                        height: 120,
                        width: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                          child: Image(
                              image: NetworkImage(
                                  'https://www.pinclipart.com/picdir/middle/91-919500_individuals-user-vector-icon-png-clipart.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(ten,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => doimatkhau()),
                        )
                      },
                      child: Row(
                        children: [
                          Icon(Icons.vpn_key_outlined),
                          Text(' Đổi mật khẩu'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          Text(
                            'Sửa thông tin',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.email_outlined),
                        Text(email,
                            style: TextStyle(fontSize: 16, color: Colors.black))
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.phone),
                        Text(phone,
                            style: TextStyle(fontSize: 16, color: Colors.black))
                      ],
                    ),
                  ),
                ],
              ),
              // Divider(
              //   thickness: 1,
              //   color: Colors.black38,
              // ),
              baichiase(),
            ],
          )),
        ],
      );
    }

    return Scaffold(
        bottomNavigationBar: BottomNavigationBarTravel(), body: trangchu());
  }
}
