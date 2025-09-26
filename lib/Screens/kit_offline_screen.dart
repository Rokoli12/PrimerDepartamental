import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

// Pantalla del "Kit Offline" con accesos a módulos locales
class KitOfflineScreen extends StatelessWidget {
  const KitOfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: const Text('Kit Offline'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      drawer: const CustomDrawer(), // Menú lateral
      body: Container(
        // Fondo degradado verde
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Colors.lightGreen],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Cabecera de la pantalla
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.build, color: Colors.green, size: 24),
                    const SizedBox(width: 8),
                    const Text(
                      'Módulos Disponibles',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

              // Lista de módulos (cada uno con un acceso)
              Expanded(
                child: ListView(
                  children: [
                    _buildModuleItem(
                      context,
                      'Calculadora de IMC',
                      Icons.calculate,
                      Colors.blue,
                      '/calculadora',
                    ),
                    _buildModuleItem(
                      context,
                      'Notas Rápidas',
                      Icons.note_add,
                      Colors.orange,
                      '/notas',
                    ),
                    _buildModuleItem(
                      context,
                      'Galería Local',
                      Icons.photo_library,
                      Colors.purple,
                      '/galeria-local',
                    ),
                    _buildModuleItem(
                      context,
                      'Juego Par/Impar',
                      Icons.casino,
                      Colors.red,
                      '/par-impar',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método auxiliar para construir cada módulo en forma de ListTile
  Widget _buildModuleItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String route,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 2, // Sombra ligera
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.pushNamed(context, route), // Navegación
      ),
    );
  }
}
