// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:nfc3_overload_oblivion/common/entities/user_entity.dart';



class UserModel extends User {
  UserModel({
    required String uid,
    required String email,
    required String name,
    required double landArea,
    required String irrigationMethod,

  }) : super(
          name,
          landArea,
          irrigationMethod,
          uid: uid,
          email: email,
        );
  
  

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    double? landArea,
    String? irrigationMethod,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      landArea: landArea ?? this.landArea,
      irrigationMethod: irrigationMethod ?? this.irrigationMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'landArea': landArea,
      'irrigationMethod': irrigationMethod,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      landArea: map['landArea'] as double,
      irrigationMethod: map['irrigationMethod'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, landArea: $landArea, irrigationMethod: $irrigationMethod)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.email == email &&
      other.name == name &&
      other.landArea == landArea &&
      other.irrigationMethod == irrigationMethod;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      email.hashCode ^
      name.hashCode ^
      landArea.hashCode ^
      irrigationMethod.hashCode;
  }
}
