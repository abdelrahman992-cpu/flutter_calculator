import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyCalculator());

class MyCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false, //يخفي شريط ديباج اللي على الجنب فوق

      title: 'calculator',
      home: Calculator(),

      routes: {"pagetwo": (context) => pagetwo()},
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Calculator();
  }
}

class _Calculator extends State<Calculator> {
  //لإنه واخد فوق من ستيت فول

  String text = '0';
  double numOne = 0;
  double numTwo = 0;

  String result = '0';
  String finalResult = '0'; //النتيجة النهائية

  String opr = '';
  String preOpr = '';
  double fact(double n) {
    double fac = 1.0;
    for (double i = 1.0; i <= n; i++) {
      fac = fac * i;
    }
    return fac;
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places).toDouble();
    return ((value * mod).round().toDouble() / mod);
  }

  double sinh(double x) {
    return (exp(numOne) - exp(-numOne)) / 2;
  }

  double tanh(double angle) {
    if (angle > 19.1) {
      return 1.0;
    }

    if (angle < -19.1) {
      return -1.0;
    }

    var e1 = exp(angle);
    var e2 = exp(-angle);
    return (e1 - e2) / (e1 + e2);
  }

  double sinh1(double angle) {
    double gg = angle + sqrt(pow(angle, 2) + 1);
    return log(gg);
  }

  double cosh1(double angle) {
    double gg = angle + sqrt(pow(angle, 2) - 1);
    return log(gg);
  }

  double tanh1(double angle) {
    return 0.5 * log((1 + angle) / (1 - angle));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // ألأفضل إننا نبدأ بسكاف فولد
      appBar: null,
      backgroundColor: Colors.black, // الخلفية إسود
      body: Container(
        margin: EdgeInsets.only(bottom: 20), //هامش قد إيه
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                button("...", Color(0xffff9800), 2),
                Expanded(
                  // لكي يملأ العمود كله
                  child: Text(
                    text,
                    style: TextStyle(
                        // صفات ما في داخل التكست فيلد
                        color: Colors.white,
                        fontSize: 30),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("Sin", Color(0xffff9800), 1),
                button("Cos", Color(0xffff9800), 1),
                button("tan", Color(0xffff9800), 1),
                button("pow", Color(0xffff9800), 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("C", Color(0xffa5a5a5), 1),
                button("+/-", Color.fromRGBO(165, 165, 165, 1), 1),
                button("%", Color(0xffa5a5a5), 1),
                button("/", Color(0xffff9800), 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("7", Color(0xff323232), 1),
                button("8", Color(0xff323232), 1),
                button("9", Color(0xff323232), 1),
                button("X", Color(0xffff9800), 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("4", Color(0xff323232), 1),
                button("5", Color(0xff323232), 1),
                button("6", Color(0xff323232), 1),
                button("-", Color(0xffff9800), 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("1", Color(0xff323232), 1),
                button("2", Color(0xff323232), 1),
                button("3", Color(0xff323232), 1),
                button("+", Color(0xffff9800), 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("0", Color(0xff323232), 1),
                button(".", Color(0xff323232), 1),
                button("=", Color(0xffff9800), 1),
                button("<-", Color(0xffff9800), 1)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget button(String btnTxt, Color color, int num) {
    // دالة إسمها بوتون تستدعى كل ما أريد أنشي زر

    late Container container;

    if (num == 0) {
      container = Container(
          padding: EdgeInsets.only(bottom: 10),
          child: RaisedButton(
            onPressed: () {
              calculate(btnTxt);
            },
            child: Text(btnTxt, style: TextStyle(fontSize: 30)),
            color: color,
            padding: EdgeInsets.only(left: 81, top: 20, right: 81, bottom: 20),
            shape: StadiumBorder(), //تبقى شكل الاستاد مستطيل مدور
          ));
    } else if (num == 1) {
      container = Container(
          padding: EdgeInsets.only(bottom: 10),
          child: RaisedButton(
            onPressed: () {
              calculate(btnTxt);
            },
            child: Text(btnTxt, style: TextStyle(fontSize: 30)),
            color: color,
            padding: EdgeInsets.all(20),
            shape: CircleBorder(), // يجعل شكل الزر دائري
          ));
    } else if (num == 2) {
      container = Container(
          padding: EdgeInsets.only(bottom: 10),
          child: RaisedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                        color: Colors.black,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  button("Sin-1", Color(0xffff9800), 3),
                                  button("Cos-1", Color(0xffff9800), 3),
                                  button("tan-1", Color(0xffff9800), 3),
                                  button("pi", Color(0xffff9800), 3)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  button("!", Color(0xffff9800), 3),
                                  button("e", Color(0xffff9800), 3),
                                  button("fay", Color(0xffff9800), 3),
                                  button("ln", Color(0xffff9800), 3)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  button("log", Color(0xffff9800), 3),
                                  button("sinh", Color(0xffff9800), 3),
                                  button("cosh", Color(0xffff9800), 3),
                                  button("tanh", Color(0xffff9800), 3)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  button("|x|", Color(0xffff9800), 3),
                                  button("sinh-1", Color(0xffff9800), 3),
                                  button("cosh-1", Color(0xffff9800), 3),
                                  button("tanh-1", Color(0xffff9800), 3)
                                ],
                              ),
                            ],
                          ),
                        ),
                        height: 500);
                  });
            },
            child: Text(btnTxt, style: TextStyle(fontSize: 30)),
            color: color,
            padding: EdgeInsets.all(20),
            shape: CircleBorder(), // يجعل شكل الزر دائري
          ));
    } else if (num == 3) {
      container = Container(
          padding: EdgeInsets.only(bottom: 10),
          child: RaisedButton(
            onPressed: () {
              calculate(btnTxt);
            },
            child: Text(btnTxt, style: TextStyle(fontSize: 15)),
            color: color,
            padding: EdgeInsets.all(20),
            shape: CircleBorder(), // يجعل شكل الزر دائري
          ));
    }

    return container;
  }

  void calculate(txtBtn) {
    if (txtBtn == 'C') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && txtBtn == '=') {
      switch (preOpr) {
        case '+':
          finalResult = add();
          break;
        case '-':
          finalResult = sub();
          break;
        case 'X':
          finalResult = mul();
          break;
        case '/':
          finalResult = div();
          break;
        case 'pow':
          finalResult = power();
          break;
      }
    } else if (txtBtn == '+' ||
        txtBtn == '-' ||
        txtBtn == 'X' ||
        txtBtn == '/' ||
        txtBtn == '=' ||
        txtBtn == 'pow') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      switch (opr) {
        case '+':
          finalResult = add();
          break;
        case '-':
          finalResult = sub();
          break;
        case 'X':
          finalResult = mul();
          break;
        case '/':
          finalResult = div();
          break;
        case 'pow':
          finalResult = power();
          break;
      }

      preOpr =
          opr; //بساوي البري أوبر بالأوبر و بكدة أعرف أشتغل عليهم في سويتش أوبر
      opr = txtBtn; // بساوي الأوبر بالتكست بوتن
      result = '';
    } else if (txtBtn == '%') {
      numOne = double.parse(result);

      result = (numOne / 100).toString();
      finalResult = result;
    } else if (txtBtn == '.') {
      if (!result.contains('.')) result += '.';
      finalResult = result;
    } else if (txtBtn == '+/-') {
      result.startsWith('-')
          ? result = result.substring(1)
          : result = '-' + result;

      finalResult = result;
    } else if (txtBtn == 'Sin') {
      preOpr =
          opr; //بساوي البري أوبر بالأوبر و بكدة أعرف أشتغل عليهم في سويتش أوبر
      opr = txtBtn; // بساوي الأوبر بالتكست بوتن
      numOne = double.parse(result);

      result = (roundDouble(sin(numOne * pi / 180), 5)).toString();
      finalResult = result;
    } else if (txtBtn == 'Cos') {
      preOpr =
          opr; //بساوي البري أوبر بالأوبر و بكدة أعرف أشتغل عليهم في سويتش أوبر
      opr = txtBtn; // بساوي الأوبر بالتكست بوتن
      numOne = double.parse(result);

      result = (roundDouble(cos(numOne * pi / 180), 5)).toString();
      finalResult = result;
    } else if (txtBtn == 'tan') {
      preOpr =
          opr; //بساوي البري أوبر بالأوبر و بكدة أعرف أشتغل عليهم في سويتش أوبر
      opr = txtBtn; // بساوي الأوبر بالتكست بوتن
      numOne = double.parse(result);

      result = ('${tan(numOne * pi / 180)}');
      finalResult = result;
    } else if (txtBtn == '0' ||
        txtBtn == '1' ||
        txtBtn == '2' ||
        txtBtn == '3' ||
        txtBtn == '4' ||
        txtBtn == '5' ||
        txtBtn == '6' ||
        txtBtn == '7' ||
        txtBtn == '8' ||
        txtBtn == '9') {
      if (result == '0')
        result = txtBtn;
      else
        result = result + txtBtn;
      finalResult = result;
    } else if (txtBtn == '!') {
      numOne = double.parse(result);
      result = fact(numOne).toString();
      finalResult = result;
    } else if (txtBtn == 'Sin-1') {
      numOne = double.parse(result);
      result = (asin(numOne) * 180 / pi).toString();
      finalResult = result;
    } else if (txtBtn == 'Cos-1') {
      numOne = double.parse(result);
      result = (acos(numOne) * 180 / pi).toString();
      finalResult = result;
    } else if (txtBtn == 'tan-1') {
      numOne = double.parse(result);
      result = (atan(numOne) * 180 / pi).toString();
      finalResult = result;
    } else if (txtBtn == 'pi') {
      result = 3.1415926535897932.toString();
      finalResult = result;
    } else if (txtBtn == 'e') {
      result = 2.718281828459045.toString();
      finalResult = result;
    } else if (txtBtn == 'fay') {
      result = 1.6180339887.toString();
      finalResult = result;
    } else if (txtBtn == 'ln') {
      numOne = double.parse(result);
      result = (log(numOne)).toString();
      finalResult = result;
    } else if (txtBtn == 'log') {
      numOne = double.parse(result);
      result = ((log(numOne) / ln10).round()).toString();
      finalResult = result;
    } else if (txtBtn == '<-') {
      result = result.substring(0, result.length - 1);
      finalResult = result;
    } else if (txtBtn == 'sinh') {
      numOne = double.parse(result);
      result = ((exp(numOne) - exp(-numOne)) / 2).toString();
      finalResult = result;
    } else if (txtBtn == 'cosh') {
      numOne = double.parse(result);
      result = sqrt(1 + pow(sinh(numOne), 2)).toString();
      finalResult = result;
    } else if (txtBtn == 'tanh') {
      numOne = double.parse(result);
      result = tanh(numOne).toString();
      finalResult = result;
    } else if (txtBtn == '|x|') {
      numOne = double.parse(result);
      numOne < 0
          ? result = (numOne * (-1)).toString()
          : result = numOne.toString();

      finalResult = result;
    } else if (txtBtn == 'sinh-1') {
      numOne = double.parse(result);
      result = sinh1(numOne).toString();
      finalResult = result;
    } else if (txtBtn == 'cosh-1') {
      numOne = double.parse(result);
      result = cosh1(numOne).toString();
      finalResult = result;
    } else if (txtBtn == 'tanh-1') {
      numOne = double.parse(result);
      result = tanh1(numOne).toString();
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });
  }

/*
  */
  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return decimalRemove(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return decimalRemove(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return decimalRemove(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return decimalRemove(result);
  }

  String power() {
    result = pow(numOne, numTwo).toString();
    numOne = double.parse(result);
    return result;
  }

  String decimalRemove(String _result) {
    // دالة لأحرك العلامة العشرية

    if (_result.contains('.')) {
      // لو يحتوي علامة عشرية
      List<String> split = _result.split('.');
      //[11, 0]
      if (!(int.parse(split[1]) > 0)) // لو كسر إعتيادي عديها لكن لو رقم بصفر
        return split[
            0]; //لو أكبر من صفر لو أكبر من صفر مش هيخش هنا لو أصغر من صفر يخش هنا
    }
    return _result;
  }
}
//فيه 6  صفوف

class pagetwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.black), body: Text("page one"));
  }
}
