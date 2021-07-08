import 'package:flutter/material.dart';
import 'package:prueba_sections_flutter/src/bloc/interest_provider.dart';
import 'package:prueba_sections_flutter/src/models/firebase_model.dart';

class DrinkSubSection extends StatefulWidget {
  const DrinkSubSection({ Key? key }) : super(key: key);

  @override
  _DrinkSubSectionState createState() => _DrinkSubSectionState();
}

class _DrinkSubSectionState extends State<DrinkSubSection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = InterestProvider.of(context);
    
    bloc.getDrinks();
    
    return StreamBuilder(
      stream: bloc.listDrinksStream,
      builder: (context,AsyncSnapshot<List<FirebaseModel>> snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: Text("Cargando Datos"),
          );
        }else{
          final listDrink = snapshot.data!;
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
                    stream: bloc.selectAllDrinkStream,
                    builder: (context, snapshot) {
                      return Checkbox(
                        value: bloc.selectAllDrinkValue, 
                        side: BorderSide(
                          color: Colors.yellow
                        ),
                        checkColor: Colors.white,
                        activeColor: Colors.yellow,
                        onChanged: (value){
                          bloc.changeSelectAllDrink(value!);
                          if(bloc.selectAllDrinkValue){
                            listDrink.forEach((element) { 
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
                child: (!snapshot.hasData) ?
                  Center(
                    child: Text("Cargando Datos"),
                  ):GridView.builder(
                    itemCount: listDrink.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
                    itemBuilder: (BuildContext context, int i){
                      return Container(
                        width: size.width * 0.2,
                        height: size.height * 0.4,
                        alignment: Alignment.center,
                        child: TextButton(
                          child: Text(listDrink[i].name.toString()),
                          style: TextButton.styleFrom(
                            primary: (listDrink[i].avaliable! || bloc.selectAllDrinkValue) ? Colors.yellow:Colors.grey,
                          ),
                          onPressed: (){
                            if(listDrink[i].avaliable!){
                              FirebaseModel model = FirebaseModel(
                                id: listDrink[i].id,
                                name: listDrink[i].name,
                                avaliable: false
                              );
                              bloc.elegirDrink(model);
                              bloc.listaGeneral.remove(listDrink[i]);
                            }else{
                              FirebaseModel model = FirebaseModel(
                                id: listDrink[i].id,
                                name: listDrink[i].name,
                                avaliable: true
                              );
                              bloc.elegirDrink(model);
                              bloc.listaGeneral.add(listDrink[i]);
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