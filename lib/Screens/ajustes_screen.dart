// Importación de paquetes y widgets necesarios
import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

// Pantalla de configuración y ajustes de la aplicación
class AjustesScreen extends StatefulWidget {
  const AjustesScreen({super.key});

  @override
  State<AjustesScreen> createState() => _AjustesScreenState();
}

// Clase State que maneja el estado de la pantalla de ajustes
class _AjustesScreenState extends State<AjustesScreen> {
  // Variables de estado para las preferencias del usuario
  bool _notificaciones =
      true; // Estado de las notificaciones (activado/desactivado)
  String _temaSeleccionado =
      'Sistema'; // Tema seleccionado (Claro/Oscuro/Sistema)

  @override
  Widget build(BuildContext context) {
    // Detección del modo oscuro del sistema para adaptar la interfaz
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes y Configuración'),
        centerTitle: true,
        backgroundColor: isDarkMode ? Colors.grey[900]! : Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      drawer: const CustomDrawer(), // Menú lateral personalizado
      body: Container(
        // Fondo condicional: gradiente en modo claro, color sólido en oscuro
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
        child: Column(
          children: [
            // Encabezado de la sección de configuración
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800]! : Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.settings, color: Colors.blueAccent, size: 30),
                  const SizedBox(width: 10),
                  Text(
                    'Configuración',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),

            // Contenido principal de ajustes en una tarjeta desplazable
            Expanded(
              child: Card(
                margin: const EdgeInsets.all(16),
                color: isDarkMode ? Colors.grey[800]! : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      // Configuración de tema de la aplicación
                      ListTile(
                        leading: Icon(
                          Icons.color_lens,
                          color: Colors.blueAccent,
                        ),
                        title: Text(
                          'Tema de la aplicación',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: DropdownButton<String>(
                          value: _temaSeleccionado,
                          onChanged: (String? newValue) {
                            setState(() {
                              _temaSeleccionado = newValue!;
                            });
                            _mostrarSnackbar('Tema cambiado a $newValue');
                          },
                          items: <String>['Claro', 'Oscuro', 'Sistema']
                              .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              })
                              .toList(),
                        ),
                      ),
                      const Divider(), // Separador visual
                      // Configuración de notificaciones
                      ListTile(
                        leading: Icon(
                          Icons.notifications,
                          color: Colors.blueAccent,
                        ),
                        title: Text(
                          'Notificaciones',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: Switch(
                          value: _notificaciones,
                          activeThumbColor: Colors.blueAccent,
                          onChanged: (bool value) {
                            setState(() {
                              _notificaciones = value;
                            });
                            _mostrarSnackbar(
                              'Notificaciones ${value ? 'activadas' : 'desactivadas'}',
                            );
                          },
                        ),
                      ),
                      const Divider(), // Separador visual
                      // Información acerca de la aplicación
                      ListTile(
                        leading: Icon(Icons.info, color: Colors.blueAccent),
                        title: Text(
                          'Acerca de la aplicación',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Portafolio Flutter v2.0\nDesarrollado con Flutter',
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.white70
                                  : Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para mostrar notificaciones temporales (SnackBar)
  void _mostrarSnackbar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), duration: const Duration(seconds: 2)),
    );
  }
}
