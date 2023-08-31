import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  
  bool _isSearching = false;
  bool get isSearching => _isSearching;

  searchToggle() {
    _isSearching = !_isSearching;
    notifyListeners();
  }
}
