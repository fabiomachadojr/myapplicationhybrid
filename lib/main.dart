
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prime Number Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PrimeNumberCalculator(),
    );
  }
}

class PrimeNumberCalculator extends StatefulWidget {
  const PrimeNumberCalculator({super.key});

  @override
  createState() => _PrimeNumberCalculatorState();
}

class _PrimeNumberCalculatorState extends State<PrimeNumberCalculator> {
  final TextEditingController _rangeController = TextEditingController();
  int _primeCount = -1;
  File? _image;

  Future<void> _getImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _image = image != null ? File(image.path) : null;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _rangeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Informe a faixa de números',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _primeCount =
                      calculatePrimes(int.parse(_rangeController.text));
                });
              },
              child: const Text('Calcular Números Primos'),
            ),
            const SizedBox(height: 16),
            if (_primeCount >= 0)
              Text('Quantidade de números primos na faixa: $_primeCount'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Tirar Foto'),
            ),
            const SizedBox(height: 20),
            _image == null
                ? const Text('Nenhuma foto tirada')
                : Image.file(
              _image! as File,
              width: 200,
              height: 200,
            ),

          ],
        ),
      ),
    );
  }

  int calculatePrimes(int range) {
    int count = 0;
    for (int i = 2; i <= range; i++) {
      if (isPrimeNumber(i)) {
        count++;
      }
    }
    return count;
  }

  bool isPrimeNumber(int num) {
    if (num < 2) return false;
    for (int i = 2; i < num; i++) {
      if (num % i == 0) {
        return false;
      }
    }
    return true;
  }
}