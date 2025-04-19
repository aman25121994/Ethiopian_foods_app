import 'dart:convert';

class User {
  //define fields
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  User(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.state,
      required this.city,
      required this.locality,
      required this.password,
      required this.token});
//Serialaization: Convert User Object to a Map
//Map: A Map is a collection of key-value pairs
//Why: Converting to a map is an intermidiate step that makes it easier to serialize
//the Object to formats like Json for storage or transission.

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "fullName": fullName,
      "email": email,
      "state": state,
      "city": city,
      "locality": locality,
      "password": password,
      "token": token,
    };
  }

  //Serialization: Convert Map to a JSON String
  //This method directly encodes the data from the Map into a Json String

  //The json.encode() function converts a Dart object(such as Map or List)
  //into a JSON String representation, making it suitable for communication
  //between different systems.
  String toJson() => json.encode(toMap());

  // Deserializtion: convert a Map to a User object
  // purpose - Manipulation and user : once the data is converted t a user object
  //it can be easily manipulated and used within the application. For example
  //we might want to display the users fullname,email etc.. on the UI. or we might
  //want to save the data locally.

  //the factory constructor takes a Map(Usually obtained from a json object)
  //and convert it into a user object. if the field is not present in the Map,
  //it defaults to an empty String.

  //fromMap: this constructor take a Mao<String,dynamic> and converts into a user object
  //, it is usefull when you already ave the data in a map format.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String? ?? "",
      fullName: map['fullName'] as String? ?? "",
      email: map['email'] as String? ?? "",
      state: map['state'] as String? ?? "",
      city: map['city'] as String? ?? "",
      locality: map['locality'] as String? ?? "",
      password: map['password'] as String? ?? "",
      token: map['token'] as String? ?? "",
    );
  }

  //fromJson: this factoy constructor takes json string decodes into a map<string,dynamic>
  //and then uses the fromMap to convert that Map into a user object.

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
