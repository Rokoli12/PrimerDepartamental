import 'package:flutter/material.dart';

class Practica3 extends StatefulWidget {
  const Practica3({super.key});

  @override
  State<Practica3> createState() => _Practica3State();
}

class _Practica3State extends State<Practica3> {
  bool _showText = false;

  void _toggleText() {
    setState(() {
      _showText = !_showText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica 3'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_showText)
              Column(
                children: List.generate(
                  10,
                  (index) =>
                      const Text('Hola Mundo', style: TextStyle(fontSize: 20)),
                ),
              )
            else
              ElevatedButton(
                onPressed: _toggleText,
                child: const Text('Mostrar 10 Hola Mundo'),
              ),
          ],
        ),
      ),
    );
  }
}
