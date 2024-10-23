import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool notificationsEnabled = true;
  String selectedTheme = 'Claro';
  String selectedLanguage = 'Español';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text(
                  'Ajustes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // Configuración de Notificaciones
                buildSwitchTile(
                  title: 'Notificaciones',
                  value: notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                // Selección de Tema
                buildDropdownTile(
                  title: 'Tema',
                  value: selectedTheme,
                  items: ['Claro', 'Oscuro'],
                  onChanged: (value) {
                    setState(() {
                      selectedTheme = value!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                // Selección de Idioma
                buildDropdownTile(
                  title: 'Idioma',
                  value: selectedLanguage,
                  items: ['Español', 'Inglés'],
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                // Información de la Aplicación
                const Text(
                  'Información de la Aplicación',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7D84B2),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Versión: 1.0.0'),
                const SizedBox(height: 8),
                const Text('Desarrollado por Creative Minds Studio'),
              ],
            ),

            // Botón de Restablecimiento
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF464390),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Restablecer Ajustes'),
                      content: const Text('¿Estás seguro de que deseas restablecer todos los ajustes?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              notificationsEnabled = true;
                              selectedTheme = 'Claro';
                              selectedLanguage = 'Español';
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text('Restablecer'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Restablecer Ajustes'),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para el interruptor
  Widget buildSwitchTile({required String title, required bool value, required ValueChanged<bool> onChanged}) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.indigo,
      inactiveThumbColor: Colors.blueGrey,
    );
  }

  // Widget para el menú desplegable
  Widget buildDropdownTile({
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: title,
        border: const OutlineInputBorder(),
      ),
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
