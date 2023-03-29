class PersonalInfo {
  String firstName = "";
  String lastName = "";
  int age = 0;
  String gender = "";

  PersonalInfo();

  @override
  String toString() {
    var info = { "firstName" : firstName, "lastName": lastName, "age": age, "gender": gender };
    return info.toString();
  }
}
