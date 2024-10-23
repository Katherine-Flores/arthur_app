import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:convert';

class SpeakView extends StatefulWidget {
  const SpeakView({Key? key}) : super(key: key);

  @override
  State<SpeakView> createState() => _SpeakViewState();
}

class _SpeakViewState extends State<SpeakView> {
  final List<String> _chatMessages = []; // Mensajes del chat
  late stt.SpeechToText _speech; // Inicialización del reconocimiento de voz
  bool _isListening = false; // Estado de escucha

  final String apiUrl = 'http://10.0.2.2:5000/send-data'; // URL de la API.

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  // Función para enviar los datos a la API
  Future<void> enviarDatos(String message) async {
    try {
      var url = Uri.parse(apiUrl);
      var data = {"message": message};

      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );

      setState(() {
        _chatMessages.add('Tú: $message');
      });

      if (response.statusCode == 200) {
        print('Comando enviado: $message');
        setState(() {
          _chatMessages.add('Arthur: \'$message\' enviado al robot');
        });
      } else {
        print('Error ${response.statusCode}: No se pudo enviar');
      }
    } catch (e) {
      print('Error al conectar con la API: $e');
    }
  }

  // Inicia o detiene la escucha
  void _escuchar() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => print('Estado: $status'),
        onError: (error) => print('Error: $error'),
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          localeId: 'es_ES',
          onResult: (result) {
            if (result.finalResult) {
              _procesarComando(result.recognizedWords);
            }
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  // Procesa el comando de voz y envía el mensaje correspondiente
  void _procesarComando(String comando) {
    String mensaje;

    if (comando.contains('hola amigo')) {
      mensaje = 'Happy';
    } else if (comando.contains('gracias')) {
      mensaje = 'Happy';
    } else if (comando.contains('estoy triste')) {
      mensaje = 'Sad';
    } else if (comando.contains('estoy enojado')) {
      mensaje = 'Angry';
    } else if (comando.contains('tengo sueño')) {
      mensaje = 'Sleep';
    } else if (comando.contains('estoy aburrido')) {
      mensaje = 'Normal';
    } else {
      setState(() {
        _chatMessages.add('Robot: No entiendo lo que dices.');
      });
      return;
    }

    enviarDatos(mensaje); // Envía el mensaje al robot
  }

  Widget _buildChat() {
    return ListView.builder(
      itemCount: _chatMessages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(
            _chatMessages[index],
            style: const TextStyle(fontSize: 18),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _buildChat()), // Muestra los mensajes del chat
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _escuchar,
              child: Text(_isListening ? 'Escuchando...' : 'Presiona para Hablar'),
            ),
          ),
        ],
      ),
    );
  }
}
