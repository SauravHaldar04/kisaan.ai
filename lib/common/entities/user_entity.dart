// ignore_for_file: public_member_api_docs, sort_constructors_first
class  User {
  final String uid;
  final String email;
  final String name;
  final double landArea;
  final String irrigationMethod;


  User(this.name, this.landArea, this.irrigationMethod, {required this.uid, required this.email, });
}
