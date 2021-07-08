import 'package:flutter/material.dart';
import 'package:prueba_sections_flutter/src/bloc/interest_provider.dart';
import 'package:prueba_sections_flutter/src/pages/food_section.dart';

class OthersSection extends StatefulWidget {
  OthersSection({ Key? key }) : super(key: key);

  @override
  _OthersSectionState createState() => _OthersSectionState();
}

class _OthersSectionState extends State<OthersSection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final interestBloc = InterestProvider.of(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              StreamBuilder(
                stream: interestBloc.subSectionStream,
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return TextButton(
                      child: Text(
                        "Alimentos".toUpperCase(),
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.yellow
                      ),
                      onPressed: (){
                        interestBloc.changeSubsection("Alimentos");
                        setState(() {});
                      }
                    );
                  }else{
                    return TextButton(
                      child: Text(
                        "Alimentos".toUpperCase(),
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: (snapshot.data == "Alimentos") ? Colors.yellow: Colors.black
                      ),
                      onPressed: (){
                        interestBloc.changeSubsection("Alimentos");
                        setState(() {});
                      }
                    );
                  }
                }
              ),
              StreamBuilder(
                stream: interestBloc.subSectionStream,
                builder: (context, snapshot) {
                  return TextButton(
                    child: Text(
                      "Bebidas".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: (snapshot.data == "Bebidas") ? Colors.yellow:Colors.black
                    ),
                    onPressed: (){
                      interestBloc.changeSubsection("Bebidas");
                      setState(() {});
                    }
                  );
                }
              ),
              StreamBuilder(
                stream: interestBloc.subSectionStream,
                builder: (context, snapshot) {
                  return TextButton(
                    child: Text(
                      "Varios".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: (snapshot.data == "Varios") ? Colors.yellow:Colors.black
                    ),
                    onPressed: (){
                      interestBloc.changeSubsection("Varios");
                      setState(() {});
                    }
                  );
                }
              )
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          width: size.width * 1.0,
          height: size.height * 0.5,
          child: StreamBuilder(
            stream: interestBloc.subSectionStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(!snapshot.hasData){
                return FoodSubSection();
              }else{
                return interestBloc.getSubsection();
              }
            },
          ),
        )
      ],
    );
  }
}