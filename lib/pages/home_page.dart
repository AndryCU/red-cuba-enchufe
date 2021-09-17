import 'package:flutter/material.dart';
import 'package:red_cuba/utiles/news.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              _fracedelDia(),
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

  Widget textUltimasNoticias() {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Último minuto',
          style:
              TextStyle(color: Color.fromRGBO(94, 145, 254, 1), fontSize: 20),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Widget testwidget() {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
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
                    launchInBrowser(snapshot.data![index + 2]);
                  },
                  title: Text(
                    '${snapshot.data![index]}',
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
      future: getUltimoMinuto(),
    );
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
          _imageTable('assets/images/link_cubadebate.png', 'Cubadebate',
              'http://www.cubadebate.cu/'),
          _imageTable('assets/images/link_ecured.png', 'Ecured',
              'https://www.ecured.cu/EcuRed:Enciclopedia_cubana'),
        ]),
        TableRow(children: [
          _imageTable('assets/images/reflej.png', 'Blogs Reflejos',
              'https://cubava.cu/'),
          _imageTable(
              'assets/images/ofertas.png', 'Ofertas.cu', 'http://ofertas.cu/'),
        ]),
        TableRow(children: [
          _imageTable(
              'assets/images/toDus.png', 'toDus app', 'https://todus.cu/'),
          _imageTable(
              'assets/images/apklis.png', 'Apklis', 'https://www.apklis.cu/'),
        ]),
        TableRow(children: [
          _imageTable('assets/images/link_infomed.png', 'Red Salud Cubana',
              'https://www.sld.cu/'),
          _imageTable('assets/images/link_cubaeduca.png',
              ' Comunidad Educativa', 'https://www.cubaeduca.cu/'),
        ]),
        TableRow(children: [
          _imageTable('assets/images/papeleta.png', 'Cartelera Cultural',
              'http://lapapeleta.cu/'),
          _imageTable('assets/images/logoacn.png', 'ACN', 'http://www.acn.cu/'),
        ]),
        TableRow(children: [
          _imageTable('assets/images/consola.jpg', 'SEO WebMas',
              'https://seowebmas.redcuba.cu/'),
          _imageTable(
              'assets/images/picta.jpg', 'Picta', 'https://www.picta.cu/home'),
        ])
      ],
    );
  }

  Widget _imageTable(String ruta_foto, String web_url, String url) {
    return InkWell(
      onTap: () {
        launchInBrowser(url);
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

  Widget _fracedelDia() {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Text(
            'Frase del  día',
            style: TextStyle(fontSize: 10),
          ),
          SizedBox(
            width: 20,
          ),
          Text('Ser culto es bla bla')
        ],
      ),
    );
  }
}
