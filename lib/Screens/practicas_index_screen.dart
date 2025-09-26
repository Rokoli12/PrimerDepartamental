import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

// Modelo de datos para representar una práctica
class Practica {
  final String title; // Título de la práctica
  final String description; // Descripción corta
  final IconData icon; // Ícono representativo
  final Color color; // Color principal
  final String route; // Ruta para navegar

  const Practica({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
  });
}

// Pantalla índice de prácticas
class PracticasIndexScreen extends StatelessWidget {
  const PracticasIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Índice de Prácticas'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      drawer: const CustomDrawer(),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Cabecera superior
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                children: [
                  Icon(Icons.list, color: Colors.blueAccent, size: 30),
                  SizedBox(width: 10),
                  Text(
                    'Índice de Prácticas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),

            // Lista de prácticas
            Expanded(
              child: ListView(
                children: [
                  _buildSectionHeader('Mis Prácticas'),
                  ..._practicas.map(
                    (practica) => _buildPracticeItem(practica, context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Encabezado de sección
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 2.0,
              color: Colors.black45,
              offset: Offset(1.0, 1.0),
            ),
          ],
        ),
      ),
    );
  }

  // Ítem de cada práctica
  Widget _buildPracticeItem(Practica practica, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 3,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: practica.color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(practica.icon, color: practica.color),
        ),
        title: Text(
          practica.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(practica.description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        // Navega a la ruta asociada
        onTap: () => Navigator.pushNamed(context, practica.route),
      ),
    );
  }

  // Lista estática de prácticas disponibles
  static const List<Practica> _practicas = [
    Practica(
      title: 'Práctica 3 - Hola Mundo',
      description: '10 mensajes Hola Mundo interactivos',
      icon: Icons.text_format,
      color: Colors.blue,
      route: '/practica3',
    ),
    Practica(
      title: 'Práctica 4 - Contador Dinámico',
      description: 'Generador de Hola Mundo con contador',
      icon: Icons.list_alt,
      color: Colors.green,
      route: '/practica4',
    ),
    Practica(
      title: 'Práctica 5 - Piedra, Papel, Tijera',
      description: 'Juego interactivo contra el dispositivo',
      icon: Icons.sports_esports,
      color: Colors.orange,
      route: '/practica5',
    ),
    Practica(
      title: 'Formulario de Práctica',
      description: 'Ejemplo de formulario con validaciones',
      icon: Icons.assignment,
      color: Colors.purple,
      route: '/formulario',
    ),
  ];
}
