import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService{
  final _switch = GetStorage();
  final _key = 'isDark';
  bool _themeStatus()=> _switch.read(_key)??false;
  _saveThemeStatus(bool themeStatus)=>_switch.write(_key, themeStatus);
  ThemeMode get theme => _themeStatus()?ThemeMode.dark:ThemeMode.light;
  void switchTheme(){
    Get.changeThemeMode(_themeStatus()?ThemeMode.light:ThemeMode.dark);
    _saveThemeStatus(!_themeStatus());
  }
}