// Importación de paquetes y widgets necesarios
import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

// Definición de la clase StatefulWidget para la pantalla de calculadora
class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});

  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

// Clase State que maneja el estado de la calculadora
class _CalculadoraScreenState extends State<CalculadoraScreen> {
  // Controladores para los campos de texto (peso y altura)
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  // Variables de estado para almacenar resultados y clasificación
  String _resultado = '';
  String _clasificacion = '';
  Color _colorResultado = Colors.grey;

  // Método principal para calcular el IMC
  void _calcularIMC() {
    // Ocultar teclado para evitar problemas de overflow
    FocusScope.of(context).unfocus();

    // Validación de campos vacíos
    if (_pesoController.text.isEmpty || _alturaController.text.isEmpty) {
      _mostrarNotificacion('Por favor ingresa ambos valores', Colors.orange);
      _limpiarResultado();
      return;
    }

    try {
      // Conversión y validación de valores numéricos
      double peso = double.parse(_pesoController.text);
      double altura = double.parse(_alturaController.text);

      if (peso <= 0 || altura <= 0) {
        _mostrarNotificacion(
          'Los valores deben ser mayores a 0',
          Colors.orange,
        );
        _limpiarResultado();
        return;
      }

      // Conversión de altura de cm a metros si es necesario
      if (altura > 3) {
        altura = altura / 100;
      }

      // Cálculo del IMC
      double imc = peso / (altura * altura);

      setState(() {
        _resultado = 'IMC: ${imc.toStringAsFixed(1)}';

        // Lógica de clasificación según el IMC
        if (imc < 18.5) {
          _clasificacion = 'Bajo peso\n¡Necesitas comer más!';
          _colorResultado = Colors.orange;
          _mostrarNotificacion(
            'Tienes bajo peso. ¡Necesitas comer más!',
            Colors.orange,
          );
        } else if (imc < 25) {
          _clasificacion = 'Peso normal\n¡Estás bien!';
          _colorResultado = Colors.green;
          _mostrarNotificacion('¡Felicidades! Tu peso es normal', Colors.green);
        } else if (imc < 30) {
          _clasificacion = 'Sobrepeso\n¡Necesitas bajar de peso!';
          _colorResultado = Colors.orange;
          _mostrarNotificacion(
            'Tienes sobrepeso. ¡Necesitas bajar de peso!',
            Colors.orange,
          );
        } else {
          _clasificacion = 'Obesidad\n¡Necesitas bajar de peso urgentemente!';
          _colorResultado = Colors.red;
          _mostrarNotificacion(
            'Tienes obesidad. ¡Consulta a un médico!',
            Colors.red,
          );
        }
      });
    } catch (e) {
      // Manejo de errores en la entrada de datos
      _mostrarNotificacion('Error en los datos ingresados', Colors.red);
      _limpiarResultado();
    }
  }

  // Método para mostrar notificaciones tipo SnackBar
  void _mostrarNotificacion(String mensaje, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mensaje,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: color,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // Método para limpiar los resultados
  void _limpiarResultado() {
    setState(() {
      _resultado = '';
      _clasificacion = '';
      _colorResultado = Colors.grey;
    });
  }

  // Método para limpiar todos los campos
  void _limpiarCampos() {
    setState(() {
      _pesoController.clear();
      _alturaController.clear();
      _resultado = '';
      _clasificacion = '';
      _colorResultado = Colors.grey;
    });
    _mostrarNotificacion('Campos limpiados', Colors.blue);
  }

  // Método build principal que construye la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const CustomDrawer(), // Drawer personalizado
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Sección de icono decorativo
                      Icon(
                        Icons.monitor_weight,
                        size: 80,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(height: 20),

                      // Campo de entrada para el peso
                      TextField(
                        controller: _pesoController,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Peso (kg)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.fitness_center),
                          hintText: 'Ej: 70.5',
                        ),
                      ),
                      SizedBox(height: 15),

                      // Campo de entrada para la altura
                      TextField(
                        controller: _alturaController,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Altura (cm o m)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.height),
                          hintText: 'Ej: 1.75 o 175',
                        ),
                      ),
                      SizedBox(height: 25),

                      // Sección de botones (Calcular y Limpiar)
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _calcularIMC,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              icon: Icon(Icons.calculate, color: Colors.white),
                              label: Text(
                                'CALCULAR IMC',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _limpiarCampos,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              icon: Icon(Icons.clear, color: Colors.white),
                              label: Text(
                                'LIMPIAR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Sección de visualización de resultados
                      if (_resultado.isNotEmpty)
                        Card(
                          color: _colorResultado.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Text(
                                  _resultado,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: _colorResultado,
                                  ),
                                ),
                                if (_clasificacion.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      _clasificacion,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: _colorResultado,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                      // Espaciado condicional
                      if (_resultado.isEmpty) SizedBox(height: 20),

                      // Sección informativa sobre clasificación OMS (ocupa espacio restante)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Clasificación OMS:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    // Items de información sobre clasificación
                                    _buildInfoItem(
                                      'Bajo peso',
                                      'IMC < 18.5',
                                      Colors.orange,
                                    ),
                                    _buildInfoItem(
                                      'Normal',
                                      'IMC 18.5 - 24.9',
                                      Colors.green,
                                    ),
                                    _buildInfoItem(
                                      'Sobrepeso',
                                      'IMC 25 - 29.9',
                                      Colors.orange,
                                    ),
                                    _buildInfoItem(
                                      'Obesidad',
                                      'IMC ≥ 30',
                                      Colors.red,
                                    ),
                                  ],
                                ),
                              ),
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
        },
      ),
    );
  }

  // Método auxiliar para construir items de información
  Widget _buildInfoItem(String titulo, String rango, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
                Text(
                  rango,
                  style: TextStyle(fontSize: 12, color: color.withOpacity(0.8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Método dispose para liberar recursos
  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }
}
