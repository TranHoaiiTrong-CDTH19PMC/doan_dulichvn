import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app_flutter/models/user.dart';

import 'package:travel_app_flutter/screens/sign_in.dart';

class SignUp extends StatefulWidget {
  @override
  UpScreen createState() => UpScreen();
}

class UpScreen extends State<SignUp> {
  static const routeName = '/sign-up';
  TextEditingController _hoten = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confimpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String errorMessage;
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
            key: _formKey,
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
                      controller: _hoten,
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{6,}$');
                        if (value.isEmpty) {
                          return ('Vui lòng nhập họ tên');
                        }
                        if (!regex.hasMatch(value)) {
                          return ('Nhập họ tên ít nhất 6 kí tự');
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _hoten.text = value;
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.account_circle_outlined,
                            color: Colors.grey),
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
                      controller: _email,
                      validator: (value) {
                        if (value.isEmpty) {
                          return ('Vui lòng nhập email');
                        }
                        if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]')
                            .hasMatch(value)) {
                          return ('Nhập email đúng định dạng');
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email.text = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:
                            Icon(Icons.email_outlined, color: Colors.grey),
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
                      controller: _phone,
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{10,}$');
                        if (value.isEmpty) {
                          return ('Vui lòng nhập số điện thoại');
                        }
                        if (!regex.hasMatch(value)) {
                          return ('Số điện thoại không đúng');
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:
                            Icon(Icons.phone_rounded, color: Colors.grey),
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
                      controller: _password,
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{6,}$');
                        if (value.isEmpty) {
                          return ('Vui lòng nhập password');
                        }
                        if (!regex.hasMatch(value)) {
                          return ('Vui lòng nhập password ít nhất 6 kí tự');
                        }
                      },
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
                      controller: _confimpassword,
                      validator: (value) {
                        if (_confimpassword.text.length > 6 &&
                            _password.text != value) {
                          return ('Password không trùng khớp');
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _confimpassword.text = value;
                      },
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
                    child: Text('Đăng kí'),
                    onPressed: () {
                      signUp(_email.text, _password.text);
                    },
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

  void signUp(String email, String password) async {
    if (_formKey.currentState.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          /*
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
           */
          default:
            errorMessage = "Vui lòng kiểm tra lại thông tin.";
        }
        Fluttertoast.showToast(msg: errorMessage);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.hoten = _hoten.text;
    userModel.phone = _phone.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Đăng kí thành công :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => SignIn()), (route) => false);
  }
}
