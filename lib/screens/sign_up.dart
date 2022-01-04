import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  UpScreen createState() => UpScreen();
}

class UpScreen extends State<SignUp> {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    thongbao(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Thông báo"),
              content: Text("Bạn chưa nhập đầy đủ thông tin "),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("Tắt"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }

    return Scaffold(
        backgroundColor: Colors.indigo,
        body: Form(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                'Đăng Kí',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50, 30, 50, 20),
              child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon:
                        Icon(Icons.account_circle_outlined, color: Colors.grey),
                    hintText: 'Họ Tên',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.zero,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.zero,
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50, 5, 50, 20),
              child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.zero,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.zero,
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50, 5, 50, 20),
              child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.phone_rounded, color: Colors.grey),
                    hintText: 'Số điện thoại',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.zero,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.zero,
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50, 5, 50, 20),
              child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.zero,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.zero,
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50, 5, 50, 20),
              child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    hintText: 'Nhập lại Password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.zero,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.zero,
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
              width: double.infinity,
              height: 60,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.black,
                  primary: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                child: Text('Đăng kí'),
                onPressed: () {},
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Quay lại'),
              ),
            )
          ],
        )));
  }
}
