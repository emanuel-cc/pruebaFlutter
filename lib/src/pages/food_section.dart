import 'package:flutter/material.dart';
import 'package:prueba_sections_flutter/src/bloc/interest_provider.dart';
import 'package:prueba_sections_flutter/src/models/firebase_model.dart';

class FoodSubSection extends StatefulWidget {
  const FoodSubSection({ Key? key }) : super(key: key);

  @override
  _FoodSubSectionState createState() => _FoodSubSectionState();
}

class _FoodSubSectionState extends State<FoodSubSection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = InterestProvider.of(context);
    
    bloc.getFoods();

    return StreamBuilder(
      stream: bloc.listFoodsStream,
      builder: (context, AsyncSnapshot<List<FirebaseModel>> snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: Text("Cargando Datos"),
          );
        }else{
          final listFood = snapshot.data!;
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
                    stream: bloc.selectAllFoodStream,
                    builder: (context, snapshot) {
                      return Checkbox(
                        value: bloc.selectAllFoodValue, 
                        side: BorderSide(
                          color: Colors.yellow
                        ),
                        checkColor: Colors.white,
                        activeColor: Colors.yellow,
                        onChanged: (value){
                          bloc.changeSelectAllFood(value!);
                          if(bloc.selectAllFoodValue){
                            listFood.forEach((element) { 
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
                    itemCount: listFood.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
                    itemBuilder: (BuildContext context, int i){
                      return Container(
                        width: size.width * 0.2,
                        height: size.height * 0.4,
                        alignment: Alignment.center,
                        child: TextButton(
                          child: Text(listFood[i].name.toString()),
                          style: TextButton.styleFrom(
                            primary: (listFood[i].avaliable! || bloc.selectAllFoodValue) ? Colors.yellow:Colors.grey,
                          ),
                          onPressed: (){
                            if(listFood[i].avaliable!){
                              FirebaseModel model = FirebaseModel(
                                id: listFood[i].id,
                                name: listFood[i].name,
                                avaliable: false
                              );
                              bloc.elegirFood(model);
                              bloc.listaGeneral.remove(listFood[i]);
                            }else{
                              FirebaseModel model = FirebaseModel(
                                id: listFood[i].id,
                                name: listFood[i].name,
                                avaliable: true
                              );
                              bloc.elegirFood(model);
                              bloc.listaGeneral.add(listFood[i]);
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