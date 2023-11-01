import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ebd_app/GoogleApis/Gsheets_api.dart';
import 'package:http/http.dart' as http;

import '../Screens/showPerguntas.dart';

class Pergunta {
  final String numero;
  final String imagePath;
  final String texto;

  Pergunta({required this.numero, required this.imagePath, required this.texto});
}

class Perguntas extends StatefulWidget {
  @override
  _PerguntasState createState() => _PerguntasState();
}

class _PerguntasState extends State<Perguntas> {
  late Future<List<Pergunta>> futurePerguntas;

  @override
  void initState() {
    super.initState();
    futurePerguntas = GoogleSheetsApi.obterPerguntas();
  }

  Future<Uint8List?> _fetchImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pergunta>>(
      future: futurePerguntas,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao carregar perguntas'),
          );
        } else if (snapshot.hasData) {
          List<Pergunta> perguntas = snapshot.data!;

          return Scaffold(
            body: ListView.builder(
              itemCount: perguntas.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => showPerguntas(pergunta: perguntas[index]),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.black, width: 1),
                      ),
                      elevation: 4,
                      shadowColor: Colors.black.withOpacity(0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                perguntas[index].numero,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                              child: FutureBuilder<Uint8List?>(
                                future: _fetchImage(perguntas[index].imagePath),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Icon(Icons.error);
                                  } else if (snapshot.hasData) {
                                    return Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: Text('Nenhum dado encontrado'),
          );
        }
      },
    );
  }
}
