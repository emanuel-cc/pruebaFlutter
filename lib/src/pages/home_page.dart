import 'package:flutter/material.dart';
import 'package:prueba_sections_flutter/src/bloc/interest_provider.dart';
import 'package:prueba_sections_flutter/src/pages/sports_section.dart';
import 'package:prueba_sections_flutter/src/utils/utils.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = InterestProvider.of(context);
    //bloc.changePage("Deportes");

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Text(
                "Lista de Intereses",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Una aplicación que lista los intereses comunes de un usuario"
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder(
                      stream: bloc.pageStream,
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return TextButton(
                            child: Text(
                              "Deportes".toUpperCase(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.yellow
                            ),
                            onPressed: (){
                              bloc.changePage("Deportes");
                              setState(() {});
                            }
                          );
                        }else{

                          return TextButton(
                            child: Text(
                              "Deportes".toUpperCase(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              primary: (snapshot.data == "Deportes") ? Colors.yellow:Colors.black
                            ),
                            onPressed: (){
                              bloc.changePage("Deportes");
                              setState(() {});
                            }
                          );
                        }
                      }
                    ),
                    StreamBuilder(
                      stream: bloc.pageStream,
                      builder: (context, snapshot) {
                        return TextButton(
                          child: Text(
                            "Interes".toUpperCase(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            primary: (snapshot.data == "Interes") ? Colors.yellow:Colors.black
                          ),
                          onPressed: (){
                            bloc.changePage("Interes");
                            setState(() {});
                          }
                        );
                      }
                    ),
                    StreamBuilder(
                      stream: bloc.pageStream,
                      builder: (context, snapshot) {
                        return TextButton(
                          child: Text(
                            "Otro".toUpperCase(),
                            style: TextStyle(
                              fontSize: 16.0
                            ),
                          ),
                          style: TextButton.styleFrom(
                            primary: (snapshot.data == "Otro") ? Colors.yellow:Colors.black
                          ),
                          onPressed: (){
                            bloc.changePage("Otro");
                            setState(() {});
                          }
                        );
                      }
                    )
                  ],
                ),
              ),
              //Se renderizan las secciones dinamicamente
              Container(
                height: size.height * 0.63,
                child: StreamBuilder(
                  stream: bloc.pageStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //bloc.changePage("Deportes");
                    if(snapshot.hasData){
                      return bloc.getPage();
                    }else{
                      return SportSection();
                    }
                    
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              OutlinedButton(
                child: Text(
                  "Guardar".toUpperCase(),
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.black
                  ),
                ),
                onPressed: (){
                  if(bloc.listaGeneral.isNotEmpty){
                    print("hay datos");
                    Navigator.pushNamed(context, 'result');
                  }else{
                    print("elige un dato");
                    print(bloc.listaGeneral.length);
                    mostrarAlerta(context, "No ha elegido nada, por favor elija algo de las opciones");
                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}