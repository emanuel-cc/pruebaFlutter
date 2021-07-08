import 'dart:convert';

List<FirebaseModel> firebaseModelFromJson(String str) => List<FirebaseModel>.from(json.decode(str).map((x) => FirebaseModel.fromJson(x)));

String firebaseModelToJson(List<FirebaseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FirebaseModel {
    int? id;
    String? name;
    bool? avaliable;

    FirebaseModel({
        this.id,
        this.name,
        this.avaliable,
    });

    factory FirebaseModel.fromJson(Map<String, dynamic> json) => FirebaseModel(
        id: json["id"],
        name: json["name"],
        avaliable: json["avaliable"],
    );

    Map<String, dynamic> toJson() => {
        "id"  : id,
        "name": name,
        "avaliable": avaliable,
    };
}
