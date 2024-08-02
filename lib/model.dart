import 'dart:convert';



// ModelClass modelClassFromJson(String str) => ModelClass.fromJson(json.decode(str));
//
// String modelClassToJson(ModelClass data) => json.encode(data.toJson());
//
// class ModelClass {
//   List<City> city;
//   List<State> state;
//
//   ModelClass({
//     required this.city,
//     required this.state,
//   });
//
//   factory ModelClass.fromJson(Map<String, dynamic> json) => ModelClass(
//     city: List<City>.from(json["city"].map((x) => City.fromJson(x))),
//     state: List<State>.from(json["state"].map((x) => State.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "city": List<dynamic>.from(city.map((x) => x.toJson())),
//     "state": List<dynamic>.from(state.map((x) => x.toJson())),
//   };
// }
//
// class City {
//   int id;
//   String name;
//
//   City({
//     required this.id,
//     required this.name,
//   });
//
//   factory City.fromJson(Map<String, dynamic> json) => City(
//     id: json["id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//   };
// }
//
// class State {
//   int id;
//   String name;
//
//   State({
//     required this.id,
//     required this.name,
//   });
//
//   factory State.fromJson(Map<String, dynamic> json) => State(
//     id: json["id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//   };
// }






class ModelClass {
  List<City> city;
  List<State> state;

  ModelClass({
    required this.city,
    required this.state,
  });

  factory ModelClass.fromJson(Map<String, dynamic> json) =>
      ModelClass(
        city: List<City>.from(json["city"].map((x) => City.fromJson(x))),
        state: List<State>.from(json["state"].map((x) => State.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "city": List<dynamic>.from(city.map((x) => x.toJson())),
        "state": List<dynamic>.from(state.map((x) => x.toJson())),
      };
}
  class City {
  int id;
  String name;
  City({
  required this.id,
  required this.name,
  });
  factory City.fromJson(Map<String, dynamic> json) => City(
  id: json["id"],
  name: json["name"],
  );
  Map<String, dynamic> toJson() => {
  "id": id,
  "name": name,
  };
}



class State {
  int id;
  String name;

  State({
    required this.id,
    required this.name,
  });

  factory State.fromJson(Map<String, dynamic> json) =>
      State(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,

      };
}