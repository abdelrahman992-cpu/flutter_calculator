
import 'dart:math' as math;
import 'package:flutter/material.dart';


class IntegrationScreen extends StatefulWidget {
  const IntegrationScreen({Key? key}) : super(key: key);

  @override
  State<IntegrationScreen> createState() => _IntegrationScreenState();
}

class _IntegrationScreenState extends State<IntegrationScreen> {
int degree = 2;
final int variableCount = 1;

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

void _resetModel(int newDegree) {
  for (final controller in coefficientControllers) {
    controller.dispose();
  }

  setState(() {
    degree = newDegree;
    result = '';
    equation = '';
    _initializeFields();
  });
}
void _solvo() {
  final coefficients = <double>[];

  for (final controller in coefficientControllers) {
    final value = double.tryParse(controller.text.trim());

    if (value == null || !value.isFinite) {
      _showError('Enter a valid number for every coefficient.');
      return;
    }

    coefficients.add(value);
  }

  final integralTerms = <String>[];

  // المعاملات مرتبة: الثابت، ثم x، ثم x^2، وهكذا.
  for (int power = 0; power < coefficients.length; power++) {
    final c = coefficients[power] / (power + 1);

    if (c == 0) continue;

    final newPower = power + 1;
    final absC = c.abs();

    final coefficientText = _format(absC);

    final term = newPower == 1
        ? '${coefficientText}x'
        : '${coefficientText}x^$newPower';

    if (integralTerms.isEmpty) {
      integralTerms.add(c < 0 ? '-$term' : term);
    } else {
      integralTerms.add(c < 0 ? '- $term' : '+ $term');
    }
  }

  final integral = integralTerms.isEmpty
      ? 'C'
      : '${integralTerms.join(' ')} + C';

  setState(() {
    equation = '∫ f(x) dx = $integral';
    result = 'Integration calculated successfully.';
  });
}
  void _calculate() {
    final xValues = <double>[];
    final coefficients = <double>[];



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

    for (final controller in coefficientControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integration Calculator'),
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
                _resetModel(value);
              }
            },
          ),
const SizedBox(height: 24),


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
            onPressed: _solvo,
            icon: const Icon(Icons.calculate),
            label: const Text('Integration'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.orange,
              foregroundColor: Colors.black,
            ),
          ),

          const SizedBox(height: 20),

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

