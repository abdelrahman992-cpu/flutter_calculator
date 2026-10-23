import 'dart:math';
import 'package:flutter/material.dart';
import 'regression_screen.dart';
import 'wei.dart';
import 'differentiation_screen.dart';
import 'integration_screen.dart';

void main() => runApp(MyCalculator());

class MyCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'scientific calculator',
      home: Calculator(),
    );
  }
}

class FibonacciNumbers {
  final cache = {0: BigInt.from(1), 1: BigInt.from(1)};

  BigInt get(int i) {
    if (!cache.containsKey(i)) {
      cache[i] = get(i - 1) + get(i - 2);
    }

    return cache[i]!;
  }
}

class HarmonicNumbers {
  double get(int n) {
    double sum = 0.0;

    for (int i = 1; i <= n; i++) {
      sum += 1.0 / i;
    }

    return sum;
  }

  String expression(int n) {
    if (n <= 0) return '0';

    return List.generate(
      n,
      (i) => i == 0 ? '1' : '1/${i + 1}',
    ).join(' + ');
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
  String text = '0';
  double numOne = 0;
  double numTwo = 0;

  String result = '0';
  String finalResult = '0';

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
      appBar: null,
      backgroundColor: Colors.black,
      body: Container(
  margin: EdgeInsets.only(bottom: 20),
  child: SingleChildScrollView(
    child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                button("...", Color(0xffff9800), 2),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 8,
  ),),
Expanded(
  child: Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
    child: ElevatedButton.icon(
      icon: const Icon(Icons.show_chart),
      label: const Text('Regression Calculator'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(14),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const RegressionScreen(),
          ),
        );
      },
    ),
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
                button("AE", Color(0xffa5a5a5), 1),
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("B", Color(0xffff9800), 1),
                button("C", Color(0xffff9800), 1),
                button("D", Color(0xffff9800), 1),
                button("E", Color(0xffff9800), 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("F", Color(0xffff9800), 1),
                button("W", Color(0xffff9800), 1),
                button("16d", Color(0xffff9800), 1),
                button("A", Color(0xffff9800), 1)
              ],
            ),
          ],
        ),
      ),
    )
    );
  }

  Widget button(String btnTxt, Color color, int num) {
    late Container container;

    if (num == 0) {
      container = Container(
          padding: EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            onPressed: () {
              calculate(btnTxt);
            },
            child: Text(btnTxt, style: TextStyle(fontSize: 30)),
            style: ElevatedButton.styleFrom(
              backgroundColor: color, // set the background color
              padding:
                  EdgeInsets.only(left: 81, top: 20, right: 81, bottom: 20),
              shape: StadiumBorder(),
            ),
          ));
    } else if (num == 1) {
      container = Container(
          padding: EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            onPressed: () {
              calculate(btnTxt);
            },
            child: Text(btnTxt, style: TextStyle(fontSize: 30)),
            style: ElevatedButton.styleFrom(
              backgroundColor: color, // set the background color
              padding: EdgeInsets.all(20),
              shape: CircleBorder(),
            ),
          ));
    } 
else if (num == 2) {
  container = Container(
    padding: const EdgeInsets.only(bottom: 10),
    child: ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (sheetContext) {
            return Container(
              height: 700,
              color: Colors.black,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        button("Sin-1", const Color(0xffff9800), 3),
                        button("Cos-1", const Color(0xffff9800), 3),
                        button("tan-1", const Color(0xffff9800), 3),
                        button("pi", const Color(0xffff9800), 3),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        button("!", const Color(0xffff9800), 3),
                        button("e", const Color(0xffff9800), 3),
                        button("fay", const Color(0xffff9800), 3),
                        button("ln", const Color(0xffff9800), 3),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        button("log", const Color(0xffff9800), 3),
                        button("sinh", const Color(0xffff9800), 3),
                        button("cosh", const Color(0xffff9800), 3),
                        button("tanh", const Color(0xffff9800), 3),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        button("|x|", const Color(0xffff9800), 3),
                        button("sinh-1", const Color(0xffff9800), 3),
                        button("cosh-1", const Color(0xffff9800), 3),
                        button("tanh-1", const Color(0xffff9800), 3),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        button("Fibonacci", const Color(0xffff9800), 4),
                        button("Harmonic", const Color(0xffff9800), 5),
                      ],
                    ),
                       Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        button("Integration", const Color(0xffff9800), 6),
                        button("Differation", const Color(0xffff9800), 7),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        button("nCk", const Color(0xffff9800), 3),
                        button("m", const Color(0xffff9800), 3),
                        button("8+", const Color(0xffff9800), 3),
                        button("16+", const Color(0xffff9800), 3),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        button("G", const Color(0xffff9800), 3),
                        button("m", const Color(0xffff9800), 3),
                        button("se", const Color(0xffff9800), 3),
                        button("2+", const Color(0xffff9800), 3),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(20),
        shape: const CircleBorder(),
      ),
      child: Text(btnTxt, style: const TextStyle(fontSize: 30)),
    ),
  );
}
else if (num == 3) {
      container = Container(
          padding: EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            onPressed: () {
              calculate(btnTxt);
            },
            child: Text(btnTxt, style: TextStyle(fontSize: 15)),
            style: ElevatedButton.styleFrom(
              backgroundColor: color, // set the background color
              padding: EdgeInsets.all(20),
              shape: CircleBorder(),
            ),
          ));
    } else if (num == 4) {
      container = Container(
          padding: EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            onPressed: () {
              FibonacciNumbers? numbers = FibonacciNumbers();
              numbers.get(numOne.toInt());
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FibonacciListView(numbers);
              }));
            },
            child: Text(btnTxt, style: TextStyle(fontSize: 15)),
            style: ElevatedButton.styleFrom(
              backgroundColor: color, // set the background color
              padding:
                  EdgeInsets.only(left: 81, top: 20, right: 81, bottom: 20),
              shape: StadiumBorder(),
            ),
          ));
    }
else if (num == 5) {
  container = Container(
    padding: const EdgeInsets.only(bottom: 10),
    child: ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HarmonicListView(maxN: 100),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(20),
        shape: const StadiumBorder(),
      ),
      child: Text(
        btnTxt,
        style: const TextStyle(fontSize: 15),
      ),
    ),
  );
}
else if (num == 6) {
  container = Container(
    padding: const EdgeInsets.only(bottom: 10),
    child: ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const IntegrationScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(20),
        shape: const StadiumBorder(),
      ),
      child: Text(
        btnTxt,
        style: const TextStyle(fontSize: 15),
      ),
    ),
  );
}
else if (num == 7) {
  container = Container(
    padding: const EdgeInsets.only(bottom: 10),
    child: ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
builder: (context) => const DifferentiationScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(20),
        shape: const StadiumBorder(),
      ),
      child: Text(
        btnTxt,
        style: const TextStyle(fontSize: 15),
      ),
    ),
  );
}

    return container;
  }

  void calculate(txtBtn) {
    if (txtBtn == 'AE') {
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
        case 'nCk':
          finalResult = nck();
          break;
        case 'm':
          finalResult = mck();
          break;
      }
    } else if (txtBtn == '+' ||
        txtBtn == '-' ||
        txtBtn == 'X' ||
        txtBtn == '/' ||
        txtBtn == '=' ||
        txtBtn == 'pow' ||
        txtBtn == 'nCk' ||
        txtBtn == 'm') {
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
        case 'nCk':
          finalResult = nck();
          break;
        case 'm':
          finalResult = mck();
          break;
      }

      preOpr = opr;
      opr = txtBtn;
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
      preOpr = opr;
      opr = txtBtn;
      numOne = double.parse(result);

      result = (roundDouble(sin(numOne * pi / 180), 5)).toString();
      finalResult = result;
    } else if (txtBtn == 'Cos') {
      preOpr = opr;
      opr = txtBtn;
      numOne = double.parse(result);

      result = (roundDouble(cos(numOne * pi / 180), 5)).toString();
      finalResult = result;
    } else if (txtBtn == 'tan') {
      preOpr = opr;
      opr = txtBtn;
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
        txtBtn == '9' ||
        txtBtn == 'A' ||
        txtBtn == 'B' ||
        txtBtn == 'C' ||
        txtBtn == 'D' ||
        txtBtn == 'E' ||
        txtBtn == 'F') {
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
    } else if (txtBtn == '16d') {
      result = (int.parse(result, radix: 16)).toString();
      finalResult = result;
    } else if (txtBtn == '2d') {
      result = (int.parse(result, radix: 2)).toString();
      finalResult = result;
    } else if (txtBtn == '8d') {
      result = (int.parse(result, radix: 8)).toString();
      finalResult = result;
    } else if (txtBtn == 'W') {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Test();
      }));
 
    }
    setState(() {
      text = finalResult;
    });
  }


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

  String nck() {
    result = (fact(numOne) / (fact(numTwo) * fact(numOne - numTwo))).toString();
    numOne = double.parse(result);
    return result;
  }

  String mck() {
    var a = numOne.toInt();
    var b = numTwo.toInt();
    result = (a.toRadixString(b)).toString();
    if (result.contains('a') ||
        result.contains('b') ||
        result.contains('c') ||
        result.contains('d') ||
        result.contains('e') ||
        result.contains('f') ||
        result.contains('A') ||
        result.contains('B') ||
        result.contains('C') ||
        result.contains('D') ||
        result.contains('E') ||
        result.contains('F')) {
      var i = int.parse(result, radix: 16);
      result = result.toUpperCase();
      numOne = i.toDouble();
    } else {
      numOne = double.parse(result);
    }
    return result;
  }

  String m16() {
    var a = numOne.toInt();
    var b = numTwo.toInt();
    result = (a.toRadixString(b)).toString();

    return result;
  }

  String decimalRemove(String _result) {
    if (_result.contains('.')) {
      List<String> split = _result.split('.');
      //[11, 0]
      if (!(int.parse(split[1]) > 0)) return split[0];
    }
    return _result;
  }
}

class FibonacciListView extends StatelessWidget {
  final FibonacciNumbers numbers;
  const FibonacciListView(this.numbers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Fibonacci List'),
      ),
      body: ListView.builder(
        itemBuilder: (context, i) {
          return ListTile(
            title: Text('${numbers.get(i).toString()}'),
            onTap: () {
              final snack = SnackBar(
                content:
                    Text('${numbers.get(i)} is #$i in the Fibonacci sequence!'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snack);
            },
          );
        },
      ),
    );
  }
}

class HarmonicListView extends StatelessWidget {
  final int maxN;

  const HarmonicListView({
    Key? key,
    this.maxN = 100,
  }) : super(key: key);

  String formatSum(double value) {
    return value
        .toStringAsFixed(6)
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }

  @override
  Widget build(BuildContext context) {
    final numbers = HarmonicNumbers();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Harmonic Series'),
      ),
      body: ListView.builder(
        itemCount: maxN,
        itemBuilder: (context, index) {
          final n = index + 1;
          final sum = numbers.get(n);

          return ListTile(
            leading: CircleAvatar(child: Text('$n')),
            title: Text(
              formatSum(sum),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Harmonic number $n'),
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: Text('Harmonic number $n'),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Sum:'),
                        SelectableText(
                          formatSum(sum),
                          style: const TextStyle(fontSize: 22),
                        ),
                        const SizedBox(height: 16),
                        const Text('Expression:'),
                        SelectableText(
                          numbers.expression(n),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

