import 'package:flutter/material.dart';
import 'package:flutter_application_1/Formulario.dart';
import 'practica3.dart';
import 'practica4.dart';
import 'practica5.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prácticas Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  // Lista de pantallas/páginas
  final List<Widget> _pages = [
    const HomeScreen(),
    const Practica3(),
    const Practica4(),
    const Formulario(),
    const Practica5(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prácticas Flutter',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.blueAccent.withOpacity(0.3),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.code, size: 40, color: Colors.white),
                    const SizedBox(height: 10),
                    const Text(
                      'Menú de Prácticas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Versión 1.0',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(0, Icons.home, 'Inicio'),
              const Divider(color: Colors.white54, height: 1),
              _buildDrawerItem(1, Icons.text_format, 'Práctica 3'),
              _buildDrawerItem(2, Icons.list, 'Práctica 4'),
              _buildDrawerItem(3, Icons.assignment, 'Formulario'),
              const Divider(color: Colors.white54, height: 1),
              _buildDrawerItem(
                4,
                Icons.sports_esports,
                'Piedra, Papel o Tijera',
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

  Widget _buildDrawerItem(int index, IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _selectedIndex == index
            ? Colors.white.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: _selectedIndex == index ? Colors.white : Colors.white70,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: _selectedIndex == index
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
        selected: _selectedIndex == index,
        onTap: () => _onItemTapped(index),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.code, size: 80, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                'Bienvenido a las Prácticas Flutter',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Explora las diferentes prácticas desarrolladas con Flutter. Usa el menú lateral para navegar entre ellas.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Abrir Menú',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
