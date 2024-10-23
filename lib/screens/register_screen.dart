import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arthur_app/screens/login_screen.dart';
import 'package:arthur_app/screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String _selectedCountry = '';
  String _areaCode = '';

  // Controladores para cada campo
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _acceptedTerms = false;

  // Validaciones con expresiones regulares
  final RegExp _nameRegExp = RegExp(r'^[a-zA-Z\s]{3,}$');
  final RegExp _emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
  final RegExp _phoneRegExp = RegExp(r'^[0-9]{8}$'); // Solo 8 dígitos para Guatemala.

  void _onCountryChanged(String? value) {
    if (value != 'Guatemala') {
      _showCountryAlert();
      _areaCode = '';
    } else {
      setState(() {
        _selectedCountry = value!;
        _areaCode = '+502';
      });
    }
  }

  void _showCountryAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Servicio no disponible'),
        content: const Text(
            'Nuestro servicio aún no está disponible en este país, pero esperamos que pronto lo esté.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _showTermsAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Términos y Condiciones'),
        content: const Text(
            'Debe aceptar los términos y condiciones para registrarse.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      String phone = _phoneController.text;

      // Si el número tiene el código de área, lo eliminamos con una expresión regular.
      phone = phone.replaceFirst(RegExp(r'^\+502'), '');

      // Aquí iría la lógica para guardar los datos en la base de datos.
      if (kDebugMode) {
        print('Nombre: ${_nameController.text}');
      }
      if (kDebugMode) {
        print('Correo: ${_emailController.text}');
      }
      if (kDebugMode) {
        print('Contraseña: ${_passwordController.text}');
      }
      if (kDebugMode) {
        print('Teléfono: $_areaCode $phone');
      }
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
            const HomeScreen()),
      );
    }
    if(!_acceptedTerms){
      _showTermsAlert();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nombre de Usuario'),
                  validator: (value) {
                    if (value == null || !_nameRegExp.hasMatch(value)) {
                      return 'Ingrese un nombre válido (solo letras y al menos 3 caracteres).';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Correo'),
                  validator: (value) {
                    if (value == null || !_emailRegExp.hasMatch(value)) {
                      return 'Ingrese un correo válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'La contraseña debe tener al menos 8 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  items: const [
                    DropdownMenuItem(
                      value: '',
                      child: Row(
                        children: [
                          Text('Selecciona tu país'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Guatemala',
                      child: Row(
                        children: [
                          Text('🇬🇹 Guatemala'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Otro',
                      child: Row(
                        children: [
                          Text('🌍 Otro País'),
                        ],
                      ),
                    ),
                  ],
                  onChanged: _onCountryChanged,
                  decoration: const InputDecoration(labelText: 'País'),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text('$_areaCode '),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(8),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Teléfono',
                        ),
                        validator: (value) {
                          if (value == null || !_phoneRegExp.hasMatch(value)) {
                            return 'Ingrese un número de teléfono válido (8 dígitos).';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Checkbox(
                      value: _acceptedTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptedTerms = value!;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text('Acepto todos los términos y condiciones.'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF464390),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 52, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Registrar'),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Navegar a la pantalla de inicio de sesión.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const LoginScreen()),
                      );
                    },
                    child: const Text('¿Ya tienes una Cuenta?'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
