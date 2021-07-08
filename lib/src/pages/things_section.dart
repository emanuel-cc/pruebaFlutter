import 'package:flutter/material.dart';
import 'package:prueba_sections_flutter/src/bloc/interest_provider.dart';
import 'package:prueba_sections_flutter/src/models/firebase_model.dart';

class ThingsSubSection extends StatefulWidget {
  const ThingsSubSection({ Key? key }) : super(key: key);

  @override
  _ThingsSubSectionState createState() => _ThingsSubSectionState();
}

class _ThingsSubSectionState extends State<ThingsSubSection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = InterestProvider.of(context);
    
    bloc.getVarios();

    return StreamBuilder(
      stream: bloc.listVariosStream,
      builder: (context, AsyncSnapshot<List<FirebaseModel>> snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: Text("Cargando Datos"),
          );
        }else{
          final listThing = snapshot.data!;
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
                    stream: bloc.selectAllThingStream,
                    builder: (context, snapshot) {
                      return Checkbox(
                        value: bloc.selectAllThingValue, 
                        side: BorderSide(
                          color: Colors.yellow
                        ),
                        checkColor: Colors.white,
                        activeColor: Colors.yellow,
                        onChanged: (value){
                          bloc.changeSelectAllThing(value!);
                          if(bloc.selectAllThingValue){
                            listThing.forEach((element) { 
                              bloc.listaGeneral.add(element);
                            });
                          }else{
                            bloc.listaGeneral.clear();
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
                height: size.height * 0.4,
                child: (!snapshot.hasData)? 
                  Center(
                    child: Text("Cargando Datos"),
                  ):GridView.builder(
                    itemCount: listThing.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
                    itemBuilder: (BuildContext context, int i){
                      return Container(
                        width: size.width * 0.2,
                        height: size.height * 0.4,
                        alignment: Alignment.center,
                        child: TextButton(
                          child: Text(listThing[i].name.toString()),
                          style: TextButton.styleFrom(
                            primary: (listThing[i].avaliable! || bloc.selectAllThingValue) ? Colors.yellow:Colors.grey,
                          ),
                          onPressed: (){
                            if(listThing[i].avaliable!){
                              FirebaseModel model = FirebaseModel(
                                id: listThing[i].id,
                                name: listThing[i].name,
                                avaliable: false
                              );
                              bloc.elegirThing(model);
                              bloc.listaGeneral.remove(listThing[i]);
                            }else{
                              FirebaseModel model = FirebaseModel(
                                id: listThing[i].id,
                                name: listThing[i].name,
                                avaliable: true
                              );
                              bloc.elegirThing(model);
                              bloc.listaGeneral.add(listThing[i]);
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
      }
    );
  }
}