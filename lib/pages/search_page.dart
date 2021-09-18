import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_cuba/models/noticias_model.dart';
import 'package:red_cuba/utiles/news.dart';
import 'package:red_cuba/utiles/preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final prefs = new PreferenciasUsuario();
  final news = NewsProvider();
  List<String> todo_results = [];
  final _text = TextEditingController();
  String _dropinitial = 'todo';
  bool phusdrop = false;

  @override
  void dispose() {
    prefs.flag = false;
    news.disposeStreams();
    phusdrop = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10),
              child: Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.35,
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005),
            child: Column(
              children: [_textShow(), _showTodoResults()],
            ),
          )),
    );
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
                style: TextStyle(),
                controller: _text,
                decoration: InputDecoration(
                    errorText: _text.text.isEmpty ? 'Vacío' : null,
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
                    prefs.load = true;
                    news.searchMain(_text.text, _dropinitial);
                    setState(() {});
                  },
                  child: Text(
                    'Buscar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.035),
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

  Widget _showTodoResults() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: StreamBuilder(
          stream: news.newsStream,
          builder: (context, AsyncSnapshot<List<Noticias>> snapshot) {
            if (prefs.flag && _text.text.isEmpty) {
              return Container();
            }

            if (_text.text.isNotEmpty && prefs.load && _dropinitial == 'todo') {
              return loadingWidget(context);
            }

            if (_text.text.isNotEmpty && !snapshot.hasData && !prefs.load) {
              return Container();
            }

            if (_text.text.isNotEmpty && prefs.load) {
              return loadingWidget(context);
            }

            if (_text.text.isNotEmpty && prefs.load && snapshot.hasData) {
              return loadingWidget(context);
            }

            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      news.launchInBrowser(snapshot.data![index].url);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ListTile(
                        title: Text(
                          '${snapshot.data![index].title}',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${snapshot.data![index].subtitle}',
                            overflow: TextOverflow.clip,
                            maxLines: 3,
                            softWrap: true,
                            textAlign: TextAlign.justify),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),
                  );
                },
              );
            } else {
              return loadingWidget(context);
            }
          },
        ));
  }

  Container loadingWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Center(
        child: Column(children: [
          Text(
            'BUSCANDO...',
            style: TextStyle(
                color: Colors.blue,
                fontSize: MediaQuery.of(context).size.width * 0.06),
          ),
          SizedBox(
            child: CircularProgressIndicator(),
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.12,
          ),
        ]),
      ),
    );
  }

  Widget _dropDown() {
    final style = TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.045,
    );
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      width: MediaQuery.of(context).size.width * 0.3,
      child: DropdownButton(
        value: _dropinitial,
        isExpanded: true,
        items: [
          DropdownMenuItem(
              value: 'todo',
              child: Text(
                'Todo',
                style: style,
                overflow: TextOverflow.ellipsis,
              )),
          DropdownMenuItem(
            value: 'documentos',
            child: Text(
              'Documentos',
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DropdownMenuItem(
              value: 'noticias',
              child: Text(
                'Noticias',
                style: style,
                overflow: TextOverflow.ellipsis,
              )),
        ],
        onChanged: (value) {
          phusdrop = true;
          setState(() {
            _dropinitial = value as String;
          });
          print(value);
        },
      ),
    );
  }
}
