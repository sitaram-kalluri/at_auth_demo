class HealthInfo {
  late String bloodGroup;
  late String bloodPressure;
  late String heightInInches;
  late String weightInKgs;

  HealthInfo();

  @override
  String toString() {
    var info = {
      "bloodGroup": bloodGroup,
      "bloodPressure": bloodPressure,
      "height": heightInInches,
      "weight": weightInKgs
    };
    return info.toString();
  }
}
