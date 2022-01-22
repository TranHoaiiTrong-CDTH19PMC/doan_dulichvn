import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_launcher/map_launcher.dart';

import 'selected_place_screen.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_app_flutter/api.dart';
import 'package:travel_app_flutter/models/beach_model.dart';
import 'package:travel_app_flutter/models/popular_model.dart';
import 'package:travel_app_flutter/screens/selected_place_screen.dart';
import 'package:travel_app_flutter/widgets/bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  /// Page Controller
  @override
  Screen createState() => Screen();
}

class Screen extends State<HomeScreen> {
  static const routeName = '/home';
  bool isFavorite = false;
  final _pageController = PageController(viewportFraction: 0.877);
  Iterable s_hinh = [];
  Iterable s = [];

  bool like = false;
  bool modeFind = false;
  String soluotthich = "";
  bool isUpdate = true;
  Iterable ds_moinhat = [];
  late TextEditingController _controller;
  String chiasethanhcong = "";

  void initState() {
    super.initState();
    _controller = TextEditingController();
    setState(() {});
  }

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

//trang tìm kiếm
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


//chi tiết trang mới nhất
    ct_moinhat(int i) {
      return Container(
        child: Stack(
          children: <Widget>[
            /// PageView for Image
            PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                ds_moinhat.elementAt(i)["images"].toString().length,
                (int index) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          ds_moinhat.elementAt(i)["images"].toString()),
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
                          API(
                                  url: "http://10.0.2.2:8000/api/soluotthich/" +
                                      s_hinh.elementAt(i)["id"].toString())
                              .getDataString()
                              .then((value) {
                            soluotthich = value;
                            print(value);
                            isUpdate = false;
                            setState(() {});
                          });
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
                                    ds_moinhat.elementAt(i)["id"].toString())
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
                              ds_moinhat.elementAt(i)["tagLine"].toString(),
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
                              ds_moinhat.elementAt(i)["tagLine"].toString(),
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
                              ds_moinhat.elementAt(i)["description"].toString(),
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
                              ds_moinhat.elementAt(i)["description"].toString(),
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

//trang chi tiet chinh
    detailsSite(int i) {
      return Container(
        child: Stack(
          children: <Widget>[
            /// PageView for Image
            PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                s_hinh.elementAt(i)["images"].toString().length,
                (int index) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          s_hinh.elementAt(i)["images"].toString()),
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
                          API(
                                  url: "http://10.0.2.2:8000/api/soluotthich/" +
                                      s_hinh.elementAt(i)["id"].toString())
                              .getDataString()
                              .then((value) {
                            soluotthich = value;
                            print(value);
                            isUpdate = false;
                            setState(() {});
                          });
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
                                    s_hinh.elementAt(i)["id"].toString())
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
                              s_hinh.elementAt(i)["tagLine"].toString(),
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
                              s_hinh.elementAt(i)["tagLine"].toString(),
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
                              s_hinh.elementAt(i)["description"].toString(),
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
                              s_hinh.elementAt(i)["description"].toString(),
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

    Widget trangtimkiem() {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBarTravel(),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            /// ListView widget with PageView
            /// Recommendations Section
            TextField(
              controller: _controller,
              onChanged: (String value) {
                setState(
                  () {
                    String text = _controller.text;
\
                    if (_controller.text != "") {
                      modeFind = true;
                      API(
                              url: "http://10.0.2.2:8000/api/timkiem/" +
                                  _controller.text)
                          .getDataString()
                          .then((value) {
                        s = json.decode(value);
                        print(value);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => trangtimkiem()));
                        setState(() {});
                      });
                    } else {
                      API(url: "http://10.0.2.2:8000/api/dia_danh")
                          .getDataString()
                          .then((value) {
                        s = json.decode(value);
                        print(value);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => trangtimkiem()));
                        isUpdate = false;
                        setState(() {});
                      });
                    }
                  },
                );
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search",
              ),
            ),

            Container(
              height: 57.6,
              margin: EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 57.6,
                    width: 57.6,
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.6),
                      color: Color(0x080a0928),
                    ),
                    child: SvgPicture.asset('assets/svg/icon_drawer.svg'),
                  ),
                  Container(
                    height: 57.6,
                    width: 57.6,
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.6),
                      color: Color(0x080a0928),
                    ),
                    child: SvgPicture.asset('assets/svg/icon_search.svg'),
                  )
                ],
              ),
            ),


            /// Text Widget for Title
            Padding(
              padding: EdgeInsets.only(top: 48, left: 28.8),
              child: Text(
                'Địa điểm\ndu lịch nổi tiếng',
                style: GoogleFonts.playfairDisplay(
                    fontSize: 45.6, fontWeight: FontWeight.w700),
              ),
            ),

            /// Custom Tab bar with Custom Indicator
            Container(
              height: 30,
              margin: EdgeInsets.only(left: 14.4, top: 28.8),
              child: DefaultTabController(
                length: 4,
                child: TabBar(
                    labelPadding: EdgeInsets.only(left: 14.4, right: 14.4),
                    indicatorPadding: EdgeInsets.only(left: 14.4, right: 14.4),
                    isScrollable: true,
                    labelColor: Color(0xFF000000),
                    unselectedLabelColor: Color(0xFF8a8a8a),
                    labelStyle: GoogleFonts.lato(
                        fontSize: 14, fontWeight: FontWeight.w700),
                    unselectedLabelStyle: GoogleFonts.lato(
                        fontSize: 14, fontWeight: FontWeight.w700),
                    // indicator: RoundedRectangleTabIndicator(
                    //     color: Color(0xFF000000), weight: 2.4, width: 14.4),
                    tabs: [
                      Tab(
                        child: Container(
                          child: Text('Địa điểm hot'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Điểm đến mới'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Đề xuất cho bạn'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Phổ biến'),
                        ),
                      )
                    ]),
              ),
            ),

            /// ListView widget with PageView
            /// Recommendations Section
            Container(
              height: 218.4,
              margin: EdgeInsets.only(top: 16),
              child: PageView(
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  s.length,
                  (int index) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => timkiem(index)),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 28.8),
                      width: 333.6,
                      height: 218.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.6),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              s.elementAt(index)["image"].toString()),
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
                                        s.elementAt(index)["name"].toString(),
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
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 48, left: 28.8, right: 28.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: FittedBox(
                      child: Text(
                        'Danh mục phổ biến',
                        style: GoogleFonts.playfairDisplay(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: FittedBox(
                      child: Text(
                        'Hiện tất cả',
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8a8a8a),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            /// danh sách Popular
            Container(
              margin: EdgeInsets.only(top: 33.6),
              height: 45.6,
              child: ListView.builder(
                //  itemCount: populars.length,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(left: 28.8, right: 9.6),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 19.2),
                    height: 45.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.6),
                      //       color: Color(populars[index].color),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 19.2,
                        ),
                        // Image.asset(
                        //   populars[index].image,
                        //   height: 16.8,
                        // ),
                        SizedBox(
                          width: 19.2,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            /// danh sách Popular
            Container(
              margin: EdgeInsets.only(top: 28.8, bottom: 16.8),
              height: 124.8,
              child: ListView.builder(
                // itemCount: beaches.length,
                padding: EdgeInsets.only(left: 28.8, right: 12),
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    height: 124.8,
                    width: 188.4,
                    margin: EdgeInsets.only(right: 16.8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.6),
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //   image:
                      //       CachedNetworkImageProvider(beaches[index].image),
                      // ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    }


    Widget Trangmoinhat() {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBarTravel(),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            /// tiêu đề
            Padding(
                padding: EdgeInsets.only(top: 48, left: 28.8),
                child: Column(
                  children: [
                    Text(
                      'Địa điểm\ndu lịch nổi tiếng',
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 45.6, fontWeight: FontWeight.w700),
                    ),
                  ],
                )),

            /// danh sách tab
            Container(
              height: 30,
              margin: EdgeInsets.only(left: 14.4, top: 28.8),
              child: DefaultTabController(
                length: 4,
                child: TabBar(
                    labelPadding: EdgeInsets.only(left: 14.4, right: 14.4),
                    indicatorPadding: EdgeInsets.only(left: 14.4, right: 14.4),
                    isScrollable: true,
                    labelColor: Color(0xFF000000),
                    unselectedLabelColor: Color(0xFF8a8a8a),
                    labelStyle: GoogleFonts.lato(
                        fontSize: 14, fontWeight: FontWeight.w700),
                    unselectedLabelStyle: GoogleFonts.lato(
                        fontSize: 14, fontWeight: FontWeight.w700),
                    // indicator: RoundedRectangleTabIndicator(
                    //     color: Color(0xFF000000), weight: 2.4, width: 14.4),
                    tabs: [
                      Tab(
                        child: Container(
                          child: Text('Địa điểm hot'),
                        ),
                      ),
                      Tab(
                        child: Container(child: Text("địa điểm mới")),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Đề xuất cho bạn'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Phổ biến'),
                        ),
                      )
                    ]),
              ),
            ),

            Container(
              height: 218.4,
              margin: EdgeInsets.only(top: 16),
              child: PageView(
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  s_hinh.length,
                  (int index) => GestureDetector(

                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ct_moinhat(index)),
                      );
                    },

                    child: Container(
                      margin: EdgeInsets.only(right: 28.8),
                      width: 333.6,
                      height: 218.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.6),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              ds_moinhat.elementAt(index)["image"].toString()),
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
                                        ds_moinhat
                                            .elementAt(index)["name"]
                                            .toString(),
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
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 48, left: 28.8, right: 28.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: FittedBox(
                      child: Text(
                        'Danh mục phổ biến',
                        style: GoogleFonts.playfairDisplay(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: FittedBox(
                      child: Text(
                        'Hiện tất cả',
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8a8a8a),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            /// danh sách Popular
            Container(
              margin: EdgeInsets.only(top: 33.6),
              height: 45.6,
              child: ListView.builder(
                //  itemCount: populars.length,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(left: 28.8, right: 9.6),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 19.2),
                    height: 45.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.6),
                      //       color: Color(populars[index].color),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 19.2,
                        ),
                        SizedBox(
                          width: 19.2,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            /// danh sách Popular
            Container(
              margin: EdgeInsets.only(top: 28.8, bottom: 16.8),
              height: 124.8,
              child: ListView.builder(
                // itemCount: beaches.length,
                padding: EdgeInsets.only(left: 28.8, right: 12),
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    height: 124.8,
                    width: 188.4,
                    margin: EdgeInsets.only(right: 16.8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.6),
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //   image:
                      //       CachedNetworkImageProvider(beaches[index].image),
                      // ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    }

    Widget Trangchu() {
      return SafeArea(
        child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              TextField(
                controller: _controller,
                onChanged: (String value) {
                  setState(
                    () {
                      String text = _controller.text;
                      if (_controller.text == "") {
                        modeFind = false;
                        s = [];
                      } else {
                        modeFind = true;
                        API(
                                url: "http://10.0.2.2:8000/api/timkiem/" +
                                    _controller.text)
                            .getDataString()
                            .then((value) {
                          s = json.decode(value);
                          print(value);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => trangtimkiem()));
                          setState(() {});
                        });
                      }
                    },
                  );
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search",
                ),
              ),

              /// tiêu đề
              Padding(
                  padding: EdgeInsets.only(top: 48, left: 28.8),
                  child: Column(
                    children: [
                      Text(
                        'Địa điểm\ndu lịch nổi tiếng',
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 45.6, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )),

              /// danh sách tab
              Container(
                height: 30,
                margin: EdgeInsets.only(left: 14.4, top: 28.8),
                child: DefaultTabController(
                  length: 4,
                  child: TabBar(
                      labelPadding: EdgeInsets.only(left: 14.4, right: 14.4),
                      indicatorPadding:
                          EdgeInsets.only(left: 14.4, right: 14.4),
                      isScrollable: true,
                      labelColor: Color(0xFF000000),
                      unselectedLabelColor: Color(0xFF8a8a8a),
                      labelStyle: GoogleFonts.lato(
                          fontSize: 14, fontWeight: FontWeight.w700),
                      unselectedLabelStyle: GoogleFonts.lato(
                          fontSize: 14, fontWeight: FontWeight.w700),
                      // indicator: RoundedRectangleTabIndicator(
                      //     color: Color(0xFF000000), weight: 2.4, width: 14.4),
                      tabs: [
                        Tab(
                          child: Container(
                            child: Text('Địa điểm hot'),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: TextButton(
                              onPressed: () {
                                API(url: "http://10.0.2.2:8000/api/diadiemmoinhat")
                                    .getDataString()
                                    .then((value) {
                                  ds_moinhat = json.decode(value);
                                  print(value);
                                  isUpdate = false;
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Trangmoinhat()));
                                  setState(() {});
                                });
                              },
                              child: Text('Điểm đến mới',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: Text('Đề xuất cho bạn'),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: Text('Phổ biến'),
                          ),
                        )
                      ]),
                ),
              ),

              /// danh sách địa danh
              /// thông tin địa danh
              Container(
                height: 218.4,
                margin: EdgeInsets.only(top: 16),
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    s_hinh.length,
                    (int index) => GestureDetector(

                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => detailsSite(index)),
                        );
                      },

                      child: Container(
                        margin: EdgeInsets.only(right: 28.8),
                        width: 333.6,
                        height: 218.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.6),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                s_hinh.elementAt(index)["image"].toString()),
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
                                    padding: EdgeInsets.only(
                                        left: 16.72, right: 14.4),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        SvgPicture.asset(
                                            'assets/svg/icon_location.svg'),
                                        SizedBox(
                                          width: 9.52,
                                        ),
                                        Text(
                                          s_hinh
                                              .elementAt(index)["name"]
                                              .toString(),
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
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 48, left: 28.8, right: 28.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: FittedBox(
                        child: Text(
                          'Danh mục phổ biến',
                          style: GoogleFonts.playfairDisplay(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: FittedBox(
                        child: Text(
                          'Hiện tất cả',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8a8a8a),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              /// danh sách Popular
              Container(
                margin: EdgeInsets.only(top: 33.6),
                height: 45.6,
                child: ListView.builder(
                  //  itemCount: populars.length,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(left: 28.8, right: 9.6),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 19.2),
                      height: 45.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.6),
                        //       color: Color(populars[index].color),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 19.2,
                          ),
                          // Image.asset(
                          //   populars[index].image,
                          //   height: 16.8,
                          // ),
                          SizedBox(
                            width: 19.2,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

              /// danh sách Popular
              Container(
                margin: EdgeInsets.only(top: 28.8, bottom: 16.8),
                height: 124.8,
                child: ListView.builder(
                  // itemCount: beaches.length,
                  padding: EdgeInsets.only(left: 28.8, right: 12),
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 124.8,
                      width: 188.4,
                      margin: EdgeInsets.only(right: 16.8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.6),
                        // image: DecorationImage(
                        //   fit: BoxFit.cover,
                        //   image:
                        //       CachedNetworkImageProvider(beaches[index].image),
                        // ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
        bottomNavigationBar: BottomNavigationBarTravel(), body: Trangchu());
  }
}
