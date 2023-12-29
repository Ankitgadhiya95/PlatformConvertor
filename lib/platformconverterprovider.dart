import 'package:flutter/material.dart';

class PlatformConverterProvider with ChangeNotifier {
  bool _isIos = false;
  bool theme = false;
  String name = '';
  String bio = '';
  String image = '';

  get isDarkMethod {
    return theme;
  }

  set setDarkTheme(bool value) {
    theme = value;
    notifyListeners();
  }

  get getName {
    return name;
  }

  set setName(value) {
    name = value;
    notifyListeners();
  }

  get getBio {
    return bio;
  }

  set setBio(value) {
    bio = value;
    notifyListeners();
  }

  get getImage {
    return image;
  }

  set setImage(value) {
    image = value;
    notifyListeners();
  }

  get isIos => _isIos;

  set isIos(value) {
    _isIos = value;
    notifyListeners();
  }
}
