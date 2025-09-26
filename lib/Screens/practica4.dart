import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

class Practica4 extends StatefulWidget {
  const Practica4({super.key});

  @override
  State<Practica4> createState() => _Practica4State();
}

class _Practica4State extends State<Practica4> {
  int _counter = 0; // Contador total de mensajes generados
  final List<String> _helloList =
      []; // Lista dinámica con mensajes "Hola Mundo"

  // Genera un mensaje "Hola Mundo" individual
  void _generateSingleHello() {
    setState(() {
      _helloList.add('Hola Mundo ${_helloList.length + 1}');
      _counter++;
    });

    // Mensaje flotante de confirmación
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"Hola Mundo $_counter" agregado'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Genera múltiples mensajes de golpe (ej. +5, +10)
  void _generateMultipleHello(int cantidad) {
    setState(() {
      for (int i = 0; i < cantidad; i++) {
        _helloList.add('Hola Mundo ${_helloList.length + 1}');
        _counter++;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$cantidad mensajes agregados'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Reinicia el contador y limpia la lista (con confirmación)
  void _resetCounter() {
    if (_helloList.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar reinicio'),
        content: Text(
          '¿Estás seguro de que quieres eliminar los $_counter mensajes?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _helloList.clear();
                _counter = 0;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Contador reiniciado'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Reiniciar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Muestra opciones rápidas (+1, +5, +10) en un modal inferior
  void _mostrarOpciones() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Agregar múltiples mensajes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [1, 5, 10].map((cantidad) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _generateMultipleHello(cantidad);
                  },
                  child: Text('+$cantidad'),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica 4 - Contador Dinámico'),
        centerTitle: true,
        actions: [
          if (_helloList.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: _resetCounter,
              tooltip: 'Reiniciar contador',
            ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'agregar_multiple') {
                _mostrarOpciones();
              } else if (value == 'reiniciar') {
                _resetCounter();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'agregar_multiple',
                child: Text('Agregar múltiples mensajes'),
              ),
              if (_helloList.isNotEmpty)
                const PopupMenuItem(
                  value: 'reiniciar',
                  child: Text(
                    'Reiniciar contador',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Container(
        // Fondo con gradiente
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                // Tarjeta con estadísticas
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatCard('Total', _counter, Icons.countertops),
                          _buildStatCard(
                            'En lista',
                            _helloList.length,
                            Icons.list,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Barra de progreso (proporción mensajes en lista vs total)
                      LinearProgressIndicator(
                        value: _counter > 0 ? _helloList.length / _counter : 0,
                        backgroundColor: Colors.grey[300],
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),

                // ✅ Contenido principal (lista o pantalla vacía)
                Expanded(
                  child: Center(
                    child: _helloList.isEmpty
                        ? // Pantalla inicial antes de agregar mensajes
                          Container(
                            padding: const EdgeInsets.all(30),
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.list_alt,
                                  size: 80,
                                  color: Colors.blueAccent,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Práctica 4 - Contador Dinámico',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Presiona el botón + para generar mensajes "Hola Mundo" dinámicamente.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueAccent,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton.icon(
                                  onPressed: _generateSingleHello,
                                  icon: const Icon(Icons.add),
                                  label: const Text('Generar Primer Mensaje'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : // Lista de mensajes generados
                          Container(
                            constraints: const BoxConstraints(maxWidth: 600),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: ListView.builder(
                                itemCount: _helloList.length,
                                itemBuilder: (context, index) {
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: index % 2 == 0
                                          ? Colors.blueAccent.withOpacity(0.1)
                                          : Colors.lightBlueAccent.withOpacity(
                                              0.1,
                                            ),
                                      borderRadius: BorderRadius.circular(12),
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
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 18,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _helloList.removeAt(index);
                                            _counter--;
                                          });
                                        },
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

            // ✅ Botón para agregar un mensaje
            Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: _generateSingleHello,
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueAccent,
                elevation: 5,
                child: const Icon(Icons.add),
              ),
            ),

            // ✅ Botón de agregar múltiple
            if (_helloList.isNotEmpty)
              Positioned(
                left: 20,
                bottom: 20,
                child: FloatingActionButton(
                  onPressed: _mostrarOpciones,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  elevation: 5,
                  child: const Icon(Icons.playlist_add),
                ),
              ),

            // ✅ Botón de reinicio
            if (_helloList.isNotEmpty)
              Positioned(
                left: MediaQuery.of(context).size.width / 2 - 28,
                bottom: 20,
                child: FloatingActionButton(
                  onPressed: _resetCounter,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.redAccent,
                  elevation: 5,
                  mini: true,
                  child: const Icon(Icons.refresh),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Tarjetas de estadísticas
  Widget _buildStatCard(String title, int value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 24),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
      ],
    );
  }
}
