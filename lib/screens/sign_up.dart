import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_app_flutter/screens/sign_in.dart';
import '../api.dart';

class SignUp extends StatefulWidget {
  @override
  UpScreen createState() => UpScreen();
}

bool isUpdate = true;

class UpScreen extends State<SignUp> {
  static const routeName = '/sign-up';
  TextEditingController _hoten = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confimpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String add = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        'Đăng Kí',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 30, 50, 20),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _hoten,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ('Vui lòng nhập họ tên');
                            }
                            if (!regex.hasMatch(value)) {
                              return ('Nhập họ tên ít nhất 6 kí tự');
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _hoten.text = value!;
                          },
                          decoration: InputDecoration(
                            labelText: 'Họ tên',
                            hintText: 'Họ tên',
                            border: OutlineInputBorder(),
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 5, 50, 20),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ('Vui lòng nhập email');
                            }
                            if (!RegExp(
                                    '^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]')
                                .hasMatch(value)) {
                              return ('Nhập email đúng định dạng');
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
                      padding: EdgeInsets.fromLTRB(50, 5, 50, 20),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _phone,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{10,}$');
                            if (value!.isEmpty) {
                              return ('Vui lòng nhập số điện thoại');
                            }
                            if (!regex.hasMatch(value)) {
                              return ('Số điện thoại không đúng');
                            }
                          },
                          onSaved: (value) {
                            _phone.text = value!;
                          },
                          decoration: InputDecoration(
                            labelText: 'Số điện thoại',
                            hintText: 'Số điện thoại',
                            border: OutlineInputBorder(),
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 5, 50, 20),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _password,
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
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 5, 50, 20),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _confimpassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ('Vui lòng nhập lại mật khẩu');
                            }
                            if (_confimpassword.text != _password.text) {
                              return ('Vui lòng nhập trùng với mật khẩu');
                            }
                          },
                          onSaved: (value) {
                            _confimpassword.text = value!;
                          },
                          decoration: InputDecoration(
                            labelText: 'Nhập lại mật khẩu',
                            hintText: 'Nhập lại mật khẩu',
                            border: OutlineInputBorder(),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                        child: Text('Đăng kí'),
                        onPressed: () {
                          setState(() {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            } else {
                              API(
                                      url:
                                          "http://10.0.2.2:8000/api/dang_ki_tai_khoan/" +
                                              _hoten.text +
                                              "/" +
                                              _email.text +
                                              "/" +
                                              _phone.text +
                                              "/" +
                                              _password.text)
                                  .getDataString()
                                  .then((value) {
                                add = value;
                                print(value);
                                isUpdate = false;
                                setState(() {
                                  Fluttertoast.showToast(
                                      msg: "Đăng ký thành công");
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => SignIn()));
                                });
                              });
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        },
                        child: const Text('Quay lại'),
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
