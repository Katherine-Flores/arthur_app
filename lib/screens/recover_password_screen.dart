import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  // Expresión regular para validar un código de 6 dígitos.
  final RegExp _codeRegExp = RegExp(r'^\d{6}$');

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      // Aquí iría la lógica para verificar el código ingresado.
      if (kDebugMode) {
        print('Código ingresado: ${_codeController.text}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ingrese el código que enviamos a su correo:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Código de Recuperación',
                ),
                validator: (value) {
                  if (value == null || !_codeRegExp.hasMatch(value)) {
                    return 'Ingrese un código válido (6 dígitos).';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text('Verificar Código'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
