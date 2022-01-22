import 'package:flutter/material.dart';
import 'package:travel_app_flutter/screens/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_app_flutter/api.dart';
import 'package:travel_app_flutter/screens/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  @override
  InScreen createState() => InScreen();
}

class InScreen extends State<SignIn> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  String dangnhap = "";
  Iterable taikhoan = [];
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                'Đăng nhập',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: TextFormField(
                  controller: _email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ('Vui lòng nhập email');
                    }
                    if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]')
                        .hasMatch(value)) {
                      return ('Vui lòng nhập email đúng định dạng');
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email.text = value!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextFormField(
                  controller: _password,
                  obscureText: false,
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return ('Vui lòng nhập mật khẩu');
                    }
                    if (!regex.hasMatch(value)) {
                      return ('Vui lòng nhập mật khẩu ít nhất 6 kí tự');
                    }
                  },
                  onSaved: (value) {
                    _password.text = value!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    hintText: 'Mật khẩu',
                    border: OutlineInputBorder(),
                  )),
            ),
            OutlinedButton(
              child: Text('Đăng nhập',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  )),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              onPressed: () {
                setState(() {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  } else {
                    API(
                            url:
                                "http://10.0.2.2:8000/api/dang_nhap_tai_khoan/" +
                                    _email.text +
                                    "/" +
                                    _password.text)
                        .getDataString()
                        .then((value) {
                      dangnhap = value;
                      print(value);

                      setState(() {
                        if (dangnhap == "duoc") {
                          API(
                                  url:
                                      "http://10.0.2.2:8000/api/luutrangthai/" +
                                          _email.text +
                                          "/" +
                                          _password.text)
                              .getDataString()
                              .then((value) {
                            print(value);
                            setState(() {});
                          });
                          Fluttertoast.showToast(msg: "Đăng nhập thành công");
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        } else {
                          Fluttertoast.showToast(msg: "Đăng nhập thất bại");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        }
                      });
                    });
                  }
                });
              },
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
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
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
    ));
  }
}
