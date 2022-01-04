import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_flutter/screens/home_screen.dart';

import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  @override
  InScreen createState() => InScreen();
}

class InScreen extends State<SignIn> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String errorMessage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
                    controller: _email,
                    validator: (value) {
                      if (value.isEmpty) {
                        return ('Vui lòng nhập email');
                      }
                      if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]')
                          .hasMatch(value)) {
                        return ('Vui lòng nhập email đúng định dạng');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email.text = value;
                    },
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
                    onSaved: (value) {
                      _password.text = value;
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
                  onPressed: () {
                    signIn(_email.text, _password.text);
                  },
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            UpScreen.routeName,
                          );
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
            ],
          )),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Đăng nhập thành công"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "email không hợp lệ":
            errorMessage = "Email không đúng định dạng.";

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
            errorMessage = "Nhập Email.";
        }
        Fluttertoast.showToast(msg: errorMessage);
        print(error.code);
      }
    }
  }
}
