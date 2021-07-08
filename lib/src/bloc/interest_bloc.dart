import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prueba_sections_flutter/src/models/firebase_model.dart';
import 'package:prueba_sections_flutter/src/pages/drink_section.dart';
import 'package:prueba_sections_flutter/src/pages/food_section.dart';
import 'package:prueba_sections_flutter/src/pages/interest_section.dart';
import 'package:prueba_sections_flutter/src/pages/others_section.dart';
import 'package:prueba_sections_flutter/src/pages/sports_section.dart';
import 'package:prueba_sections_flutter/src/pages/things_section.dart';
import 'package:prueba_sections_flutter/src/providers/info_provider.dart';
import 'package:rxdart/rxdart.dart';

class InterestBloc {
  final _controller = BehaviorSubject<String>();
  final _subsectionController = BehaviorSubject<String>();
  final _listaSportsController = BehaviorSubject<List<FirebaseModel>>();
  final _listaInterestController = BehaviorSubject<List<FirebaseModel>>();
  final _listaFoodsController = BehaviorSubject<List<FirebaseModel>>();
  final _listaDrinksController = BehaviorSubject<List<FirebaseModel>>();
  final _listaVariosController = BehaviorSubject<List<FirebaseModel>>();
  final _sportController = BehaviorSubject<FirebaseModel>();
  final _interestController = BehaviorSubject<FirebaseModel>();
  final _foodController = BehaviorSubject<FirebaseModel>();
  final _drinkController = BehaviorSubject<FirebaseModel>();
  final _thingController = BehaviorSubject<FirebaseModel>();
  final _sportAvailableController = BehaviorSubject<bool>();
  final _interestAvailableController = BehaviorSubject<bool>(); 
  final _foodAvailableController = BehaviorSubject<bool>(); 
  final _drinkAvailableController = BehaviorSubject<bool>();
  final _thingAvailableController = BehaviorSubject<bool>();
  final _selectAllController = BehaviorSubject<bool>();
  final _selectAllInterestController = BehaviorSubject<bool>();
  final _selectAllFoodController = BehaviorSubject<bool>();
  final _selectAllDrinkController = BehaviorSubject<bool>();
  final _selectAllThingController = BehaviorSubject<bool>();
  
  List<FirebaseModel> listaGeneral = [];
  List<String> listaTemp = [];
  List<FirebaseModel> listaFirebase = [];
  List<FirebaseModel> listaFirebaseInterest = [];
  List<String> listaInterest = [];
  FirebaseModel firebaseModel = FirebaseModel();
  List<FirebaseModel> listaSportsTemp = [];
  List<FirebaseModel> listaInterestsTemp = [];
  List<FirebaseModel> listaFoodTemp = [];
  List<FirebaseModel> listaDrinkTemp = [];
  List<FirebaseModel> listaThingTemp = [];

  final infoProvider = InfoProvider();

  //Se escucha la información
  Stream<String> get pageStream => _controller.stream;
  Stream<String> get subSectionStream => _subsectionController.stream;
  Stream<List<FirebaseModel>> get listSportStream => _listaSportsController.stream;
  Stream<List<FirebaseModel>> get listInterestStream => _listaInterestController.stream;
  Stream<List<FirebaseModel>> get listFoodsStream => _listaFoodsController.stream;
  Stream<List<FirebaseModel>> get listDrinksStream => _listaDrinksController.stream;
  Stream<List<FirebaseModel>> get listVariosStream => _listaVariosController.stream;
  Stream<FirebaseModel> get sportStream => _sportController.stream;
  Stream<FirebaseModel> get interestStream => _interestController.stream;
  Stream<FirebaseModel> get foodStream => _foodController.stream;
  Stream<FirebaseModel> get drinkStream => _drinkController.stream;
  Stream<FirebaseModel> get thingStream => _thingController.stream;
  Stream<bool> get availableStream => _sportAvailableController.stream;
  Stream<bool> get availableInterestStream => _interestAvailableController.stream;
  Stream<bool> get availableFoodStream => _foodAvailableController.stream;
  Stream<bool> get availableDrinkStream => _drinkAvailableController.stream;
  Stream<bool> get availableThingStream => _thingAvailableController.stream;
  Stream<bool> get selectAllStream{
    if(_selectAllController.hasValue){
      return _selectAllController.stream;
    }else{
      changeSelectAll(false);
      return _selectAllController.stream;
    }
  }

  Stream<bool> get selectAllInterestStream{
    if(_selectAllInterestController.hasValue){
      return _selectAllInterestController.stream;
    }else{
      changeSelectAllInterest(false);
      return _selectAllInterestController.stream;
    }
  }
  Stream<bool> get selectAllFoodStream{
    if(_selectAllFoodController.hasValue){
      return _selectAllFoodController.stream;
    }else{
      changeSelectAllFood(false);
      return _selectAllFoodController.stream;
    }
  }
  Stream<bool> get selectAllDrinkStream{
    if(_selectAllDrinkController.hasValue){
      return _selectAllDrinkController.stream;
    }else{
      changeSelectAllDrink(false);
      return _selectAllDrinkController.stream;
    }
  }
  Stream<bool> get selectAllThingStream{
    if(_selectAllThingController.hasValue){
      return _selectAllThingController.stream;
    }else{
      changeSelectAllThing(false);
      return _selectAllThingController.stream;
    }
  }

  //Se agregan al stream
  Function(String) get changePage => _controller.sink.add;
  Function(String) get changeSubsection => _subsectionController.sink.add;
  Function(List<FirebaseModel>) get changeListSports => _listaSportsController.sink.add;
  Function(List<FirebaseModel>) get changeListInterest => _listaInterestController.sink.add;
  Function(List<FirebaseModel>) get changeListFoods => _listaFoodsController.sink.add;
  Function(List<FirebaseModel>) get changeListDrinks => _listaDrinksController.sink.add;
  Function(List<FirebaseModel>) get changeListVarios => _listaVariosController.sink.add;
  Function(FirebaseModel) get changeSport => _sportController.sink.add;
  Function(FirebaseModel) get changeInterest => _interestController.sink.add;
  Function(FirebaseModel) get changeFood => _foodController.sink.add;
  Function(FirebaseModel) get changeDrink => _drinkController.sink.add;
  Function(FirebaseModel) get changeThing => _thingController.sink.add;
  Function(bool) get changeAvailable => _sportAvailableController.sink.add;
  Function(bool) get changeInterestAvailable => _interestAvailableController.sink.add;
  Function(bool) get changeFoodAvailable => _foodAvailableController.sink.add;
  Function(bool) get changeDrinkAvailable => _drinkAvailableController.sink.add;
  Function(bool) get changeThingAvailable => _thingAvailableController.sink.add;
  Function(bool) get changeSelectAll => _selectAllController.sink.add;
  Function(bool) get changeSelectAllInterest => _selectAllInterestController.sink.add;
  Function(bool) get changeSelectAllFood => _selectAllFoodController.sink.add;
  Function(bool) get changeSelectAllDrink => _selectAllDrinkController.sink.add;
  Function(bool) get changeSelectAllThing => _selectAllThingController.sink.add;

  Widget getPage(){
    //changePage("Deportes");
    switch(_controller.value){
      case 'Deportes':
        return SportSection();
      case 'Interes':
        return InterestSection();
      case 'Otro':
        return OthersSection();
      default:
        return SportSection();
    }
  }

  Widget getSubsection(){
    switch(_subsectionController.value){
      case 'Alimentos':
        return FoodSubSection();
      case 'Bebidas':
        return DrinkSubSection();
      case 'Varios':
        return ThingsSubSection();
      default:
        return FoodSubSection();
    }
  }

  Future<List<FirebaseModel>> getSports()async{
    listaFirebase.clear();
    listaFirebase = await infoProvider.getSports();
    changeListSports(listaFirebase);
    return listaFirebase;
  } 

  Future<List<FirebaseModel>> getInterest()async{
    listaFirebase.clear();
    listaFirebase = await infoProvider.getInterestList();
    changeListInterest(listaFirebase);
    return listaFirebase;
  }

  Future<List<FirebaseModel>> getFoods()async{
    listaFirebase.clear();
    listaFirebase = await infoProvider.getFoods();
    changeListFoods(listaFirebase);
    return listaFirebase;
  }

  Future<List<FirebaseModel>> getDrinks()async{
    listaFirebase.clear();
    listaFirebase = await infoProvider.getDrinks();
    changeListDrinks(listaFirebase);
    return listaFirebase;
  }

  Future<List<FirebaseModel>> getVarios()async{
    listaFirebase.clear();
    listaFirebase = await infoProvider.getVarios();
    changeListVarios(listaFirebase);
    return listaFirebase;
  }

  Future<FirebaseModel> elegirSport(FirebaseModel sport)async{
    sport = await infoProvider.elegirSport(sport);
    changeSport(sport);
    infoProvider.getSports();
    changeAvailable(sport.avaliable!);
    return sport;
  }

  Future<FirebaseModel> elegirInterest(FirebaseModel interest)async{
    interest = await infoProvider.elegirInterest(interest);
    changeInterest(interest);
    infoProvider.getInterestList();
    changeInterestAvailable(interest.avaliable!);
    return interest;
  }

  Future<FirebaseModel> elegirFood(FirebaseModel food)async{
    food = await infoProvider.elegirFood(food);
    changeFood(food);
    infoProvider.getFoods();
    changeFoodAvailable(food.avaliable!);
    return food;
  }
  Future<FirebaseModel> elegirDrink(FirebaseModel drink)async{
    drink = await infoProvider.elegirDrink(drink);
    changeDrink(drink);
    infoProvider.getDrinks();
    changeDrinkAvailable(drink.avaliable!);
    return drink;
  }
  Future<FirebaseModel> elegirThing(FirebaseModel thing)async{
    thing = await infoProvider.elegirThing(thing);
    changeThing(thing);
    infoProvider.getVarios();
    changeThingAvailable(thing.avaliable!);
    return thing;
  }

  Stream<bool> get elementSelected =>
  Rx.combineLatest([availableStream], (a) => true);

  bool get sportAvailable{
    if(_sportController.hasValue){
      return _sportController.value.avaliable!;
    }else{
      return false;
    }
  }

  bool get interestAvailable{
    if(_interestController.hasValue){
      return _interestController.value.avaliable!;
    }else{
      return false;
    }
  }
  int get listaSportsSize{
    if(_listaSportsController.hasValue){
      return _listaSportsController.value.length;
    }else{
      return 0;
    }
  } 

  int get listaInterestSize{
    if(_listaInterestController.hasValue){
      return _listaInterestController.value.length;
    }else{
      return 0;
    }
  }

  int get listaFoodsSize{
    if(_listaFoodsController.hasValue){
      return _listaFoodsController.value.length;
    }else{
      return 0;
    }
  }

  int get listaDrinksSize{
    if(_listaDrinksController.hasValue){
      return _listaDrinksController.value.length;
    }else{
      return 0;
    }
  }

  int get listaVariosSize{
    if(_listaVariosController.hasValue){
      return _listaVariosController.value.length;
    }else{
      return 0;
    }
  }

  bool get selectAllValue{
    if(_selectAllController.hasValue){
      return _selectAllController.value;
    }else{
      return false;
    }
  } 

  bool get selectAllInterestValue{
    if(_selectAllInterestController.hasValue){
      return _selectAllInterestController.value;
    }else{
      return false;
    }
  }

  bool get selectAllFoodValue{
    if(_selectAllFoodController.hasValue){
      return _selectAllFoodController.value;
    }else{
      return false;
    }
  }
  bool get selectAllDrinkValue{
    if(_selectAllDrinkController.hasValue){
      return _selectAllDrinkController.value;
    }else{
      return false;
    }
  }
  bool get selectAllThingValue{
    if(_selectAllThingController.hasValue){
      return _selectAllThingController.value;
    }else{
      return false;
    }
  }

  void dispose(){
    _controller.close();
    _subsectionController.close();
    _listaSportsController.close();
    _listaInterestController.close();
    _listaFoodsController.close();
    _listaDrinksController.close();
    _listaVariosController.close();
    _sportController.close();
    _interestController.close();
    _foodController.close();
    _drinkController.close();
    _thingController.close();
    _sportAvailableController.close();
    _interestAvailableController.close();
    _foodAvailableController.close();
    _drinkAvailableController.close();
    _thingAvailableController.close();
    _selectAllController.close();
    _selectAllInterestController.close();
    _selectAllFoodController.close();
    _selectAllDrinkController.close();
    _selectAllThingController.close();
  }
}