import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Image.asset(
            'assets/images/logo.png',
            width: MediaQuery.of(context).size.width * 0.35,
          ),
        ),
        body: Container(
          child: Center(
            child: Column(children: [
              Container(
                child: Image.asset(
                  'assets/images/enchufe.jpg',
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
              ),
              Text(
                'Desarrollado por Enchufe',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
