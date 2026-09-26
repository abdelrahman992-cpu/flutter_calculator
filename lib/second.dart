import 'dart:math';
import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  final TextEditingController x2 = TextEditingController();
  final TextEditingController x = TextEditingController();
  final TextEditingController c = TextEditingController();

  @override
  void dispose() {
    x2.dispose();
    x.dispose();
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Degree Equation'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: x2,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Coefficient of x²',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'x² +',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: x,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Coefficient of x',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'x +',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: c,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Constant',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Enter the coefficients of:',
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 5),

              const Text(
                'ax² + bx + c = 0',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _solveEquation,
                child: const Text('Calculate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _solveEquation() {
    final double? a = double.tryParse(x2.text);
    final double? b = double.tryParse(x.text);
    final double? cValue = double.tryParse(c.text);

    if (a == null || b == null || cValue == null) {
      _showResult('Please enter valid numbers.');
      return;
    }

    if (a == 0) {
      if (b == 0) {
        _showResult(
          cValue == 0
              ? 'Infinite solutions.'
              : 'No solution.',
        );
        return;
      }

      final double result = -cValue / b;

      _showResult(
        'This is a linear equation.\nx = ${_formatNumber(result)}',
      );
      return;
    }

    final double discriminant = (b * b) - (4 * a * cValue);

    if (discriminant > 0) {
      final double sqrtD = sqrt(discriminant);

      final double x1 = (-b + sqrtD) / (2 * a);
      final double x2Result = (-b - sqrtD) / (2 * a);

      _showResult(
        'Two real solutions:\n'
        'x₁ = ${_formatNumber(x1)}\n'
        'x₂ = ${_formatNumber(x2Result)}',
      );
    } else if (discriminant == 0) {
      final double result = -b / (2 * a);

      _showResult(
        'One real solution:\nx = ${_formatNumber(result)}',
      );
    } else {
      final double realPart = -b / (2 * a);
      final double imaginaryPart =
          sqrt(-discriminant) / (2 * a);

      _showResult(
        'Complex solutions:\n'
        'x₁ = ${_formatNumber(realPart)} + '
        '${_formatNumber(imaginaryPart)}i\n'
        'x₂ = ${_formatNumber(realPart)} - '
        '${_formatNumber(imaginaryPart)}i',
      );
    }
  }

  String _formatNumber(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    return value.toStringAsFixed(6);
  }

  void _showResult(String message) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Result'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


