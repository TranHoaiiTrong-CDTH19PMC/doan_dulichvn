// import 'package:flutter/material.dart';

// class Profile extends StatefulWidget {
//   @override
//   ProfileScreen createState() => ProfileScreen();
// }

// class ProfileScreen extends State<Profile> {
//   static const routeName = '/profile';
//   @override
//   Widget build(BuildContext context) {
//     Widget hang1 = Container(
//       padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ListTile(
//             leading: Icon(Icons.people),
//             title: Text("Nguyễn Anh Khoa"),
//             trailing: Icon(Icons.chevron_right),
//           ),
//           ListTile(
//             leading: Icon(Icons.email),
//             title: Text("nguyenanhkhoa@gmail.com"),
//             trailing: Icon(Icons.chevron_right),
//           ),
//           ListTile(
//             leading: Icon(Icons.phone),
//             title: Text('0306191234'),
//             trailing: Icon(Icons.chevron_right),
//           )
//         ],
//       ),
//     );
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Account'),
//           backgroundColor: Colors.indigo,
//         ),
//         body: Column(
//           children: [
//             hang1,
//             Center(child: Column(children: [])),
//           ],
//         ));
//   }
// }
