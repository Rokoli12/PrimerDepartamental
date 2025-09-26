// Importación de paquetes y widgets necesarios
import 'package:flutter/material.dart';
import 'dart:math'; // Para generar números aleatorios
import '../widgets/custom_drawer.dart';

// Definición de la clase StatefulWidget para el juego
class ParImparScreen extends StatefulWidget {
  const ParImparScreen({super.key});

  @override
  State<ParImparScreen> createState() => _ParImparScreenState();
}

// Clase State que maneja el estado del juego
class _ParImparScreenState extends State<ParImparScreen> {
  // Variables de estado del juego
  String? _userChoice; // Elección del usuario (Par/Impar)
  int? _userNumber; // Número elegido por el usuario
  int? _cpuNumber; // Número generado por la CPU
  int _userScore = 0; // Puntuación del usuario
  int _cpuScore = 0; // Puntuación de la CPU
  final Random _random = Random(); // Generador de números aleatorios

  // Método principal para jugar una ronda
  void _playGame(int userNumber) {
    if (_userChoice == null) return;

    setState(() {
      _userNumber = userNumber;
      _cpuNumber = _random.nextInt(6); // Número aleatorio entre 0-5

      int total = userNumber + _cpuNumber!;
      bool isEven = total % 2 == 0; // Verificar si es par

      String result;
      // Determinar ganador según las reglas del juego
      if ((isEven && _userChoice == 'Par') ||
          (!isEven && _userChoice == 'Impar')) {
        _userScore++;
        result = '¡Ganaste!';
      } else {
        _cpuScore++;
        result = 'CPU gana';
      }

      // Mostrar resultado de la jugada
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Tú: $userNumber, CPU: $_cpuNumber - Total: $total (${isEven ? 'Par' : 'Impar'}) - $result',
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

  // Método para reiniciar el juego
  void _resetGame() {
    setState(() {
      _userChoice = null;
      _userNumber = null;
      _cpuNumber = null;
      _userScore = 0;
      _cpuScore = 0;
    });
  }

  // Método build principal que construye la interfaz del juego
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego: Par o Impar'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      drawer: const CustomDrawer(), // Drawer personalizado
      body: Container(
        // Fondo con gradiente decorativo
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red, Colors.orange],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Sección de selección Par/Impar
              const Text(
                'Elige Par o Impar:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Par', label: Text('Par')),
                  ButtonSegment(value: 'Impar', label: Text('Impar')),
                ],
                selected: _userChoice != null ? {_userChoice!} : <String>{},
                onSelectionChanged: (Set<String> newSelection) {
                  setState(() {
                    _userChoice = newSelection.first;
                  });
                },
                emptySelectionAllowed: true, // Permite no tener selección
              ),

              const SizedBox(height: 30),

              // Sección de selección de números (0-5)
              const Text(
                'Elige un número (0-5):',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(6, (index) {
                  return ElevatedButton(
                    onPressed: _userChoice != null
                        ? () => _playGame(index)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                    ),
                    child: Text(
                      '$index',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 30),

              // Sección de marcador
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Marcador',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text('Usuario'),
                              Text(
                                '$_userScore',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('CPU'),
                              Text(
                                '$_cpuScore',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Botón para reiniciar el juego
              OutlinedButton(
                onPressed: _resetGame,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Text('Reiniciar Juego'),
              ),

              // Sección de última jugada (solo visible después de jugar)
              if (_userNumber != null && _cpuNumber != null) ...[
                const SizedBox(height: 20),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Última jugada: Tú: $_userNumber, CPU: $_cpuNumber',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
