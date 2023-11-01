import 'package:flutter/material.dart';
import '../Components/check.dart';
import '../GoogleApis/Gsheets_api.dart';
import '../Components/error.dart';

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

  final List<String> perguntas = [
    'Pergunta 1',
    'Pergunta 2',
    'Pergunta 3',
  ];

  String? _selectedClasse;
  String? _selectedIgreja;
  String? _selectedPergunta;
  String text = '';
  String nome = '';
  String cpf = '';
  bool isItalic = false;
  bool isUnderlined = false;
  bool isBold = false;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );

    return Scaffold(
      body: SingleChildScrollView(
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
              DropdownButtonFormField<String>(
                value: _selectedPergunta,
                hint: const Text('Pergunta'),
                items: perguntas.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedPergunta = newValue;
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
    );
  }

  void _sendTextParticipation() async {
    if (_selectedClasse != null &&
        _selectedIgreja != null &&
        _selectedPergunta != null &&
        text.isNotEmpty &&
        nome.isNotEmpty &&
        cpf.isNotEmpty) {
      try {
        String result = await GoogleSheetsApi.part_texto(
          nome,
          cpf,
          _selectedClasse!,
          _selectedIgreja!,
          _selectedPergunta!,
          text,
        );
        print('Resultado da participação em texto: $result');

        if (result == 'Participação enviada com sucesso!') {
          _showCheckOverlay(result);
        } else {
          _showErrorOverlay(result);
        }
      } catch (e) {
        print('Erro ao enviar a participação em texto: $e');
        _showErrorOverlay('Erro ao enviar a participação.');
      }
    } else {
      print('Por favor, preencha todos os campos.');
    }
  }

  void _showErrorOverlay(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Error(errorText: errorMessage),
        );
      },
    );
  }

  void _showCheckOverlay(String successMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: AnimatedCheck(overlayText: successMessage),
        );
      },
    );
  }
}
