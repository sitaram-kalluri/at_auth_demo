class PersonalInfo {
  String name = "";
  int age = 0;
  String gender = "";

  PersonalInfo();

  @override
  String toString() {
    var info = {"firstName": name, "age": age, "gender": gender};
    return info.toString();
  }
}
