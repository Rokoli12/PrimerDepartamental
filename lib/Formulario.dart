import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();

  // Controladores
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmarController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _aceptoTerminos = false;
  bool _intentoEnviar = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmarController.dispose();
    super.dispose();
  }

  // Validaciones
  String? _validarNombre(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre es obligatorio';
    }
    if (value.trim().length < 3) {
      return 'El nombre debe tener al menos 3 caracteres';
    }
    return null;
  }

  String? _validarEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'El email es obligatorio';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value.trim())) return 'Ingresa un email válido';
    return null;
  }

  String? _validarPassword(String? value) {
    if (value == null || value.isEmpty) return 'La contraseña es obligatoria';
    if (value.length < 6) return 'Debe tener al menos 6 caracteres';
    return null;
  }

  String? _validarConfirmacion(String? value) {
    if (value != _passwordController.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  void _enviar() {
    setState(() {
      _intentoEnviar = true;
    });

    if (_formKey.currentState!.validate()) {
      if (!_aceptoTerminos) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Debes aceptar los términos'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        return;
      }

      final nombre = _nombreController.text.trim();
      final email = _emailController.text.trim();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registrado: $nombre ($email)'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  void _limpiar() {
    _formKey.currentState!.reset();
    _nombreController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmarController.clear();
    setState(() {
      _aceptoTerminos = false;
      _intentoEnviar = false;
    });
  }

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: _intentoEnviar
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Formulario de Registro',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                _buildTextField(
                  controller: _nombreController,
                  label: 'Nombre',
                  icon: Icons.person,
                  validator: _validarNombre,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validarEmail,
                ),
                const SizedBox(height: 16),
                _buildPasswordField(
                  controller: _passwordController,
                  label: 'Contraseña',
                  icon: Icons.lock,
                  obscure: _obscurePassword,
                  onToggle: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  validator: _validarPassword,
                ),
                const SizedBox(height: 16),
                _buildPasswordField(
                  controller: _confirmarController,
                  label: 'Confirmar Contraseña',
                  icon: Icons.lock_outline,
                  obscure: _obscureConfirm,
                  onToggle: () {
                    setState(() {
                      _obscureConfirm = !_obscureConfirm;
                    });
                  },
                  validator: _validarConfirmacion,
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CheckboxListTile(
                    value: _aceptoTerminos,
                    onChanged: (val) {
                      setState(() {
                        _aceptoTerminos = val ?? false;
                      });
                    },
                    title: const Text('Acepto términos y condiciones'),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: _enviar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Enviar',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: _limpiar,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Limpiar',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
      ),
      keyboardType: keyboardType,
      validator: validator,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool obscure,
    required VoidCallback onToggle,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility : Icons.visibility_off,
            color: Colors.blueAccent,
          ),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
      ),
      obscureText: obscure,
      validator: validator,
      textInputAction: TextInputAction.next,
    );
  }
}
