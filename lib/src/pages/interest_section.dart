import 'package:flutter/material.dart';
import 'package:prueba_sections_flutter/src/bloc/interest_provider.dart';
import 'package:prueba_sections_flutter/src/models/firebase_model.dart';

class InterestSection extends StatefulWidget {
  InterestSection({ Key? key }) : super(key: key);

  @override
  _InterestSectionState createState() => _InterestSectionState();
}

class _InterestSectionState extends State<InterestSection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = InterestProvider.of(context);

    bloc.getInterest();

    return StreamBuilder(
      stream: bloc.listInterestStream,
      builder: (context, AsyncSnapshot<List<FirebaseModel>> snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: Text("Cargando Datos"),
          );
        }
        final listInterest = snapshot.data!;
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
                  stream: bloc.selectAllInterestStream,
                  builder: (context, snapshot) {
                    return Checkbox(
                      value: bloc.selectAllInterestValue, 
                      side: BorderSide(
                        color: Colors.yellow
                      ),
                      checkColor: Colors.white,
                      activeColor: Colors.yellow,
                      onChanged: (value){
                        bloc.changeSelectAllInterest(value!);
                        if(bloc.selectAllInterestValue){
                          listInterest.forEach((element) { 
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
              height: size.height * 0.5,
              child: (!snapshot.hasData) ? 
                Center(
                  child: Text("Cargando Datos"),
                ): GridView.builder(
                  itemCount: listInterest.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int i){
                    return Container(
                      width: size.width * 0.2,
                      height: size.height * 0.4,
                      alignment: Alignment.center,
                      child: TextButton(
                        child: Text(listInterest[i].name.toString()),
                        style: TextButton.styleFrom(
                          primary: (listInterest[i].avaliable! || bloc.selectAllInterestValue) ? Colors.yellow:Colors.grey,
                        ),
                        onPressed: (){
                          if(listInterest[i].avaliable!){
                            FirebaseModel model = FirebaseModel(
                              id: listInterest[i].id,
                              name: listInterest[i].name,
                              avaliable: false
                            );
                            bloc.elegirInterest(model);
                            bloc.listaGeneral.remove(listInterest[i]);
                          }else{
                            FirebaseModel model = FirebaseModel(
                              id: listInterest[i].id,
                              name: listInterest[i].name,
                              avaliable: true
                            );
                            bloc.elegirInterest(model);
                            bloc.listaGeneral.add(listInterest[i]);
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