import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> ultimo_minuto = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: showDrawer(context),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () => Navigator.pushNamed(context, 'search'),
          ),
          IconButton(
            icon: Icon(
              Icons.info_outlined,
            ),
            onPressed: () => Navigator.pushNamed(context, 'about'),
          )
        ],
        backgroundColor: Colors.blueGrey,
        title: Image.asset(
          'assets/images/logo.png',
          width: MediaQuery.of(context).size.width * 0.35,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005),
            child: Column(children: [
              Container(
                child: textUltimasNoticias(),
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.002),
              ),
              _pageViewDestacadas(),
              Text(
                'Sitios webs recomendados',
              ),
              _table()
            ])),
      ),
    );
  }

  Drawer showDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'assets/images/app_bar_image.png',
              ),
            )),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Realizar una búsqueda'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigator.pushNamed(context, 'busqueda'),
          ),
          ListTile(
            leading: Icon(Icons.info_outlined),
            title: Text('Acerca de...'),
            trailing: Icon(Icons.keyboard_arrow_right),
          )
        ],
      ),
    );
  }

  Align textUltimasNoticias() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Último minuto',
        style: TextStyle(color: Color.fromRGBO(94, 145, 254, 1), fontSize: 20),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget testwidget() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(border: Border(left: BorderSide())),
                width: 400,
                child: ListTile(
                  onTap: () {
                    print('NAVEGAR');
                  },
                  title: Text(
                    '${ultimo_minuto[index]}',
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15.0),
                  ),
                  trailing: Icon(
                    Icons.link,
                    color: Colors.blue,
                    size: 25.0,
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blueGrey,
            ),
          );
        }
      },
      future: getUltimoMunito(),
    );
  }

  Future<List<String>> getUltimoMunito() async {
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
      ultimo_minuto.add(new2);

      String sumary_new1 = documento
          .getElementsByClassName('ultimo-minuto padding-rl-0')[0]
          .children[0]
          .children[2]
          .text
          .trim();

      String sumary_new2 = documento
          .getElementsByClassName('ultimo-minuto padding-rl-0')[0]
          .children[1]
          .children[2]
          .text
          .trim();
      ultimo_minuto.add(sumary_new1);
      ultimo_minuto.add(sumary_new2);
    }

    return ultimo_minuto;
  }

  Widget _pageViewDestacadas() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.12,
        child: Center(child: testwidget()));
  }

  Widget _table() {
    return Table(
      children: [
        TableRow(children: [
          _imageTable(
              'assets/images/link_cubadebate.png', 'Cubadebate', 'cubadebate'),
          _imageTable('assets/images/link_ecured.png', 'Ecured', ''),
        ]),
        TableRow(children: [
          _imageTable('assets/images/reflej.png', 'Blogs Reflejos', 'picta'),
          _imageTable('assets/images/ofertas.png', 'Ofertas.cu', ''),
        ]),
        TableRow(children: [
          _imageTable('assets/images/toDus.png', 'toDus app', 'jajaja'),
          _imageTable('assets/images/apklis.png', 'Apklis', ''),
        ]),
        TableRow(children: [
          _imageTable('assets/images/link_infomed.png', 'Salud', ''),
          _imageTable('assets/images/link_cubaeduca.png', '', ''),
        ]),
        TableRow(children: [
          _imageTable('assets/images/papeleta.png', '', ''),
          _imageTable('assets/images/anda.png', '', ''),
        ]),
        TableRow(children: [
          _imageTable('assets/images/consola.jpg', '', ''),
          _imageTable('assets/images/picta.jpg', '', ''),
        ])
      ],
    );
  }

  Widget _imageTable(String ruta_foto, String web_url, String url) {
    return InkWell(
      onTap: () {
        print('voy a $url');
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        margin: EdgeInsets.only(left: 10, top: 5, right: 5),
        decoration: BoxDecoration(
            color: Color.fromRGBO(0, 212, 164, 0.2),
            borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              child: Image.asset(
                ruta_foto,
                height: 50,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            Text(web_url)
          ],
        ),
      ),
    );
  }
}
