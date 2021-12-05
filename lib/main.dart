import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const dulich(),
    );
  }
}

class dulich extends StatefulWidget {
  const dulich({Key? key}) : super(key: key);

  @override
  _dulichState createState() => _dulichState();
}

class _dulichState extends State<dulich> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
