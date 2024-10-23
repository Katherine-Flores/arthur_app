import 'package:flutter/material.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({super.key});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  // Datos simulados, Obtener del Backend
  final Map<String, dynamic> robotDetails = {
    "propietario": "Katherine Flores",
    "nombreRobot": "Explorador X",
    "codigo": "RBT-001",
    "fechaRegistro": "2024-10-22",
    "estado": "Activo",
    "descripcion": "Robot explorador con capacidad de desplazamiento autónomo y control manual."
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/images/Robot.png',
                  width: 170,
                  height: 170,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Título de la vista
            const Text(
              'Detalles del Robot',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Mostrar cada detalle en una tarjeta
            ...robotDetails.entries.map((entry) {
              return buildDetailCard(entry.key, entry.value.toString());
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget para construir cada detalle en una tarjeta
  Widget buildDetailCard(String title, String value) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title: ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.indigo,
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
