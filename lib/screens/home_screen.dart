import 'package:flutter/material.dart';
import 'home_view.dart';
import 'speak_view.dart';
import 'history_view.dart';
import 'details_view.dart';
import 'control_view.dart';
import 'settings_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCardTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Lista de vistas para cada opción del BottomNavigationBar
    List<Widget> _widgetOptions = <Widget>[
      HomeView(onCardTapped: _onCardTapped),
      SpeakView(),
      ControlView(),
      HistoryView(),
      DetailsView(),
      SettingsView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            'Nombre de Usuario', // Recuperar del Backend
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Lógica para perfil del usuario
            },
          ),
        ],
      ),
      body: _widgetOptions[_selectedIndex], // Mostrar la vista seleccionada
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
            backgroundColor: Color(0xFFA7C7E7),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Hablar',
            backgroundColor: Color(0xFFC3AED6),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'Control',
            backgroundColor: Color(0xFF98AFC7),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
            backgroundColor: Color(0xFFB2A4FF),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Detalles',
            backgroundColor: Color(0xFF7D84B2),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
            backgroundColor: Color(0xFFD6BBFC),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
