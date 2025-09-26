// Importación de paquetes de Flutter
import 'package:flutter/material.dart';

// Widget personalizado para el menú lateral (Drawer)
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Detección del modo oscuro del sistema
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Drawer(
      child: Container(
        // Fondo condicional según el modo (oscuro/claro)
        color: isDarkMode ? Colors.grey[900] : null,
        decoration: isDarkMode
            ? null
            : const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blueAccent, Colors.lightBlueAccent],
                ),
              ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // CABECERA DEL DRAWER - Con diseño mejorado
            Container(
              height: 150, // Altura reducida para mejor proporción
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800]! : Colors.blueAccent,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icono circular de la aplicación
                  Container(
                    width: 50, // Tamaño reducido
                    height: 50, // Tamaño reducido
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[700]! : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.folder_special,
                      size: 30, // Tamaño reducido
                      color: isDarkMode ? Colors.white : Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 10), // Espaciado reducido
                  // Título de la aplicación
                  const Text(
                    'Mi Portafolio Flutter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16, // Tamaño de fuente reducido
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4), // Espaciado reducido
                  // Versión de la aplicación
                  Text(
                    'Versión 2.0',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 11, // Tamaño de fuente reducido
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),

            // SECCIÓN: Navegación Principal
            _buildSectionTitle('Navegación Principal'),
            _buildDrawerItem(context, Icons.home, 'Inicio (Hub)', '/', 0),
            Divider(
              color: isDarkMode ? Colors.white24 : Colors.white54,
              height: 1,
            ),

            // SECCIÓN: Mis Prácticas
            _buildSectionTitle('Mis Prácticas'),
            _buildDrawerItem(
              context,
              Icons.school,
              'Índice de Prácticas',
              '/practicas',
              1,
            ),
            _buildDrawerItem(
              context,
              Icons.text_format,
              'Práctica 3 - Hola Mundo',
              '/practica3',
              2,
            ),
            _buildDrawerItem(
              context,
              Icons.list_alt,
              'Práctica 4 - Contador',
              '/practica4',
              3,
            ),
            _buildDrawerItem(
              context,
              Icons.sports_esports,
              'Práctica 5 - Piedra Papel Tijera',
              '/practica5',
              4,
            ),
            _buildDrawerItem(
              context,
              Icons.assignment,
              'Formulario de Práctica',
              '/formulario',
              5,
            ),
            Divider(
              color: isDarkMode ? Colors.white24 : Colors.white54,
              height: 1,
            ),

            // SECCIÓN: Kit Offline
            _buildSectionTitle('Kit Offline'),
            _buildDrawerItem(
              context,
              Icons.build,
              'Módulos del Kit',
              '/kit-offline',
              6,
            ),
            _buildDrawerItem(
              context,
              Icons.calculate,
              'Calculadora de IMC',
              '/calculadora',
              7,
            ),
            _buildDrawerItem(
              context,
              Icons.note_add,
              'Notas Rápidas',
              '/notas',
              8,
            ),
            _buildDrawerItem(
              context,
              Icons.photo_library,
              'Galería Local',
              '/galeria-local',
              9,
            ),
            _buildDrawerItem(
              context,
              Icons.casino,
              'Juego Par/Impar',
              '/par-impar',
              10,
            ),
            Divider(
              color: isDarkMode ? Colors.white24 : Colors.white54,
              height: 1,
            ),

            // SECCIÓN: Configuración
            _buildSectionTitle('Configuración'),
            _buildDrawerItem(
              context,
              Icons.settings,
              'Ajustes',
              '/ajustes',
              11,
            ),

            // FOOTER DEL DRAWER - Información del desarrollador
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: const Row(
                children: [
                  Icon(Icons.code, size: 16, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Desarrollado con Flutter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Por: Joshep Rafael Estrada Salinas',
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método auxiliar para construir títulos de sección
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8), // Padding reducido
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Método auxiliar para construir items del menú
  Widget _buildDrawerItem(
    BuildContext context,
    IconData icon,
    String title,
    String route,
    int index,
  ) {
    // Detección de la ruta actual para resaltar el item activo
    final currentRoute = ModalRoute.of(context)?.settings.name;
    bool isCurrentRoute =
        currentRoute == route ||
        (route == '/' && currentRoute == null) ||
        (route == '/' && currentRoute == '/');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isCurrentRoute
            ? Colors.white.withOpacity(0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 36, // Tamaño reducido
          height: 36, // Tamaño reducido
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 18), // Tamaño reducido
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13, // Tamaño de fuente reducido
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 3,
          ), // Padding reducido
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.arrow_forward_ios,
            size: 12, // Tamaño reducido
            color: Colors.white54,
          ),
        ),
        onTap: () {
          // Cerrar drawer y navegar después de un pequeño delay
          Navigator.pop(context);
          if (!isCurrentRoute) {
            Future.delayed(const Duration(milliseconds: 100), () {
              Navigator.pushNamed(context, route);
            });
          }
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        dense: true, // Hace el item más compacto
      ),
    );
  }
}
