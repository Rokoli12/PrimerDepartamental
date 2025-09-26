import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

// Pantalla principal de la Práctica 5
class Practica5 extends StatefulWidget {
  const Practica5({super.key});

  @override
  State<Practica5> createState() => _Practica5State();
}

class _Practica5State extends State<Practica5> {
  // Variables de puntajes y resultados
  int userScore = 0;
  int deviceScore = 0;
  int draws = 0;
  String userChoice = '';
  String deviceChoice = '';
  String result = '¡Elige una opción para comenzar!';

  // Colores personalizados
  final Color primaryColor = Colors.blueAccent;
  final Color secondaryColor = Colors.orangeAccent;

  // Lista para guardar historial de partidas
  final List<Map<String, dynamic>> _historial = [];

  // Método que maneja la lógica de cada ronda
  void playRound(String choice) {
    // Opciones posibles
    List<String> options = ['Piedra', 'Papel', 'Tijera'];
    Random random = Random();
    String deviceSelection = options[random.nextInt(3)];

    String roundResult;
    String resultType;

    // Condiciones de victoria, empate o derrota
    if (choice == deviceSelection) {
      roundResult = '¡Empate!';
      resultType = 'draw';
      draws++;
    } else if ((choice == 'Piedra' && deviceSelection == 'Tijera') ||
        (choice == 'Papel' && deviceSelection == 'Piedra') ||
        (choice == 'Tijera' && deviceSelection == 'Papel')) {
      roundResult = '¡Ganaste esta ronda! 🎉';
      resultType = 'win';
      userScore++;
    } else {
      roundResult = '¡El dispositivo ganó esta ronda! 🤖';
      resultType = 'lose';
      deviceScore++;
    }

    // Guardar partida en el historial
    _historial.insert(0, {
      'userChoice': choice,
      'deviceChoice': deviceSelection,
      'result': roundResult,
      'type': resultType,
      'timestamp': DateTime.now(),
    });

    // Mantener máximo 10 elementos en historial
    if (_historial.length > 10) {
      _historial.removeLast();
    }

    // Actualizar estado de la pantalla
    setState(() {
      userChoice = choice;
      deviceChoice = deviceSelection;
      result = roundResult;
    });
  }

  // Reiniciar marcador con confirmación
  void resetScore() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reiniciar Marcador'),
        content: const Text(
          '¿Estás seguro de que quieres reiniciar el marcador?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                userScore = 0;
                deviceScore = 0;
                draws = 0;
                userChoice = '';
                deviceChoice = '';
                result = '¡Marcador reiniciado!';
                _historial.clear();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Marcador reiniciado'),
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

  // Mostrar historial en un cuadro de diálogo
  void _mostrarHistorial() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Historial de Partidas'),
        content: SizedBox(
          width: double.maxFinite,
          child: _historial.isEmpty
              ? const Center(child: Text('No hay partidas jugadas aún'))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _historial.length,
                  itemBuilder: (context, index) {
                    final partida = _historial[index];
                    return ListTile(
                      leading: _getResultIcon(partida['type']),
                      title: Text(
                        'Tú: ${partida['userChoice']} vs '
                        'Dispositivo: ${partida['deviceChoice']}',
                      ),
                      subtitle: Text(
                        partida['result'],
                        style: TextStyle(
                          color: _getResultColor(partida['type']),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        _formatearTiempo(partida['timestamp']),
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  // Devuelve ícono según el tipo de resultado
  Icon _getResultIcon(String type) {
    switch (type) {
      case 'win':
        return const Icon(Icons.emoji_events, color: Colors.green);
      case 'lose':
        return const Icon(Icons.computer, color: Colors.orange);
      default:
        return const Icon(Icons.handshake, color: Colors.blue);
    }
  }

  // Devuelve color según el resultado
  Color _getResultColor(String type) {
    switch (type) {
      case 'win':
        return Colors.green;
      case 'lose':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  // Formatea el tiempo de la jugada en modo "hace X minutos"
  String _formatearTiempo(DateTime timestamp) {
    final ahora = DateTime.now();
    final diferencia = ahora.difference(timestamp);

    if (diferencia.inMinutes < 1) return 'Ahora';
    if (diferencia.inHours < 1) return 'Hace ${diferencia.inMinutes}m';
    if (diferencia.inDays < 1) return 'Hace ${diferencia.inHours}h';
    return 'Hace ${diferencia.inDays}d';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica 5 - Piedra, Papel o Tijera'),
        centerTitle: true,
        actions: [
          if (_historial.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: _mostrarHistorial,
              tooltip: 'Ver historial',
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetScore,
            tooltip: 'Reiniciar marcador',
          ),
        ],
      ),
      drawer: const CustomDrawer(),
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
              // Encabezado
              Container(
                padding: const EdgeInsets.all(20),
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
                child: const Column(
                  children: [
                    Icon(
                      Icons.sports_esports,
                      size: 50,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Piedra, Papel o Tijera',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Juega contra el dispositivo',
                      style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),

              // Marcador
              Container(
                padding: const EdgeInsets.all(20),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildScoreCard(
                          'Jugador',
                          userScore,
                          Icons.person,
                          primaryColor,
                        ),
                        _buildScoreCard(
                          'Empates',
                          draws,
                          Icons.handshake,
                          Colors.grey,
                        ),
                        _buildScoreCard(
                          'Dispositivo',
                          deviceScore,
                          Icons.computer,
                          secondaryColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: (userScore + deviceScore) > 0
                          ? userScore / (userScore + deviceScore)
                          : 0.5,
                      backgroundColor: secondaryColor.withOpacity(0.3),
                      color: primaryColor,
                    ),
                  ],
                ),
              ),

              // Resultado de la ronda
              Container(
                padding: const EdgeInsets.all(20),
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
                  children: [
                    Text(
                      result,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    if (userChoice.isNotEmpty && deviceChoice.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildChoiceCard(
                            'Tu elección',
                            userChoice,
                            primaryColor,
                          ),
                          _buildChoiceCard(
                            'Dispositivo',
                            deviceChoice,
                            secondaryColor,
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
                alignment: WrapAlignment.center,
                children: [
                  _buildGameButton('Piedra', Icons.landscape, '✊'),
                  _buildGameButton('Papel', Icons.description, '✋'),
                  _buildGameButton('Tijera', Icons.content_cut, '✌️'),
                ],
              ),

              // Botones de acción
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: resetScore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reiniciar'),
                  ),
                  if (_historial.isNotEmpty)
                    ElevatedButton.icon(
                      onPressed: _mostrarHistorial,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      icon: const Icon(Icons.history),
                      label: Text('Historial (${_historial.length})'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Construye tarjeta para puntajes
  Widget _buildScoreCard(String title, int score, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          score.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  // Tarjeta que muestra la elección del jugador o dispositivo
  Widget _buildChoiceCard(String title, String choice, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            choice,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  // Botones para jugar (Piedra, Papel, Tijera)
  Widget _buildGameButton(String choice, IconData icon, String emoji) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        onPressed: () => playRound(choice),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 5),
            Icon(icon, size: 20),
            const SizedBox(height: 5),
            Text(
              choice,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
