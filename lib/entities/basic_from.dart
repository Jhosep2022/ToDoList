

import 'package:flutter/cupertino.dart';

class BasicFrom{
  final TextEditingController _name = TextEditingController();

  List<String> _options = [];
  String _selectedValue = "";

  BasicFrom(options){
    _options = options;
    _selectedValue = options[0];
  }

  TextEditingController get name => _name;

  String get getSelectedValue => _selectedValue;
  void setSelectedValue(String selectedValue){
    _selectedValue = selectedValue;
  }
  List<String> get getOptions => _options;
}