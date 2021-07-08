import 'package:flutter/material.dart';
import 'package:prueba_sections_flutter/src/bloc/interest_bloc.dart';
import 'package:prueba_sections_flutter/src/bloc/interest_provider.dart';
import 'package:prueba_sections_flutter/src/models/firebase_model.dart';
import 'package:prueba_sections_flutter/src/providers/info_provider.dart';

class SportSection extends StatefulWidget {
  SportSection({ Key? key }) : super(key: key);

  @override
  _SportSectionState createState() => _SportSectionState();
}

class _SportSectionState extends State<SportSection> {

  //List<FirebaseModel> listaSportsTemp = [];
  
  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = InterestProvider.of(context);
    bloc.getSports();
    return StreamBuilder(
      stream: bloc.listSportStream,
      builder: (context, AsyncSnapshot<List<FirebaseModel>> snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: Text("Cargando Datos"),
          );
        }
        final listFirebase = snapshot.data!;
        return Column(
          children: [
            Text(
              "Selecciona los que más te gusten",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Selecciona todos"
                ),
                StreamBuilder(
                  stream: bloc.selectAllStream,
                  builder: (context, snapshot) {
                    return Checkbox(
                      value: bloc.selectAllValue,
                      side: BorderSide(
                        color: Colors.yellow
                      ),
                      checkColor: Colors.white,
                      activeColor: Colors.yellow,
                      onChanged: (value){
                        bloc.changeSelectAll(value!);
                        if(bloc.selectAllValue){
                          
                          listFirebase.forEach((element) {
                            bloc.listaSportsTemp.add(element);
                          });
                          bloc.listaSportsTemp.forEach((element) { 
                            bloc.listaGeneral.add(element);
                          });
                        }else{
                          bloc.listaSportsTemp.clear();
                          if(bloc.listaSportsTemp.isEmpty){
                            bloc.listaGeneral.clear();
                          }
                        }
                        setState(() {});
                      }
                    );
                  }
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              width: size.width * 1.0,
              height: size.height * 0.5,
              child: (!snapshot.hasData) ? 
                Center(
                  child: Text("Cargando Datos"),
                ): GridView.builder(
                  itemCount: listFirebase.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
                  itemBuilder: (BuildContext context, int i){
                    return Container(
                      width: size.width * 0.2,
                      height: size.height * 0.4,
                      alignment: Alignment.center,
                      child: TextButton(
                        child: Text(listFirebase[i].name.toString()),
                        style: TextButton.styleFrom(
                          primary: (listFirebase[i].avaliable! || bloc.selectAllValue) ? Colors.yellow : Colors.grey,
                        ),
                        onPressed: (){
                          
                          if(listFirebase[i].avaliable!){
                            FirebaseModel model = FirebaseModel(
                              id: listFirebase[i].id,
                              name: listFirebase[i].name,
                              avaliable: false
                            );
                            //print("Model");
                            //print(model.avaliable);
                            bloc.elegirSport(model);
                            bloc.listaGeneral.remove(listFirebase[i]);
                          }else{
                            FirebaseModel model = FirebaseModel(
                              id: listFirebase[i].id,
                              name: listFirebase[i].name,
                              avaliable: true
                            );
                            //print("Model");
                            //print(model.avaliable);
                            bloc.elegirSport(model);
                            bloc.listaGeneral.add(listFirebase[i]);
                            
                          }
                          setState(() {});
                        },
                      )
                    );
                  }
                )
              
            )
          ],
        );
      }
    );
  }
}