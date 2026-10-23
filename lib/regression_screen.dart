
import 'dart:math' as math;
import 'package:flutter/material.dart';

class Complex {
  final double re;
  final double im;

  const Complex(this.re, [this.im = 0]);

  Complex operator +(Complex b) =>
      Complex(re + b.re, im + b.im);

  Complex operator -(Complex b) =>
      Complex(re - b.re, im - b.im);

  Complex operator *(Complex b) => Complex(
        re * b.re - im * b.im,
        re * b.im + im * b.re,
      );

  Complex operator /(Complex b) {
    final d = b.re * b.re + b.im * b.im;
    if (d < 1e-30) {
      throw StateError('Division by zero during root calculation.');
    }

    return Complex(
      (re * b.re + im * b.im) / d,
      (im * b.re - re * b.im) / d,
    );
  }

  double get abs => math.sqrt(re * re + im * im);

  @override
  String toString() {
    String f(double x) {
      if (x.abs() < 1e-9) return '0';
      return x.toStringAsPrecision(8);
    }

    if (im.abs() < 1e-8) return f(re);
    if (re.abs() < 1e-8) return '${f(im)}i';

    return '${f(re)} ${im < 0 ? '-' : '+'} ${f(im.abs())}i';
  }
}


class RegressionScreen extends StatefulWidget {
  const RegressionScreen({Key? key}) : super(key: key);

  @override
  State<RegressionScreen> createState() => _RegressionScreenState();
}

class _RegressionScreenState extends State<RegressionScreen> {

List<Complex> _findPolynomialRoots(List<double> input) {
  final a = List<double>.from(input);

  // Remove zero coefficients from the highest powers.
  while (a.length > 1 && a.last.abs() < 1e-14) {
    a.removeLast();
  }

  final n = a.length - 1;

  if (n < 1) {
    throw StateError('The equation has no unique finite set of roots.');
  }

  final leading = a.last;
  final normalized = a.map((v) => v / leading).toList();

  double radius = 1;
  for (int i = 0; i < n; i++) {
    radius = math.max(
      radius,
      1 + normalized[i].abs(),
    );
  }

  List<Complex> roots = List.generate(n, (i) {
    final angle = 2 * math.pi * (i + 0.5) / n;
    return Complex(
      radius * math.cos(angle),
      radius * math.sin(angle),
    );
  });

  Complex evaluate(Complex z) {
    Complex value = Complex(normalized.last);

    for (int i = n - 1; i >= 0; i--) {
      value = value * z + Complex(normalized[i]);
    }

    return value;
  }

  bool converged = false;

  for (int iteration = 0; iteration < 5000; iteration++) {
    double maxChange = 0;
    final nextRoots = List<Complex>.from(roots);

    for (int i = 0; i < n; i++) {
      Complex denominator = Complex(1);

      for (int j = 0; j < n; j++) {
        if (i != j) {
          denominator = denominator * (roots[i] - roots[j]);
        }
      }

      if (denominator.abs < 1e-25) continue;

      final correction = evaluate(roots[i]) / denominator;
      nextRoots[i] = roots[i] - correction;

      maxChange = math.max(maxChange, correction.abs);
    }

    roots = nextRoots;

    if (maxChange < 1e-10) {
      converged = true;
      break;
    }
  }

  if (!converged) {
    throw StateError(
      'The numerical solver did not converge. '
      'Try different coefficients or a lower degree.',
    );
  }

  return roots;
}


void _solveEquation() {
  if (variableCount != 1) {
    _showError(
      'Equation solving currently requires exactly one variable.',
    );
    return;
  }

  final coefficients = <double>[];

  for (final controller in coefficientControllers) {
    final value = double.tryParse(controller.text.trim());

    if (value == null || !value.isFinite) {
      _showError('Enter a valid number for every coefficient.');
      return;
    }

    coefficients.add(value);
  }

  try {
    final roots = _findPolynomialRoots(coefficients);

    final a = List<double>.from(coefficients);
    while (a.length > 1 && a.last.abs() < 1e-14) {
      a.removeLast();
    }

    final degreeActual = a.length - 1;

    if (degreeActual < 1) {
      _showError('Please enter a non-constant equation.');
      return;
    }

    final equationParts = <String>[];

    for (int power = degreeActual; power >= 0; power--) {
      final c = a[power];
      if (c == 0) continue;

      final variable = power == 0
          ? ''
          : power == 1
              ? 'x'
              : 'x^$power';

      equationParts.add('${_format(c)}$variable');
    }

    setState(() {
      equation = '${equationParts.join(' + ')} = 0';

      result = roots.asMap().entries.map((entry) {
        return 'x${entry.key + 1} = ${entry.value}';
      }).join('\n');
    });
  } on StateError catch (e) {
    _showError(e.message.toString());
  } catch (_) {
    _showError('Unable to solve this equation numerically.');
  }
}

  int degree = 2;
  int variableCount = 2;

  late List<TextEditingController> xControllers;
  late List<TextEditingController> coefficientControllers;

  List<List<int>> terms = [];
  String result = '';
  String equation = '';

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    terms = _generateTerms(variableCount, degree);

    xControllers = List.generate(
      variableCount,
      (_) => TextEditingController(),
    );

    coefficientControllers = List.generate(
      terms.length,
      (_) => TextEditingController(),
    );
  }

  // Generate every polynomial term with total degree <= degree.
  List<List<int>> _generateTerms(int variables, int maxDegree) {
    final List<List<int>> output = [];

    for (int total = 0; total <= maxDegree; total++) {
      _generateExactDegree(
        variables,
        total,
        0,
        List.filled(variables, 0),
        output,
      );
    }

    return output;
  }

  void _generateExactDegree(
    int variables,
    int remaining,
    int index,
    List<int> current,
    List<List<int>> output,
  ) {
    if (index == variables - 1) {
      current[index] = remaining;
      output.add(List<int>.from(current));
      return;
    }

    for (int power = remaining; power >= 0; power--) {
      current[index] = power;

      _generateExactDegree(
        variables,
        remaining - power,
        index + 1,
        current,
        output,
      );
    }
  }

  String _termName(List<int> powers) {
    if (powers.every((p) => p == 0)) return 'Constant';

    final parts = <String>[];

    for (int i = 0; i < powers.length; i++) {
      final p = powers[i];
      if (p == 0) continue;

      parts.add(
        p == 1 ? 'x${i + 1}' : 'x${i + 1}^$p',
      );
    }

    return parts.join(' × ');
  }

  String _equationTerm(List<int> powers, double coefficient) {
    final parts = <String>[];

    for (int i = 0; i < powers.length; i++) {
      final p = powers[i];
      if (p == 0) continue;

      parts.add(
        p == 1 ? 'x${i + 1}' : 'x${i + 1}^$p',
      );
    }

    final variablePart = parts.join(' ');

    if (variablePart.isEmpty) {
      return coefficient.toString();
    }

    return '${coefficient.toString()}($variablePart)';
  }

  void _resetModel(int newDegree, int newVariableCount) {
    for (final controller in xControllers) {
      controller.dispose();
    }
    for (final controller in coefficientControllers) {
      controller.dispose();
    }

    setState(() {
      degree = newDegree;
      variableCount = newVariableCount;
      result = '';
      equation = '';
      _initializeFields();
    });
  }

  void _calculate() {
    final xValues = <double>[];
    final coefficients = <double>[];

    for (final controller in xControllers) {
      final value = double.tryParse(controller.text.trim());
      if (value == null || !value.isFinite) {
        _showError('Enter a valid number for every variable.');
        return;
      }
      xValues.add(value);
    }

    for (final controller in coefficientControllers) {
      final value = double.tryParse(controller.text.trim());
      if (value == null || !value.isFinite) {
        _showError('Enter a valid number for every coefficient.');
        return;
      }
      coefficients.add(value);
    }

    double y = 0;
    final equationParts = <String>[];

    for (int i = 0; i < terms.length; i++) {
      double feature = 1;

      for (int j = 0; j < variableCount; j++) {
        feature *= math.pow(xValues[j], terms[i][j]).toDouble();
      }

      y += coefficients[i] * feature;
      equationParts.add(
        _equationTerm(terms[i], coefficients[i]),
      );
    }

    setState(() {
      equation = 'y = ${equationParts.join(' + ')}';
      result = 'Predicted y = ${_format(y)}';
    });
  }

  String _format(double value) {
    if (value.abs() < 1e-10) return '0';
    if (value.isFinite && value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsPrecision(8);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    for (final controller in xControllers) {
      controller.dispose();
    }
    for (final controller in coefficientControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regression Calculator'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Model Settings',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          DropdownButtonFormField<int>(
            value: degree,
            decoration: const InputDecoration(
              labelText: 'Highest power (degree)',
              border: OutlineInputBorder(),
            ),
            items: List.generate(
              5,
              (i) => DropdownMenuItem(
                value: i + 1,
                child: Text('${i + 1}'),
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                _resetModel(value, variableCount);
              }
            },
          ),

          const SizedBox(height: 12),

          DropdownButtonFormField<int>(
            value: variableCount,
            decoration: const InputDecoration(
              labelText: 'Number of independent variables',
              border: OutlineInputBorder(),
            ),
            items: List.generate(
              4,
              (i) => DropdownMenuItem(
                value: i + 1,
                child: Text('${i + 1}'),
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                _resetModel(degree, value);
              }
            },
          ),

          const SizedBox(height: 24),

          Text(
            'Input variables (${xControllers.length})',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          ...List.generate(variableCount, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: xControllers[i],
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Value of x${i + 1}',
                  border: const OutlineInputBorder(),
                ),
              ),
            );
          }),

          const SizedBox(height: 16),

          Text(
            'Coefficients (${coefficientControllers.length})',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Enter one coefficient for each term. '
            'The constant term is included.',
          ),
          const SizedBox(height: 10),

          ...List.generate(terms.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: coefficientControllers[i],
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Coefficient of ${_termName(terms[i])}',
                  border: const OutlineInputBorder(),
                ),
              ),
            );
          }),

          const SizedBox(height: 12),

          Text(
            'Number of coefficients: ${terms.length}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          ElevatedButton.icon(
            onPressed: _calculate,
            icon: const Icon(Icons.calculate),
            label: const Text('Calculate y'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.orange,
              foregroundColor: Colors.black,
            ),
          ),

          const SizedBox(height: 20),
          
const SizedBox(height: 10),

ElevatedButton.icon(
  onPressed: _solveEquation,
  icon: const Icon(Icons.functions),
  label: const Text('Solve Equation'),
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(16),
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
  ),
),


          if (equation.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SelectableText(
                  equation,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

          if (result.isNotEmpty)
            Card(
              color: Colors.orange.shade100,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  result,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

