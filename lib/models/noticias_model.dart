class Noticias {
  String _title;
  String _subtitle;
  String _url;

  Noticias(this._title, this._subtitle, this._url);

  String get subtitle => _subtitle;

  set subtitle(String value) {
    _subtitle = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }
}
