import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../GoogleApis/Gsheets_api.dart';

class Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  final List<String> classes = [
    'Senhoras',
    'Jovens',
    'Crianças',
    'Intermediarios',
    'Adolescentes',
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
  String? nome;
  String? cpf;
  bool _isVideoAttached = false;
  File? _attachedVideo;
  String? videoFileName;

  double buttonWidth = 150;
  double buttonHeight = 40;

  Future<void> _pickVideoFromGallery() async {
    try {
      final pickedFile = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(seconds: 10),
      );
      if (pickedFile != null) {
        setState(() {
          _isVideoAttached = true;
          _attachedVideo = File(pickedFile.path);
          videoFileName = _attachedVideo!.path.split('/').last; // Obtém apenas o nome do arquivo
        });
      }
    } catch (e) {
      print('Ocorreu uma exceção: $e');
    }
  }

  void _cancelAttachment() {
    setState(() {
      _isVideoAttached = false;
      _attachedVideo = null;
      videoFileName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                if (_isVideoAttached && _attachedVideo != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(10),
                          color: Colors.grey[300],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                videoFileName ?? '', // Nome do vídeo anexado
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              GestureDetector(
                                onTap: _cancelAttachment,
                                child: const Icon(Icons.clear),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                if (!_isVideoAttached || _attachedVideo == null)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: _pickVideoFromGallery,
                        child: Container(
                          width: buttonWidth,
                          height: buttonHeight,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 10),
                                Text('Anexar Vídeo '),
                                Icon(Icons.attach_file), // Alterei para o ícone padrão do Flutter
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_isVideoAttached && _attachedVideo != null) {
                      GoogleSheetsApi.part_video(nome!, cpf!, _selectedClasse!, _selectedIgreja!, videoFileName!, _attachedVideo!.path);
                    } else {
                      // Lidar com o cenário em que nenhum vídeo está anexado, se necessário
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue,
                    minimumSize: Size(buttonWidth, buttonHeight),
                  ),
                  child: const Text('Enviar Participação'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
