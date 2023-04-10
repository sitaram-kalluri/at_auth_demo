import 'dart:convert';

class ContactInfo {
  String phoneNumber = "";
  String email = "";

  ContactInfo();

  @override
  String toString() {
    var info = { "phoneNumber" : phoneNumber, "email": email };
    return json.encode(info).toString();
  }
}
