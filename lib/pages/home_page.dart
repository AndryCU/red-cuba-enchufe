import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    getUltimoMunito();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('red CUBA'),
      ),
      body: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005),
          child: Column(children: [
            Container(
              child: textUltimasNoticias(),
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.002),
            ),
            _pageViewDestacadas(),
            _logoImage(context),
            _textShow(),
            _showNewList()
          ])),
    );
  }

  Align textUltimasNoticias() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Últimas Noticias!!',
        style: TextStyle(color: Colors.red, fontSize: 20),
        textAlign: TextAlign.start,
      ),
    );
  }

  Container _logoImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 10, right: 10, top: MediaQuery.of(context).size.height * 0.005),
      width: double.infinity,
      child: Image.asset(
        'assets/images/logo.png',
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.05,
      ),
    );
  }

  Widget testwidget(int p) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return null; //TODO
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }
      },
      future: test(p),
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

  Future<List<String>> getUltimoMunito() async {
    List<String> ultimo_minuto = [];

    final response =
        await http.Client().get(Uri.parse('https://www.redcuba.cu/'));
    if (response.statusCode == 200) {
      var documento = parser.parse(response.body);
      String new1 = documento
          .getElementsByClassName('ultimo-minuto padding-rl-0')[0]
          .children[0]
          .children[0]
          .text
          .trim();
      String new2 = documento
          .getElementsByClassName('ultimo-minuto padding-rl-0')[0]
          .children[1]
          .children[0]
          .text
          .trim();
      ultimo_minuto.add(new1);
      print('$new1   $new2');
    }

    return ultimo_minuto;
  }

  Widget _showClimaData() {
    return Container(
      child: Text('CLIMA AQUI'),
    );
  }

  Widget _pageViewDestacadas() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Center(child: _cardLastestNews());
        },
      ),
    );
  }

  Widget _cardLastestNews() {
    return Container(
      decoration: BoxDecoration(border: Border(left: BorderSide())),
      width: 300,
      child: ListTile(
        onTap: () {
          print('NAVEGAR');
        },
        title: Text(
          'Title asdjh kasdkj hasdkj hasdkj asdasd ahsd kasdkj hasdkj hasdkj asdasd ahsd',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.blue, fontSize: 15.0),
        ),
        trailing: Icon(
          Icons.launch_sharp,
          color: Colors.blue,
          size: 25.0,
        ),
      ),
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
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextField(
                decoration: const InputDecoration(
                    hintText: 'Buscar artículos...',
                    contentPadding: EdgeInsets.all(10)),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: MediaQuery.of(context).size.width * 0.05,
                )),
            Container(
              width: MediaQuery.of(context).size.height * 0.15,
              child: TextButton(
                  onPressed: () {},
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

  Widget _showNewList() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.58,
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: Icon(Icons.add),
            title: Text('Texto tomado de'),
          );
        },
      ),
    );
  }
}
