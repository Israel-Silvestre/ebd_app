import 'package:flutter/material.dart';
import 'package:ebd_app/HomePage.dart'; // Importe o arquivo da HomePage aqui

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.3;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'), // Coloque o caminho da sua imagem de fundo
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0), // Ajuste o espaçamento superior conforme necessário
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Transform.rotate(
                    angle: -90 * 3.1415927 / 180,
                    child: Image(
                      image: AssetImage('assets/logo.png'), // Coloque o caminho da sua imagem de logo
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.6), // Ajuste a posição vertical dos botões aqui
                child: SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()), // Navega para a HomePage
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Defina a cor azul para o botão
                    ),
                    child: const Text('ENTRAR', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.8), // Ajuste a posição vertical dos botões aqui
                child: SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      // Adicione aqui a função para o segundo botão
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Defina a cor azul para o botão
                    ),
                    child: const Text('TUTORIAL', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
