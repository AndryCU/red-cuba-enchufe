import 'dart:async';

import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:red_cuba/models/noticias_model.dart';
import 'package:red_cuba/utiles/preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsProvider {
  List<String> _ultimo_minuto = [];
  final prefs = new PreferenciasUsuario();
  final _newsStreamController = StreamController<List<Noticias>>.broadcast();
  Function(List<Noticias>) get newsSink => _newsStreamController.sink.add;
  Stream<List<Noticias>> get newsStream => _newsStreamController.stream;
  void disposeStreams() {
    _newsStreamController.close();
  }

  Future<List<String>> getUltimoMinuto() async {
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
      _ultimo_minuto.add(new1);
      _ultimo_minuto.add(new2);

      String href1 = documento
          .getElementsByClassName('ultimo-minuto padding-rl-0')[0]
          .children[0]
          .children[0]
          .attributes['href']
          .toString();
      String href2 = documento
          .getElementsByClassName('ultimo-minuto padding-rl-0')[0]
          .children[1]
          .children[0]
          .attributes['href']
          .toString();

      _ultimo_minuto.add(href1);
      _ultimo_minuto.add(href2);
    }

    return _ultimo_minuto;
  }

  Future<List<Noticias>> getTodoResults(String busqueda) async {
    List<Noticias> todo_results = [];
    String title = '';
    String url = '';
    String subtitle = '';
    final response = await http.Client().get(Uri.parse(
        'https://www.redcuba.cu/web/webResults/$busqueda?_query=$busqueda'));
    if (response.statusCode == 200) {
      var documento = parser.parse(response.body);
      for (var i = 0; i < 10; i++) {
        title = documento
            .getElementsByClassName('results-page')[0]
            .children[i]
            .children[0]
            .text
            .trim();
        subtitle = documento
            .getElementsByClassName('results-page')[0]
            .children[i]
            .children[2]
            .children[1]
            .text
            .trim();
        url = documento
            .getElementsByClassName('results-page')[0]
            .children[i]
            .children[0]
            .attributes['href']
            .toString();
        todo_results.add(Noticias(title, subtitle, url));
      }
    }
    newsSink(todo_results);
    prefs.load = false;
    return todo_results;
  }

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
