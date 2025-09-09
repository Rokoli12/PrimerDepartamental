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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
          ),
        ),
        child: Stack(
          children: [
            // Contenedor principal con contador y lista
            Column(
              children: [
                // Contador
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.countertops, color: Colors.blueAccent),
                      const SizedBox(width: 10),
                      Text(
                        'Total de "Hola Mundo": $_counter',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),

                // Lista centrada
                Expanded(
                  child: Center(
                    child: _helloList.isEmpty
                        ? Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.list,
                                  size: 64,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Presiona el botón + para generar Hola Mundos',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueAccent,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        : Container(
                            constraints: const BoxConstraints(maxWidth: 600),
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: ListView.builder(
                                itemCount: _helloList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: index % 2 == 0
                                          ? Colors.blueAccent.withOpacity(0.1)
                                          : Colors.lightBlueAccent.withOpacity(
                                              0.1,
                                            ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.blueAccent,
                                        foregroundColor: Colors.white,
                                        child: Text('${index + 1}'),
                                      ),
                                      title: Text(
                                        _helloList[index],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
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
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueAccent,
                child: const Icon(Icons.add),
                elevation: 5,
              ),
            ),

            // Botón de reinicio en la parte inferior izquierda
            if (_helloList.isNotEmpty)
              Positioned(
                left: 20,
                bottom: 20,
                child: FloatingActionButton(
                  onPressed: _resetCounter,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.redAccent,
                  child: const Icon(Icons.refresh),
                  elevation: 5,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
