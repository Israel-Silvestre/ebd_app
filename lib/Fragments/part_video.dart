import 'package:flutter/material.dart';

class Video extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Função',
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'CPF',
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Classe',
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Igreja',
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 10),
                            Text('Anexar Vídeo '),
                            Icon(IconData(0xee82, fontFamily: 'MaterialIcons'),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
