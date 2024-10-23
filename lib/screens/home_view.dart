import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final Function(int) onCardTapped; // Callback function

  const HomeView({super.key, required this.onCardTapped});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¿Qué deseas hacer?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dos columnas
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0, // Proporción normal de las tarjetas
                ),
                children: [
                  _buildCard(
                    context,
                    index: 1, // Hablar
                    icon: Icons.mic,
                    label: 'Hablar',
                    color: const Color(0xFFC3AED6),
                  ),
                  _buildCard(
                    context,
                    index: 2, // Control
                    icon: Icons.gamepad,
                    label: 'Control',
                    color: const Color(0xFF98AFC7),
                  ),
                  _buildCard(
                    context,
                    index: 3, // Historial (doble ancho)
                    icon: Icons.history,
                    label: 'Historial',
                    color: const Color(0xFFB2A4FF),
                    isDoubleWidth: true,
                  ),
                  _buildCard(
                    context,
                    index: 4, // Detalles (doble ancho)
                    icon: Icons.info,
                    label: 'Detalles',
                    color: const Color(0xFF7D84B2),
                    isDoubleWidth: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir cada Card.
  Widget _buildCard(
      BuildContext context, {
        required int index,
        required IconData icon,
        required String label,
        required Color color,
        bool isDoubleWidth = false,
      }) {
    return GestureDetector(
      onTap: () {
        onCardTapped(index); // Call the passed function
      },
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
