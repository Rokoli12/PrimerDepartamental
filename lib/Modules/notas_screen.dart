// Importación de paquetes y widgets necesarios
import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

// Definición de la clase StatefulWidget para la pantalla de notas
class NotasScreen extends StatefulWidget {
  const NotasScreen({super.key});

  @override
  State<NotasScreen> createState() => _NotasScreenState();
}

// Clase State que maneja el estado de las notas
class _NotasScreenState extends State<NotasScreen> {
  // Lista para almacenar las notas
  final List<String> _notas = [];
  // Controlador para el campo de texto de nueva nota
  final TextEditingController _controller = TextEditingController();

  // Método para agregar una nueva nota
  void _agregarNota() {
    final String texto = _controller.text.trim();
    if (texto.isNotEmpty) {
      setState(() {
        _notas.add(texto);
        _controller.clear();
      });

      // Notificación de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Nota agregada correctamente'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(label: 'OK', onPressed: () {}),
        ),
      );
    }
  }

  // Método para borrar todas las notas con confirmación
  void _borrarTodasLasNotas() {
    if (_notas.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Borrar todas las notas'),
            content: const Text(
              '¿Estás seguro de que quieres borrar todas las notas? Esta acción no se puede deshacer.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _notas.clear();
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Todas las notas han sido borradas'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text(
                  'Borrar todo',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay notas para borrar'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Método para borrar una nota individual
  void _borrarNota(int index) {
    setState(() {
      _notas.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nota eliminada'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Método build principal que construye la interfaz de notas
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas Rápidas'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          // Botón para borrar todas las notas
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _borrarTodasLasNotas,
            tooltip: 'Borrar todas las notas',
          ),
        ],
      ),
      drawer: const CustomDrawer(), // Drawer personalizado
      body: Container(
        // Fondo con gradiente decorativo
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange, Colors.orangeAccent],
          ),
        ),
        child: Column(
          children: [
            // Sección de contador de notas
            Container(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Total de notas',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            _notas.length.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      const VerticalDivider(),
                      Column(
                        children: [
                          const Text(
                            'Estado',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            _notas.isEmpty ? 'Vacío' : 'Activo',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _notas.isEmpty
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Lista de notas o mensaje de lista vacía
            Expanded(
              child: _notas.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.note_add, size: 64, color: Colors.white54),
                          SizedBox(height: 16),
                          Text(
                            'No hay notas aún\n¡Agrega tu primera nota!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _notas.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          elevation: 2,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.orange.withOpacity(0.2),
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                            title: Text(
                              _notas[index],
                              style: const TextStyle(fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _borrarNota(index),
                              tooltip: 'Eliminar nota',
                            ),
                            onTap: () =>
                                _mostrarDialogoEditar(index), // Editar al tocar
                          ),
                        );
                      },
                    ),
            ),

            // Campo de texto para agregar nuevas notas
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white.withOpacity(0.9),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Escribe una nota rápida...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      maxLines: 2,
                      onSubmitted: (_) => _agregarNota(), // Enviar con enter
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: _agregarNota,
                      tooltip: 'Agregar nota',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Botón flotante para agregar notas
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarNota,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        tooltip: 'Agregar nueva nota',
        child: const Icon(Icons.note_add),
      ),
    );
  }

  // Método para mostrar diálogo de edición de nota
  void _mostrarDialogoEditar(int index) {
    final TextEditingController editController = TextEditingController(
      text: _notas[index],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar nota'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              hintText: 'Edita tu nota...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final String nuevoTexto = editController.text.trim();
                if (nuevoTexto.isNotEmpty) {
                  setState(() {
                    _notas[index] = nuevoTexto;
                  });
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Nota actualizada'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  // Método dispose para liberar recursos
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
