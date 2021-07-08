import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_sections_flutter/src/bloc/interest_provider.dart';
import 'package:prueba_sections_flutter/src/models/firebase_model.dart';

class InfoProvider{
  final String _url = "pruebaflutter-7e700-default-rtdb.firebaseio.com";
  List<FirebaseModel> listaTemp = [];
  List<FirebaseModel> listaInterestTemp = [];
  List<FirebaseModel> listaFoodsTemp = [];
  List<FirebaseModel> listaDrinksTemp = [];
  List<FirebaseModel> listaVariosTemp = [];

  Future<List<FirebaseModel>> getSports()async{
    //String url = "$_url/sports";
    Uri uri = Uri.https(
      _url, 
      '/sports.json',
    );

    final resp = await http.get(uri);
    List<dynamic> decodedResp = json.decode(resp.body);
    decodedResp.forEach(
      (element) { 
        if(element != null){
          final infoTemp = FirebaseModel.fromJson(element);
          //infoTemp.id = int.parse(id);
          listaTemp.add(infoTemp);
        }
      }
    );
    //print("Respuesta Firebase");
    //print(listaTemp.first.id);
    return listaTemp;
  }

  Future<List<FirebaseModel>> getInterestList()async{
    Uri uri = Uri.https(
      _url, 
      '/interests.json',
    );
    final resp = await http.get(uri);
    List<dynamic> decodedResp = json.decode(resp.body);
    decodedResp.forEach(
      (element) { 
        if(element != null){
          final infoTemp = FirebaseModel.fromJson(element);
          //infoTemp.id = int.parse(id);
          listaInterestTemp.add(infoTemp);
        }
      }
    );
    //print("Respuesta Firebase");
    //print(listaInterestTemp.first.name);
    return listaInterestTemp;
  }

  Future<List<FirebaseModel>> getFoods()async{
    Uri uri = Uri.https(
      _url, 
      '/foods.json',
    );

    final resp = await http.get(uri);
    List<dynamic> decodedResp = json.decode(resp.body);
    decodedResp.forEach(
      (element) { 
        if(element != null){
          final infoTemp = FirebaseModel.fromJson(element);
          //infoTemp.id = int.parse(id);
          listaFoodsTemp.add(infoTemp);
        }
      }
    );
    //print("Respuesta Firebase");
    //print(listaFoodsTemp.first.name);
    return listaFoodsTemp;
  }

  Future<List<FirebaseModel>> getDrinks()async{
    Uri uri = Uri.https(
      _url, 
      '/drinks.json',
    );

    final resp = await http.get(uri);
    List<dynamic> decodedResp = json.decode(resp.body);
    decodedResp.forEach(
      (element) { 
        if(element != null){
          final infoTemp = FirebaseModel.fromJson(element);
          //infoTemp.id = int.parse(id);
          listaDrinksTemp.add(infoTemp);
        }
      }
    );
    //print("Respuesta Firebase");
    //print(listaFoodsTemp.first.name);
    return listaDrinksTemp;
  }

  Future<List<FirebaseModel>> getVarios()async{
    Uri uri = Uri.https(
      _url, 
      '/varios.json',
    );

    final resp = await http.get(uri);
    List<dynamic> decodedResp = json.decode(resp.body);
    decodedResp.forEach(
      (element) { 
        if(element != null){
          final infoTemp = FirebaseModel.fromJson(element);
          //infoTemp.id = int.parse(id);
          listaVariosTemp.add(infoTemp);
        }
      }
    );
    //print("Respuesta Firebase");
    //print(listaFoodsTemp.first.name);
    return listaVariosTemp;
  }

  Future<FirebaseModel> elegirSport(FirebaseModel sport)async{
    Uri uri = Uri.https(
      _url, 
      '/sports/${sport.id}.json',
    );

    final resp = await http.put(
      uri, body: json.encode(sport)
    );

    final decodedData = json.decode(resp.body);
    final firebaseModelTemp = FirebaseModel.fromJson(decodedData);
    print("Response Edit");
    print(firebaseModelTemp.toJson());
    return firebaseModelTemp;
  }

  Future<FirebaseModel> elegirInterest(FirebaseModel interest)async{
    Uri uri = Uri.https(
      _url, 
      '/interests/${interest.id}.json',
    );

    final resp = await http.put(
      uri, body: json.encode(interest)
    );

    final decodedData = json.decode(resp.body);
    final firebaseModelTemp = FirebaseModel.fromJson(decodedData);
    print("Response Edit");
    print(firebaseModelTemp.toJson());
    return firebaseModelTemp;
  }

  Future<FirebaseModel> elegirFood(FirebaseModel food)async{
    Uri uri = Uri.https(
      _url, 
      '/foods/${food.id}.json',
    );

    final resp = await http.put(
      uri, body: json.encode(food)
    );

    final decodedData = json.decode(resp.body);
    final firebaseModelTemp = FirebaseModel.fromJson(decodedData);
    print("Response Edit");
    print(firebaseModelTemp.toJson());
    return firebaseModelTemp;
  }
  Future<FirebaseModel> elegirDrink(FirebaseModel drink)async{
    Uri uri = Uri.https(
      _url, 
      '/drinks/${drink.id}.json',
    );

    final resp = await http.put(
      uri, body: json.encode(drink)
    );

    final decodedData = json.decode(resp.body);
    final firebaseModelTemp = FirebaseModel.fromJson(decodedData);
    print("Response Edit");
    print(firebaseModelTemp.toJson());
    return firebaseModelTemp;
  }
  Future<FirebaseModel> elegirThing(FirebaseModel thing)async{
    Uri uri = Uri.https(
      _url, 
      '/varios/${thing.id}.json',
    );

    final resp = await http.put(
      uri, body: json.encode(thing)
    );

    final decodedData = json.decode(resp.body);
    final firebaseModelTemp = FirebaseModel.fromJson(decodedData);
    print("Response Edit");
    print(firebaseModelTemp.toJson());
    return firebaseModelTemp;
  }
}