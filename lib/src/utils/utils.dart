import 'package:flutter/material.dart';

void mostrarAlerta(BuildContext context, String mensaje){
  showDialog(
    context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Sigue sin elegir"),
        content: Text(mensaje),
        actions: [
          TextButton(
            child: Text("Ok"),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      );
    },
    barrierDismissible: false
  );
}