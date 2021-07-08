import 'package:flutter/material.dart';
import 'package:prueba_sections_flutter/src/bloc/interest_provider.dart';

class ResultPage extends StatefulWidget {

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = InterestProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Elementos seleccionados"
        ),
        elevation: 0.0,
      ),
      body: Container(
        width: size.width * 1.0,
        height: size.height * 0.9,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          itemCount: bloc.listaGeneral.length,
          itemBuilder: (BuildContext context, int i){
            return Container(
              width: size.width * 0.6,
              height: size.height * 0.1,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "- ${bloc.listaGeneral[i].name!}"
              ),
            );
          }
        )
      ),
    );
  }
}