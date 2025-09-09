import 'dart:math';
import 'package:flutter/material.dart';

class Practica5 extends StatefulWidget {
  const Practica5({super.key});

  @override
  State<Practica5> createState() => _Practica5State();
}

class _Practica5State extends State<Practica5> {
  int userScore = 0;
  int deviceScore = 0;
  String userChoice = '';
  String deviceChoice = '';
  String result = '¡Elige una opción!';
  final Color primaryColor = Colors.blueAccent;
  final Color secondaryColor = Colors.orangeAccent;

  void playRound(String choice) {
    List<String> options = ['Piedra', 'Papel', 'Tijera'];
    Random random = Random();
    String deviceSelection = options[random.nextInt(3)];

    String roundResult;

    if (choice == deviceSelection) {
      roundResult = '¡Empate!';
    } else if ((choice == 'Piedra' && deviceSelection == 'Tijera') ||
        (choice == 'Papel' && deviceSelection == 'Piedra') ||
        (choice == 'Tijera' && deviceSelection == 'Papel')) {
      roundResult = '¡Ganaste esta ronda!';
      userScore++;
    } else {
      roundResult = '¡El dispositivo ganó esta ronda!';
      deviceScore++;
    }

    setState(() {
      userChoice = choice;
      deviceChoice = deviceSelection;
      result = roundResult;
    });
  }

  void resetScore() {
    setState(() {
      userScore = 0;
      deviceScore = 0;
      userChoice = '';
      deviceChoice = '';
      result = '¡Marcador reiniciado!';
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Marcador
              Container(
                padding: const EdgeInsets.all(20),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Usuario',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$userScore',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 2,
                      height: 60,
                      color: Colors.grey.shade300,
                    ),
                    Column(
                      children: [
                        Text(
                          'Dispositivo',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$deviceScore',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Resultado
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  result,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Elecciones
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Tu elección:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userChoice,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Dispositivo:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          deviceChoice,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Botones de opciones
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  _buildGameButton('Piedra', Icons.landscape),
                  _buildGameButton('Papel', Icons.description),
                  _buildGameButton('Tijera', Icons.content_cut),
                ],
              ),

              // Botón de reinicio
              ElevatedButton(
                onPressed: resetScore,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Reiniciar Marcador',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameButton(String choice, IconData icon) {
    return ElevatedButton(
      onPressed: () => playRound(choice),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30),
          const SizedBox(height: 5),
          Text(choice, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
