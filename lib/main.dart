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
  File? _selectedImage;

  Future<void> _getImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _image = image != null ? File(image.path) : null;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            color: Colors.yellowAccent,
            child: Column(
              children: [
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
              width: double.infinity,
              color: Colors.green,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _getImage,
                    child: Text('Camera'),
                  ),
                  _image == null
                      ? const Text('Nenhuma foto selecionada')
                      : Image.file(
                          _image! as File,
                          width: 150,
                          height: 150,
                        ),
                  const SizedBox(height: 16),
                ],
              )),
          const SizedBox(height: 16),
          Container(
              width: double.infinity,
              color: Colors.purpleAccent,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Selecionar imagem'),
                  ),
                  _selectedImage == null
                      ? const Text('Nenhuma imagem selecionada')
                      : Image.file(
                          _selectedImage!,
                          width: 150,
                          height: 150,
                        ),
                  const SizedBox(height: 16),
                ],
              )),
        ],
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
