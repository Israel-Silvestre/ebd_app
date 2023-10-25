import 'package:flutter/material.dart';

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
  ];

  final List<String> igrejas = [
    'Senhoras',
    'Jovens',
    'Crianças',
    'Intermediarios',
    'Adolescentes',
  ];

  String? _selectedFuncao;
  String? _selectedClasse;
  String? _selectedIgreja;
  String text = '';

  TextEditingController _textEditingController = TextEditingController();
  bool isItalic = false;
  bool isUnderlined = false;
  bool isBold = false;

  void _toggleItalic() {
    setState(() {
      isItalic = !isItalic;
    });
  }

  void _toggleUnderline() {
    setState(() {
      isUnderlined = !isUnderlined;
    });
  }

  void _toggleBold() {
    setState(() {
      isBold = !isBold;
    });
  }

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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'CPF',
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedClasse,
                hint: Text('Classe'),
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
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedIgreja,
                hint: Text('Igreja'),
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
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.all(10.0),
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
                            onPressed: _toggleItalic,
                            color: isItalic ? Colors.blue : null,
                          ),
                          IconButton(
                            icon: Icon(Icons.format_underline),
                            onPressed: _toggleUnderline,
                            color: isUnderlined ? Colors.blue : null,
                          ),
                          IconButton(
                            icon: Icon(Icons.format_bold),
                            onPressed: _toggleBold,
                            color: isBold ? Colors.blue : null,
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _textEditingController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: textStyle,
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Lógica para enviar participação
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  minimumSize: Size(200, 50),
                ),
                child: Text('Enviar Participação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
