// Importación de paquetes y widgets necesarios
import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

// Pantalla de formulario de registro con validación y almacenamiento de datos
class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

// Clase State que maneja el estado del formulario
class _FormularioState extends State<Formulario> {
  // Clave global para manejar la validación del formulario
  final _formKey = GlobalKey<FormState>();

  // Lista para almacenar todos los registros del formulario
  final List<Map<String, dynamic>> _registros = [];

  // Controladores para los campos de texto del formulario
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();

  // Variables de estado para los campos de selección
  String _generoSeleccionado = ''; // Género seleccionado (Masculino/Femenino)
  String _nivelEducativo = ''; // Nivel educativo seleccionado
  bool _aceptaTerminos = false; // Aceptación de términos y condiciones
  DateTime? _fechaNacimiento; // Fecha de nacimiento seleccionada

  // Método dispose para liberar recursos de los controladores
  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  // Método principal para enviar el formulario con validación
  void _enviarFormulario() {
    if (_formKey.currentState!.validate() && _aceptaTerminos) {
      // Crear nuevo registro con todos los datos del formulario
      final nuevoRegistro = {
        'nombre': _nombreController.text,
        'email': _emailController.text,
        'telefono': _telefonoController.text,
        'edad': _edadController.text,
        'genero': _generoSeleccionado,
        'educacion': _nivelEducativo,
        'fechaNacimiento': _fechaNacimiento,
        'fechaRegistro': DateTime.now(), // Fecha y hora actual
      };

      // Agregar el nuevo registro a la lista (al inicio)
      setState(() {
        _registros.insert(0, nuevoRegistro);
      });

      // Mostrar diálogo de éxito
      _mostrarDialogoExito();

      // Limpiar formulario para nuevo registro
      _limpiarFormulario();
    } else if (!_aceptaTerminos) {
      // Mostrar error si no se aceptan los términos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes aceptar los términos y condiciones'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Método para limpiar todos los campos del formulario
  void _limpiarFormulario() {
    _formKey.currentState!.reset();
    _nombreController.clear();
    _emailController.clear();
    _telefonoController.clear();
    _edadController.clear();
    setState(() {
      _generoSeleccionado = '';
      _nivelEducativo = '';
      _aceptaTerminos = false;
      _fechaNacimiento = null;
    });
  }

  // Método para mostrar diálogo de éxito al enviar el formulario
  void _mostrarDialogoExito() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 10),
            Text('¡Formulario Enviado!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${_nombreController.text}'),
            Text('Email: ${_emailController.text}'),
            Text('Teléfono: ${_telefonoController.text}'),
            const SizedBox(height: 10),
            const Text('Los datos han sido guardados correctamente.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  // Método para seleccionar fecha de nacimiento usando DatePicker
  Future<void> _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Fecha mínima permitida
      lastDate: DateTime.now(), // Fecha máxima (hoy)
    );
    if (picked != null && picked != _fechaNacimiento) {
      setState(() {
        _fechaNacimiento = picked;
      });
    }
  }

  // Método para mostrar todos los registros en un BottomSheet
  void _mostrarRegistros() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permite scroll si hay muchos registros
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.8, // 80% de la pantalla
        child: Column(
          children: [
            const Text(
              'Registros Guardados',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Total: ${_registros.length} registros',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _registros.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.list, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('No hay registros guardados'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _registros.length,
                      itemBuilder: (context, index) {
                        final registro = _registros[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Text('${index + 1}'), // Número de registro
                            ),
                            title: Text(registro['nombre']),
                            subtitle: Text(registro['email']),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _eliminarRegistro(index),
                            ),
                            onTap: () => _mostrarDetallesRegistro(registro),
                          ),
                        );
                      },
                    ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        ),
      ),
    );
  }

  // Método para eliminar un registro específico con confirmación
  void _eliminarRegistro(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Registro'),
        content: const Text(
          '¿Estás seguro de que quieres eliminar este registro?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _registros.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registro eliminado')),
              );
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Método para mostrar detalles completos de un registro
  void _mostrarDetallesRegistro(Map<String, dynamic> registro) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detalles del Registro'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetalleItem('Nombre', registro['nombre']),
              _buildDetalleItem('Email', registro['email']),
              _buildDetalleItem('Teléfono', registro['telefono']),
              _buildDetalleItem('Edad', registro['edad']),
              _buildDetalleItem('Género', registro['genero']),
              _buildDetalleItem('Educación', registro['educacion']),
              if (registro['fechaNacimiento'] != null)
                _buildDetalleItem(
                  'Fecha Nacimiento',
                  _formatearFecha(registro['fechaNacimiento']),
                ),
              _buildDetalleItem(
                'Fecha Registro',
                _formatearFecha(registro['fechaRegistro']),
              ),
            ],
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

  // Método auxiliar para construir items de detalles
  Widget _buildDetalleItem(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$titulo: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(valor.isEmpty ? 'No especificado' : valor)),
        ],
      ),
    );
  }

  // Método para formatear fechas en formato día/mes/año
  String _formatearFecha(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year}';
  }

  // Método build principal que construye la interfaz del formulario
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Registro'),
        centerTitle: true,
        actions: [
          // Botón para ver todos los registros guardados
          IconButton(
            icon: const Icon(Icons.list_alt),
            onPressed: _mostrarRegistros,
            tooltip: 'Ver registros',
          ),
        ],
      ),
      drawer: const CustomDrawer(), // Menú lateral personalizado
      body: Container(
        // Fondo con gradiente decorativo
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Clave para validación del formulario
            child: ListView(
              children: [
                // ENCABEZADO DEL FORMULARIO
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.assignment,
                        size: 50,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Formulario de Registro',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Complete todos los campos obligatorios',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),

                // CAMPO: Nombre Completo (obligatorio)
                _buildTextField(
                  controller: _nombreController,
                  label: 'Nombre Completo *',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su nombre';
                    }
                    if (value.length < 3) {
                      return 'El nombre debe tener al menos 3 caracteres';
                    }
                    return null;
                  },
                ),

                // CAMPO: Correo Electrónico (obligatorio)
                _buildTextField(
                  controller: _emailController,
                  label: 'Correo Electrónico *',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su email';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Ingrese un email válido';
                    }
                    return null;
                  },
                ),

                // CAMPO: Teléfono (obligatorio)
                _buildTextField(
                  controller: _telefonoController,
                  label: 'Teléfono *',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su teléfono';
                    }
                    if (value.length < 10) {
                      return 'El teléfono debe tener al menos 10 dígitos';
                    }
                    return null;
                  },
                ),

                // CAMPO: Edad (obligatorio)
                _buildTextField(
                  controller: _edadController,
                  label: 'Edad *',
                  icon: Icons.cake,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su edad';
                    }
                    final edad = int.tryParse(value);
                    if (edad == null || edad < 1 || edad > 120) {
                      return 'Ingrese una edad válida (1-120)';
                    }
                    return null;
                  },
                ),

                // SELECTOR: Género (obligatorio) - Radio buttons
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Género *',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Masculino'),
                              value: 'Masculino',
                              groupValue: _generoSeleccionado,
                              onChanged: (value) {
                                setState(() {
                                  _generoSeleccionado = value!;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Femenino'),
                              value: 'Femenino',
                              groupValue: _generoSeleccionado,
                              onChanged: (value) {
                                setState(() {
                                  _generoSeleccionado = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      // Mensaje de error si no se selecciona género
                      if (_generoSeleccionado.isEmpty)
                        const Text(
                          'Seleccione una opción',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                    ],
                  ),
                ),

                // SELECTOR: Nivel Educativo (obligatorio) - Dropdown
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonFormField<String>(
                    initialValue: _nivelEducativo.isEmpty
                        ? null
                        : _nivelEducativo,
                    decoration: const InputDecoration(
                      labelText: 'Nivel Educativo *',
                      border: InputBorder.none,
                    ),
                    items:
                        [
                          'Primaria',
                          'Secundaria',
                          'Bachillerato',
                          'Universidad',
                          'Posgrado',
                          'Otro',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _nivelEducativo = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Seleccione su nivel educativo';
                      }
                      return null;
                    },
                  ),
                ),

                // SELECTOR: Fecha de Nacimiento (opcional)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Fecha de Nacimiento',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: _seleccionarFecha,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 20),
                              const SizedBox(width: 10),
                              Text(
                                _fechaNacimiento != null
                                    ? _formatearFecha(_fechaNacimiento!)
                                    : 'Seleccionar fecha',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // CHECKBOX: Términos y Condiciones (obligatorio)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _aceptaTerminos,
                        onChanged: (bool? value) {
                          setState(() {
                            _aceptaTerminos = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _aceptaTerminos = !_aceptaTerminos;
                            });
                          },
                          child: const Text(
                            'Acepto los términos y condiciones *',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // BOTONES DE ACCIÓN: Limpiar y Enviar
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _limpiarFormulario,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text('Limpiar'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _enviarFormulario,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text('Enviar Formulario'),
                      ),
                    ),
                  ],
                ),

                // CONTADOR DE REGISTROS (solo visible si hay registros)
                if (_registros.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.save, color: Colors.blueAccent),
                        const SizedBox(width: 8),
                        Text(
                          'Registros guardados: ${_registros.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
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
  }

  // Método auxiliar para construir campos de texto con validación
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: validator, // Función de validación personalizada
      ),
    );
  }
}
