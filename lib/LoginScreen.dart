import 'package:flutter/material.dart';
import 'package:ebd_app/HomePage.dart'; // Importe o arquivo da HomePage aqui

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'), // Coloque o caminho da sua imagem de fundo
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.1), // Ajuste a altura conforme necessário
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3, // Defina a largura do botão
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()), // Navega para a HomePage
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    Colors.blue, // Defina a cor azul para o botão
                  ),
                  child: const Text('ENTRAR', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(
                height: 10.0), // Ajuste o espaçamento conforme necessário
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3, // Defina a largura do botão
                child: ElevatedButton(
                  onPressed: () {
                    // Adicione aqui a função para o segundo botão
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    Colors.blue, // Defina a cor azul para o botão
                  ),
                  child: const Text('TUTORIAL', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(
                height: 70.0), // Ajuste o espaçamento conforme necessário
          ],
        ),
      ),
    );
  }
}
