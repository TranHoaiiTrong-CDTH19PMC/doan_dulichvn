class UserModel {
  String uid;
  String hoten;
  String email;
  String phone;

  UserModel({this.uid, this.hoten, this.email, this.phone});

  ///du lieu server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map('id'),
      hoten: map('hoten'),
      email: map('email'),
      phone: map('phone'),
    );
  }

  ///gui du lieu len Fb
  Map<String, dynamic> toMap() {
    return {
      'id': uid,
      'hoten': hoten,
      'email': email,
      'phone': phone,
    };
  }
}
