import 'package:flutter/material.dart';

class Practica4 extends StatefulWidget {
  const Practica4({super.key});

  @override
  State<Practica4> createState() => _Practica4State();
}

class _Practica4State extends State<Practica4> {
  int _counter = 0;
  final List<String> _helloList = [];

  void _generateSingleHello() {
    setState(() {
      _helloList.add('Hola Mundo ${_helloList.length + 1}');
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _helloList.clear();
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica 4 - Modificada'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (_helloList.isNotEmpty)
            IconButton(
              onPressed: _resetCounter,
              icon: const Icon(Icons.refresh),
              tooltip: 'Reiniciar contador',
            ),
        ],
      ),
      body: Stack(
        children: [
          // Contenedor principal con contador y lista
          Column(
            children: [
              // Contador
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.blue[50],
                child: Text(
                  'Total de "Hola Mundo": $_counter',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Lista centrada
              Expanded(
                child: Center(
                  child: _helloList.isEmpty
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.list, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'Presiona el botón + para generar Hola Mundos',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : Container(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: ListView.builder(
                            itemCount: _helloList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    child: Text('${index + 1}'),
                                  ),
                                  title: Text(
                                    _helloList[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ),
            ],
          ),

          // Botón con solo el icono "+" en la parte inferior derecha
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: _generateSingleHello,
              child: const Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
