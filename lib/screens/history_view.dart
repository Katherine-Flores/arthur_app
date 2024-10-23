import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final String apiUrl = 'http://10.0.2.2:5000/comandos';

  // Método para obtener los datos de la API
  Future<List<dynamic>> fetchCommands() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error al obtener los comandos');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Historial de Comandos',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: fetchCommands(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error al cargar el historial'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No hay comandos disponibles'),
                  );
                }

                final commands = snapshot.data!.reversed.toList(); // Ultimo registro arriba

                return ListView.builder(
                  itemCount: commands.length,
                  itemBuilder: (context, index) {
                    final command = commands[index];
                    final enviado = command['enviado'] ?? false;

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 16),
                      child: ListTile(
                        leading: Icon(
                          Icons.code,
                          color: enviado ? Colors.greenAccent : Colors.redAccent,
                        ),
                        title: Text(command['comando']),
                        subtitle: Text('Fecha: ${command['fecha']}'),
                        trailing: Text(
                          enviado ? 'Enviado' : 'No enviado',
                          style: TextStyle(
                            color: enviado ? Colors.greenAccent : Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
