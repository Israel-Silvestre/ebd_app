import 'dart:async';
import 'package:ebd_app/Components/check.dart';
import 'package:flutter/material.dart';
import '../GoogleApis/Gsheets_api.dart';

class Texto extends StatefulWidget {
  @override
  _TextoState createState() => _TextoState();
}

class _TextoState extends State<Texto> {
  final List<String> classes = [
    'Senhoras',
    'Jovens',
    'Crianças',
    'Intermediarios',
    'Adolescentes',
    'Obreiros',
    'Diáconos',
    'Ungidos',
    'Pastores',
  ];

  final List<String> igrejas = [
    'Santarém',
    'Cidade das Rosas',
    'Santa Tereza',
    'Macau',
    'Nova Cruz',
    'Satélite',
    'Extremoz',
    'Goianinha',
    'São José de Mipibu',
    'Igapó',
    'Ponta Negra',
    'Ceará Mirim',
    'Montanhas',
    'Nova Natal',
    'Parnamirim',
    'Pajuçara',
    'Monte Alegre',
    'Alvorada',
    'Mirassol',
    'Village das Dunas',
    'Mossoró',
    'Uruaçu',
    'Acari',
    'Nova Parnamirim',
    'Alecrim',
    'Caicó',
    "Lagoa D'anta",
  ];

  String? _selectedClasse;
  String? _selectedIgreja;
  String text = '';
  String nome = '';
  String cpf = '';
  bool isItalic = false;
  bool isUnderlined = false;
  bool isBold = false;
  bool _isShowingOverlay = false;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      nome = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      cpf = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'CPF',
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedClasse,
                    hint: const Text('Classe'),
                    items: classes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedClasse = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedIgreja,
                    hint: const Text('Igreja'),
                    items: igrejas.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedIgreja = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey, width: 1.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(Icons.format_italic),
                                onPressed: () {
                                  setState(() {
                                    isItalic = !isItalic;
                                  });
                                },
                                color: isItalic ? Colors.blue : null,
                              ),
                              IconButton(
                                icon: Icon(Icons.format_underline),
                                onPressed: () {
                                  setState(() {
                                    isUnderlined = !isUnderlined;
                                  });
                                },
                                color: isUnderlined ? Colors.blue : null,
                              ),
                              IconButton(
                                icon: Icon(Icons.format_bold),
                                onPressed: () {
                                  setState(() {
                                    isBold = !isBold;
                                  });
                                },
                                color: isBold ? Colors.blue : null,
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          style: textStyle,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Digite seu texto aqui...',
                          ),
                          onChanged: (value) {
                            setState(() {
                              text = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _sendTextParticipation();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text('Enviar Participação'),
                  ),
                ],
              ),
            ),
          ),
          if (_isShowingOverlay)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Check(),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _sendTextParticipation() async {
    if (_selectedClasse != null &&
        _selectedIgreja != null &&
        text.isNotEmpty &&
        nome.isNotEmpty &&
        cpf.isNotEmpty) {
      try {
        await GoogleSheetsApi.part_texto(
          nome,
          cpf,
          _selectedClasse!,
          _selectedIgreja!,
          text,
        );
        print('Participação em texto enviada com sucesso.');

        setState(() {
          _isShowingOverlay = true;
        });

        Timer(Duration(seconds: 5), () {
          setState(() {
            _isShowingOverlay = false;
          });
        });
      } catch (e) {
        print('Erro ao enviar a participação em texto: $e');
      }
    } else {
      print('Por favor, preencha todos os campos.');
    }
  }
}
