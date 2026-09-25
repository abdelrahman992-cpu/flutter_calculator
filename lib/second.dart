import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF212121),
        accentColor: const Color(0xFF64ffda),
        canvasColor: const Color(0xFF303030),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController x2 = TextEditingController();
  TextEditingController x = TextEditingController();
  TextEditingController c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('second degree equation'),
          backgroundColor: Colors.black,
        ),
        body: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Form(
                  key: formstate,
                  child: Column(children: [
                    new TextFormField(
                      controller: x2,
                      style: new TextStyle(
                          fontSize: 12.0,
                          color: const Color(0xff8b0c0c),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    ),
                    new Text(
                      "x2+",
                      style: new TextStyle(
                          fontSize: 12.0,
                          color: const Color(0xff0e0101),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    ),
                    TextFormField(
                      controller: x,
                      style: new TextStyle(
                          fontSize: 12.0,
                          color: const Color(0xffae1a1a),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    ),
                    new Text(
                      "x+",
                      style: new TextStyle(
                          fontSize: 12.0,
                          color: const Color(0xff0f0000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    ),
                    new TextFormField(
                      controller: c,
                      style: new TextStyle(
                          fontSize: 12.0,
                          color: const Color(0xff970c0c),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    ),
                  ])),
              new Text(
                "0",
                style: new TextStyle(
                    fontSize: 12.0,
                    color: const Color(0xff220101),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
              new Text(
                "0",
                style: new TextStyle(
                    fontSize: 12.0,
                    color: const Color(0xff350202),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              )
            ]));
  }
}
   new  Text(
                "0",
                style: new TextStyle(
                    fontSize: 12.0,
                    color: const Color(0xff350202),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              )
            ]));
  }
}
