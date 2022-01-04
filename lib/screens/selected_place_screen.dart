import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_app_flutter/models/recommended_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SelectedPlaceScreen extends StatelessWidget {
  final _pageController = PageController();

  final RecommendedModel recommendedModel;

  SelectedPlaceScreen({Key key, @required this.recommendedModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            /// PageView for Image
            PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                recommendedModel.images.length,
                (int index) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          recommendedModel.images[index]),
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
                    FavoriteButton()
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
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: recommendedModel.images.length,
                      effect: ExpandingDotsEffect(
                          activeDotColor: Color(0xFFFFFFFF),
                          dotColor: Color(0xFFababab),
                          dotHeight: 4.8,
                          dotWidth: 6,
                          spacing: 4.8),
                    ),

                    ///tag line
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Stack(
                          children: <Widget>[
                            Text(
                              recommendedModel.tagLine,
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
                              recommendedModel.tagLine,
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
                              recommendedModel.description,
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
                              recommendedModel.description,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FittedBox(
                                  child: Stack(
                                children: <Widget>[
                                  Text(
                                    'Giá',
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w500,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 3
                                          ..color = Colors.black),
                                  ),
                                  Text(
                                    'Giá',
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              )),
                              FittedBox(
                                  child: Stack(
                                children: <Widget>[
                                  Text(
                                    '${recommendedModel.price.toString()}\k / Người',
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w700,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 3
                                          ..color = Colors.black),
                                  ),
                                  Text(
                                    '${recommendedModel.price.toString()}\k / Người',
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                        Container(
                          height: 62.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.6),
                              color: Colors.white),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.only(left: 28.8, right: 28.8),
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
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// FavoriteButton Icon
class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
            print('Sebelum klik tombol => $isFavorite');
            setState(() {
              isFavorite = !isFavorite;
              print('Setelah klik tombol => $isFavorite');
            });
          },
        ),
        Container(
            padding: EdgeInsets.only(left: 10),
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
                setState(() {});
              },
            )),
      ],
    );
  }
}
