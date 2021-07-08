import 'package:flutter/material.dart';
import 'package:prueba_sections_flutter/src/bloc/interest_bloc.dart';

// ignore: must_be_immutable
class InterestProvider extends InheritedWidget{

  static InterestProvider? _instancia;
  factory InterestProvider({Key? key, required Widget child}){
    /*if(_instancia == null){
       _instancia = new InterestProvider._internal(key: key,child: child,);
    }*/
    _instancia = new InterestProvider._internal(key: key,child: child,);

    return _instancia!;
  }

  InterestProvider._internal({ Key? key, required Widget child}): super(key: key, child: child);
  InterestBloc interestBloc = InterestBloc();
  
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static InterestBloc of (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<InterestProvider>()!.interestBloc;
  }
}