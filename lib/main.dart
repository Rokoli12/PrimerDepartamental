// Importación de paquetes de Flutter
import 'package:flutter/material.dart';

// Importación de todas las pantallas y módulos de la aplicación
import 'package:flutter_application_1/Screens/ajustes_screen.dart';
import 'package:flutter_application_1/Screens/hub_screen.dart';
import 'package:flutter_application_1/Screens/kit_offline_screen.dart';
import 'package:flutter_application_1/Screens/practicas_index_screen.dart';
import 'package:flutter_application_1/Screens/practica3.dart';
import 'package:flutter_application_1/Screens/practica4.dart';
import 'package:flutter_application_1/Screens/practica5.dart';
import 'package:flutter_application_1/Screens/Formulario.dart';

// Importación de los módulos del Kit Offline
import 'package:flutter_application_1/Modules/calculadora_screen.dart';
import 'package:flutter_application_1/Modules/notas_screen.dart';
import 'package:flutter_application_1/Modules/galeria_local_screen.dart'; // NUEVO MÓDULO
import 'package:flutter_application_1/Modules/par_impar_screen.dart'; // NUEVO MÓDULO

// Función principal que inicia la aplicación
void main() {
  runApp(const MyApp());
}

// Clase principal de la aplicación que extiende StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Portafolio Flutter', // Título de la aplicación
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ), // Tema principal
      initialRoute: '/', // Ruta inicial de la aplicación
      // DEFINICIÓN DE RUTAS - Mapeo de nombres de ruta a widgets
      routes: {
        // Ruta principal - Pantalla de inicio (Hub)
        '/': (context) => const HubScreen(),

        // RUTAS DE CONFIGURACIÓN Y NAVEGACIÓN
        '/ajustes': (context) => const AjustesScreen(),
        '/kit-offline': (context) => const KitOfflineScreen(),

        // RUTAS DE PRÁCTICAS
        '/practicas': (context) => const PracticasIndexScreen(),
        '/practica3': (context) => const Practica3(),
        '/practica4': (context) => const Practica4(),
        '/practica5': (context) => const Practica5(),
        '/formulario': (context) => const Formulario(),

        // RUTAS DE MÓDULOS DEL KIT OFFLINE
        '/calculadora': (context) => const CalculadoraScreen(),
        '/notas': (context) => const NotasScreen(),
        '/galeria-local': (context) => const GaleriaLocalScreen(), // NUEVA RUTA
        '/par-impar': (context) => const ParImparScreen(), // NUEVA RUTA
      },

      debugShowCheckedModeBanner: false, // Oculta la etiqueta de debug
    );
  }
}
