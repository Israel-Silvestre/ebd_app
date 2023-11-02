import 'package:flutter/material.dart';
import 'package:ebd_app/Fragments/perguntas.dart';
import 'package:ebd_app/Fragments/part_video.dart';
import 'package:ebd_app/Fragments/part_texto.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Índice da opção selecionada na BottomNavigationBar

  final List<Widget> _pages = [
    Perguntas(), // Frqagmento para mostrar perguntas.
    Video(showAppBar: false), // Fragmento de  participação em vídeo.
    Texto(showAppBar: false), // Fragmento de  participação em texto.
  ];

  late List<bool> _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = List.generate(3, (index) => index == 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perguntas',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _pages[
      _selectedIndex], // Mostra a página correspondente à opção selecionada
      backgroundColor: Colors.white, // Cor de fundo do corpo do Scaffold
      bottomNavigationBar: Container(
        height: 65, // Altura da BottomNavigationBar reduzida para 50
        decoration: const BoxDecoration(
          color: Colors.blue, // Cor de fundo da BottomNavigationBar
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavigationBarItem(0xf587, 'Perguntas', 0),
            _buildBottomNavigationBarItem(0xf526, 'Vídeo', 1),
            _buildBottomNavigationBarItem(0xee3e, 'Texto', 2),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBarItem(int iconCode, String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSelected = List.generate(3, (i) => i == index);
            _selectedIndex = index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(IconData(iconCode, fontFamily: 'MaterialIcons'),
                  color: Colors.white, size: 40),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                height: _isSelected[index] ? 20 : 0,
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
