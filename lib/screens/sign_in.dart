import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  InScreen createState() => InScreen();
}

class InScreen extends State<SignIn> {
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
              'Đăng Nhập',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(50, 30, 50, 10),
            child: TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.call, color: Colors.grey),
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
                obscureText: true,
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
              onPressed: () {},
              child: Text('SIGN IN'),
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'Quên mật khẩu?',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Text(
                    '------------------------ Hoặc ------------------------',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    onPressed: () {},
                    child: Text('Tạo tài khoản mới',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
