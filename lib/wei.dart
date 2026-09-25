import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: Test(),
      ),
    );
  }
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  late double _val = 10.0;
  late double _vol = 10.0;
  double vel(double n1, double n2) {
    return 10000 * n1 / (n2 * n2);
  }

  @override
  Widget build(BuildContext context) {
    double ty = vel(_vol, _val);
    return Scaffold(
        // يقبل القيمة كي
        appBar: AppBar(
            title: Text(
              "BMI Calculator",
              style: TextStyle(color: Colors.red),
            ),
            backgroundColor: Colors.black,
            actions: [
              IconButton(icon: Icon(Icons.settings), onPressed: () {})
            ]),
        body: Column(
          children: [
            Slider(
              min: 0.0,
              max: 250.0,
              activeColor: Colors.red, // يجعل زر السلايدر و المنطقة النشطة أحمر
              inactiveColor: Colors.black, // يجعل خلفية السلايدر أخضر
              value: _val,
              onChanged: (val) {
                setState(() {
                  _val = val;
                  print(_val);
                });
              },
            ),
            Slider(
              min: 0.0,
              max: 250.0,
              activeColor: Colors.red, // يجعل زر السلايدر و المنطقة النشطة أحمر
              inactiveColor: Colors.black, // يجعل خلفية السلايدر أخضر
              value: _vol,
              onChanged: (val) {
                setState(() {
                  _vol = val;
                  print(_vol);
                });
              },
            ),
            Text('$_val'),
            Text('$_vol'),
            Text('$ty'),
          ],
        ));
  }
}
