import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import '';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String dropinitial = 'todo';
  bool visibility = false;
  final _text = TextEditingController();
  bool _validate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Image.asset(
            'assets/images/logo.png',
            width: MediaQuery.of(context).size.width * 0.35,
          ),
        ),
        body: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005),
          child: Column(
            children: [_textShow(), _showTodoResults()],
          ),
        ));
  }

  Widget _textShow() {
    return Card(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.005, left: 2),
      elevation: 10,
      child: Container(
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: TextField(
                controller: _text,
                decoration: InputDecoration(
                    errorText: _validate ? 'Vacío' : null,
                    hintText: 'Buscar artículos...',
                    contentPadding: EdgeInsets.all(10)),
              ),
            ),
            _dropDown(),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              width: MediaQuery.of(context).size.width * 0.2,
              child: TextButton(
                  onPressed: () {
                    _text.text.isEmpty ? _validate = true : _validate = false;
                    visibility = true;
                    setState(() {});
                  },
                  child: Text(
                    'Buscar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(0, 212, 164, 1)),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> test(int pos) async {
    String texto1 = '';
    final response = await http.Client().get(Uri.parse(
        'https://www.redcuba.cu/web/webResults/inteferon?_query=inteferon'));
    if (response.statusCode == 200) {
      var documento = parser.parse(response.body);
      texto1 = documento
          .getElementsByClassName('results-page')[0]
          .children[pos]
          .children[0]
          .text
          .toString();
    }
    return texto1;
  }

  Widget _dropDown() {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      width: MediaQuery.of(context).size.width * 0.25,
      child: DropdownButton(
        value: dropinitial,
        isExpanded: true,
        items: [
          DropdownMenuItem(value: 'todo', child: Text('Todo')),
          DropdownMenuItem(value: 'imagenes', child: Text('Imágenes')),
          DropdownMenuItem(value: 'documentos', child: Text('Documentos')),
          DropdownMenuItem(value: 'noticias', child: Text('Noticias')),
          DropdownMenuItem(value: 'academia', child: Text('Academia')),
        ],
        onChanged: (value) {
          setState(() {
            dropinitial = value as String;
          });
          print(value);
        },
      ),
    );
  }

  Widget _showTodoResults() {
    return Visibility(
      visible: visibility,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.58,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: Icon(Icons.link),
              title: Text(''),
            );
          },
        ),
      ),
    );
  }
}
