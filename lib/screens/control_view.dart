import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ControlView extends StatelessWidget {
  const ControlView({super.key});

  final String apiUrl = 'http://10.0.2.2:5000/send-data'; // URL de la API.

  // Método para enviar los comandos al backend en Python.
  Future<void> enviarDatos(String command) async {
    try {
      var url = Uri.parse(apiUrl);
      var data = {"message": command};

      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        print('Comando enviado: $command');
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error al conectar con la API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Control Remoto',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _controlButton('F', Icons.arrow_upward),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _controlButton('L', Icons.arrow_back),
                _controlButton('S', Icons.stop, color: Colors.indigo),
                _controlButton('R', Icons.arrow_forward),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _controlButton('B', Icons.arrow_downward),
              ],
            ),
            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  // Widget para los botones de control.
  Widget _controlButton(String command, IconData icon,
      {Color color = const Color(0xFFB2A4FF)}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onPressed: () => enviarDatos(command), // Enviamos el comando al API.
      child: Icon(
        icon,
        size: 36,
        color: Colors.white,
      ),
    );
  }
}
