// Importación de paquetes y widgets necesarios
import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

// Definición de la clase StatefulWidget para la galería local
class GaleriaLocalScreen extends StatefulWidget {
  const GaleriaLocalScreen({super.key});

  @override
  State<GaleriaLocalScreen> createState() => _GaleriaLocalScreenState();
}

// Clase State que maneja el estado de la galería
class _GaleriaLocalScreenState extends State<GaleriaLocalScreen> {
  // Lista de imágenes con sus títulos y rutas
  final List<Map<String, String>> images = [
    {'title': 'Leon', 'path': 'assets/images/leon.jpg'},
    {'title': 'Claire', 'path': 'assets/images/clare.jpg'},
    {'title': 'Chris', 'path': 'assets/images/cris.jpg'},
    {'title': 'Ada', 'path': 'assets/images/ada.jpg'},
    {'title': 'Sherry', 'path': 'assets/images/sherryb.jpg'},
    {'title': 'Jill', 'path': 'assets/images/jill.jpg'},
  ];

  // Método para mostrar diálogo con imagen ampliada
  void _showImageDialog(Map<String, String> image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(image['title']!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Widget de imagen con manejo de errores
              Image.asset(
                image['path']!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey[300],
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 40, color: Colors.red),
                        SizedBox(height: 8),
                        Text(
                          'Error cargando imagen',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(image['title']!, style: const TextStyle(fontSize: 16)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  // Método build principal que construye la interfaz de la galería
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galería Local'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      drawer: const CustomDrawer(), // Drawer personalizado
      body: Container(
        // Fondo con gradiente decorativo
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.deepPurple],
          ),
        ),
        // GridView para mostrar imágenes en formato de cuadrícula
        child: GridView.count(
          crossAxisCount: 2, // 2 columnas
          padding: const EdgeInsets.all(16.0),
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: images.map((image) {
            return GestureDetector(
              onTap: () => _showImageDialog(image), // Al tocar muestra diálogo
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    // Contenedor de imagen expandible
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                        child: Image.asset(
                          image['path']!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Manejo de errores para imágenes no encontradas
                            return Container(
                              color: Colors.grey[200],
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.broken_image,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Imagen no encontrada',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Título de la imagen
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        image['title']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
