import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: [_textShow(), _showSearchResults()],
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

  Widget _showSearchResults() {
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
