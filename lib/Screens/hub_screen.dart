import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

// Pantalla principal (hub) donde se muestran accesos a las demás secciones del portafolio
class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Detecta si el dispositivo está en modo oscuro o claro
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      // Barra superior (AppBar)
      appBar: AppBar(
        title: const Text('Mi Portafolio Flutter'),
        centerTitle: true, // Centra el título
        backgroundColor: isDarkMode ? Colors.grey[900]! : Colors.blueAccent,
        foregroundColor: Colors.white, // Texto y botones en blanco
      ),
      drawer: const CustomDrawer(), // Menú lateral personalizado
      body: Container(
        // Fondo oscuro o degradado según el tema
        color: isDarkMode ? Colors.grey[900] : null,
        decoration: isDarkMode
            ? null
            : const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blueAccent, Colors.lightBlueAccent],
                ),
              ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Avatar con ícono de código
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.code, size: 30, color: Colors.blueAccent),
                ),
                const SizedBox(height: 8),
                // Título de bienvenida
                Text(
                  'Bienvenido al Portafolio',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                // Subtítulo
                Text(
                  'Explora mis prácticas y proyectos',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDarkMode ? Colors.white70 : Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Lista de accesos a las pantallas
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      // Cada tarjeta lleva a una ruta específica
                      _buildListCard(
                        context,
                        '🎓 Prácticas',
                        Icons.school,
                        Colors.blue,
                        'Todas las prácticas',
                        '/practicas',
                      ),
                      const SizedBox(height: 12),
                      _buildListCard(
                        context,
                        '🛠️ Kit Offline',
                        Icons.build,
                        Colors.green,
                        'Módulos útiles',
                        '/kit-offline',
                      ),
                      const SizedBox(height: 12),
                      _buildListCard(
                        context,
                        '⚖️ Calculadora de IMC',
                        Icons.monitor_weight,
                        Colors.teal,
                        'Calculadora de peso',
                        '/calculadora',
                      ),
                      const SizedBox(height: 12),
                      _buildListCard(
                        context,
                        '🎮 Juego Par/Impar',
                        Icons.casino,
                        Colors.orange,
                        'Juego divertido',
                        '/par-impar',
                      ),
                      const SizedBox(height: 12),
                      _buildListCard(
                        context,
                        '📱 Formulario',
                        Icons.assignment,
                        Colors.pink,
                        'Formulario práctico',
                        '/formulario',
                      ),
                      const SizedBox(height: 12),
                      _buildListCard(
                        context,
                        '⚙️ Ajustes',
                        Icons.settings,
                        Colors.grey,
                        'Configuración',
                        '/ajustes',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método auxiliar para construir cada tarjeta de la lista
  Widget _buildListCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String subtitle,
    String route,
  ) {
    return Card(
      elevation: 3, // Sombra
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // Degradado con el color principal
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [color.withOpacity(0.9), color],
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          // Acción al tocar: navegar a la ruta
          onTap: () => Navigator.pushNamed(context, route),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Icono circular
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 24, color: Colors.white),
                ),
                const SizedBox(width: 16),
                // Título + subtítulo
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                // Flecha a la derecha
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
