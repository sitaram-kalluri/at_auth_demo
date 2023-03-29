class ContactInfo {
  String phoneNumber = "";
  String email = "";

  ContactInfo();

  @override
  String toString() {
    var info = { "phoneNumber" : phoneNumber, "email": email };
    return info.toString();
  }
}
