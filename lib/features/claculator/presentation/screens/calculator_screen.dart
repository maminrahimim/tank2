import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  static const String routeName = '/calculator';
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String output = '';

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: const Locale('en'),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black87,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    output,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _buildButton(text: '⌫', color: Colors.blueAccent),
                        _buildButton(text: '7', color: Colors.black87),
                        _buildButton(text: '4', color: Colors.black87),
                        _buildButton(text: '1', color: Colors.black87),
                        _buildButton(text: 'C', color: Colors.blueAccent),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      children: [
                        _buildButton(text: '/', color: Colors.blueAccent),
                        _buildButton(text: '8', color: Colors.black87),
                        _buildButton(text: '5', color: Colors.black87),
                        _buildButton(text: '2', color: Colors.black87),
                        _buildButton(text: '0', color: Colors.black87),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      children: [
                        _buildButton(text: '*', color: Colors.blueAccent),
                        _buildButton(text: '9', color: Colors.black87),
                        _buildButton(text: '6', color: Colors.black87),
                        _buildButton(text: '3', color: Colors.black87),
                        _buildButton(text: '.', color: Colors.black87),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      children: [
                        _buildButton(text: '-', color: Colors.blueAccent),
                        _buildButton(flex: 2, text: '+', color: Colors.blueAccent),
                        _buildButton(flex: 2, text: '=', color: Colors.blueAccent),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({int flex = 1, required String text, required Color color}) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () {
          if (text == 'C') {
            setState(() {
              input = '';
              output = '';
            });
            return;
          }
          if (text == '⌫') {
            if (input.isNotEmpty) {
              setState(() {
                input = input.substring(0, input.length - 1);
              });
            }
            return;
          }
          if (text == '=') {
            ///
            return;
          }
          if (input.isNotEmpty && '/*-+'.contains(input.substring(input.length - 1)) && '/*-+'.contains(text)) {
            setState(() {
              input = input.substring(0, input.length - 1) + text;
            });
            return;
          }
          if (input.isEmpty && '/*-+'.contains(text)) {
            return;
          }
          setState(() {input = input + text;});
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
