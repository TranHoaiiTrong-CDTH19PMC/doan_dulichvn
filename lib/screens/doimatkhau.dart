import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_app_flutter/api.dart';
import 'package:travel_app_flutter/screens/sign_in.dart';

class doimatkhau extends StatefulWidget {
  const doimatkhau({Key? key}) : super(key: key);
  @override
  InScreen createState() => InScreen();
}

class InScreen extends State<doimatkhau> {
  TextEditingController _matkhaucu = TextEditingController();
  TextEditingController _matkhaumoi = TextEditingController();
  TextEditingController _nhaplaimatkhau = TextEditingController();
  String matkhaucu = "";
  String matkhauthanhcong = "";
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
                'Đổi mật khẩu',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: TextFormField(
                  controller: _matkhaucu,
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
                    _matkhaucu.text = value!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu cũ',
                    hintText: 'Mật khẩu cũ',
                    border: OutlineInputBorder(),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextFormField(
                  controller: _matkhaumoi,
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
                    _matkhaumoi.text = value!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Nhập mật khẩu mới',
                    hintText: 'Nhập mật khẩu mới',
                    border: OutlineInputBorder(),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextFormField(
                  controller: _nhaplaimatkhau,
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
                    _nhaplaimatkhau.text = value!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Nhập lại mật khẩu',
                    hintText: 'Nhập lại mật khẩu',
                    border: OutlineInputBorder(),
                  )),
            ),
            OutlinedButton(
              child: Text('Đổi mật khẩu',
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
                  API(url: "http://10.0.2.2:8000/api/kiemtramatkhau")
                      .getDataString()
                      .then((value) {
                    matkhaucu = value;
                    print(value);

                    setState(() {
                      if (matkhaucu != _matkhaucu.text) {
                        Fluttertoast.showToast(
                            msg: "Mật khẩu hiện tại không chính xác");
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => doimatkhau()));
                      } else {
                        if (_matkhaumoi.text != _nhaplaimatkhau.text) {
                          Fluttertoast.showToast(
                              msg: "Mật khẩu bạn nhập không trùng khớp");
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => doimatkhau()));
                        } else {
                          API(
                                  url: "http://10.0.2.2:8000/api/doimatkhau/" +
                                      _matkhaumoi.text)
                              .getDataString()
                              .then((value) {
                            matkhauthanhcong = value;
                            print(value);

                            setState(() {
                              if (matkhauthanhcong == "duoc") {
                                Fluttertoast.showToast(
                                    msg:
                                        "Đổi mật khẩu thành công mời bạn đăng nhập lại");
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              }
                            });
                          });
                        }
                      }
                    });
                  });
                });
              },
            ),
          ],
        ),
      ),
    ));
  }
}
