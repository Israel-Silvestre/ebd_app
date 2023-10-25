import 'package:flutter/material.dart';

class Pergunta {
  final String texto;
  final String imagePath;

  Pergunta({required this.texto, required this.imagePath});
}

class Perguntas extends StatelessWidget {

  final List<Pergunta> perguntas = [
    Pergunta(
        texto: 'Pergunta 1', imagePath: 'assets/pergunta1.png'),
    Pergunta(
        texto: 'Pergunta 2', imagePath: 'assets/pergunta2.png'),
    Pergunta(
        texto: 'Pergunta 3', imagePath: 'assets/pergunta3.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: perguntas.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              color: Colors.grey[200], // Define a cor de fundo do card como cinza claro
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.black, width: 1), // Adiciona uma borda preta ao redor do card
              ),
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.2), // Adicione sombra ao card
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        perguntas[index].texto,
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
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover, // Ajusta a imagem para caber dentro do card
                            image: AssetImage(perguntas[index].imagePath),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
