import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/conversion_history.dart';
import '../utils/constants.dart';
import '../utils/conversion_logic.dart';

class ConversionProvider extends ChangeNotifier {
  // Current conversion state
  String _selectedCategory = AppConstants.categoryLength;
  String _fromUnit = AppConstants.lengthUnits[0];
  String _toUnit = AppConstants.lengthUnits[1];
  String _inputValue = '';
  String _resultValue = '';

  // History and favorites
  List<ConversionHistory> _history = [];
  List<String> _favorites = [];

  SharedPreferences? _prefs;

  ConversionProvider() {
    _loadData();
  }

  // Getters
  String get selectedCategory => _selectedCategory;
  String get fromUnit => _fromUnit;
  String get toUnit => _toUnit;
  String get inputValue => _inputValue;
  String get resultValue => _resultValue;
  List<ConversionHistory> get history => _history;
  List<ConversionHistory> get favoriteHistory =>
      _history.where((h) => h.isFavorite).toList();

  // Get units for current category
  List<String> get currentUnits =>
      AppConstants.getUnitsForCategory(_selectedCategory);

  // Load saved data from SharedPreferences
  Future<void> _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadHistory();
    await _loadFavorites();
  }

  // Load conversion history
  Future<void> _loadHistory() async {
    final historyJson = _prefs?.getString(AppConstants.keyConversionHistory);
    if (historyJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(historyJson);
        _history = decoded
            .map((item) => ConversionHistory.fromJson(item))
            .toList();
        notifyListeners();
      } catch (e) {
        debugPrint('Error loading history: $e');
      }
    }
  }

  // Save conversion history
  Future<void> _saveHistory() async {
    try {
      final historyJson = jsonEncode(
        _history.map((item) => item.toJson()).toList(),
      );
      await _prefs?.setString(AppConstants.keyConversionHistory, historyJson);
    } catch (e) {
      debugPrint('Error saving history: $e');
    }
  }

  // Load favorites
  Future<void> _loadFavorites() async {
    _favorites = _prefs?.getStringList(AppConstants.keyFavorites) ?? [];
  }

  // Save favorites
  Future<void> _saveFavorites() async {
    await _prefs?.setStringList(AppConstants.keyFavorites, _favorites);
  }

  // Set category and reset units
  void setCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      final units = AppConstants.getUnitsForCategory(category);
      _fromUnit = units.isNotEmpty ? units[0] : '';
      _toUnit = units.length > 1 ? units[1] : units[0];
      _inputValue = '';
      _resultValue = '';
      notifyListeners();
    }
  }

  // Set from unit
  void setFromUnit(String unit) {
    if (_fromUnit != unit) {
      _fromUnit = unit;
      if (_inputValue.isNotEmpty) {
        _performConversion();
      }
      notifyListeners();
    }
  }

  // Set to unit
  void setToUnit(String unit) {
    if (_toUnit != unit) {
      _toUnit = unit;
      if (_inputValue.isNotEmpty) {
        _performConversion();
      }
      notifyListeners();
    }
  }

  // Swap from and to units
  void swapUnits() {
    final temp = _fromUnit;
    _fromUnit = _toUnit;
    _toUnit = temp;

    // Also swap values
    final tempValue = _inputValue;
    _inputValue = _resultValue;
    _resultValue = tempValue;

    notifyListeners();
  }

  // Set input value and perform conversion
  void setInputValue(String value) {
    _inputValue = value;

    if (value.isEmpty) {
      _resultValue = '';
    } else if (ConversionLogic.isValidInput(value)) {
      _performConversion();
    } else {
      _resultValue = 'Invalid input';
    }

    notifyListeners();
  }

  // Perform the actual conversion
  void _performConversion() {
    try {
      final inputDouble = double.parse(_inputValue);
      final result = ConversionLogic.convert(
        inputDouble,
        _fromUnit,
        _toUnit,
        _selectedCategory,
      );
      _resultValue = ConversionLogic.formatResult(result);
    } catch (e) {
      _resultValue = 'Error';
      debugPrint('Conversion error: $e');
    }
  }

  // Clear input and result
  void clear() {
    _inputValue = '';
    _resultValue = '';
    notifyListeners();
  }

  // Save current conversion to history
  Future<void> saveToHistory() async {
    if (_inputValue.isEmpty || _resultValue.isEmpty || _resultValue == 'Error') {
      return;
    }

    try {
      final inputDouble = double.parse(_inputValue);
      final resultDouble = double.parse(_resultValue.replaceAll(',', ''));

      final historyItem = ConversionHistory(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        category: _selectedCategory,
        inputValue: inputDouble,
        fromUnit: _fromUnit,
        toUnit: _toUnit,
        resultValue: resultDouble,
        timestamp: DateTime.now(),
      );

      _history.insert(0, historyItem);

      // Keep only last 50 items
      if (_history.length > 50) {
        _history = _history.sublist(0, 50);
      }

      await _saveHistory();
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving to history: $e');
    }
  }

  // Toggle favorite status of a history item
  Future<void> toggleFavorite(String id) async {
    final index = _history.indexWhere((item) => item.id == id);
    if (index != -1) {
      _history[index] = _history[index].copyWith(
        isFavorite: !_history[index].isFavorite,
      );
      await _saveHistory();
      notifyListeners();
    }
  }

  // Delete a history item
  Future<void> deleteHistoryItem(String id) async {
    _history.removeWhere((item) => item.id == id);
    await _saveHistory();
    notifyListeners();
  }

  // Clear all history
  Future<void> clearHistory() async {
    _history.clear();
    await _saveHistory();
    notifyListeners();
  }

  // Clear only non-favorite history
  Future<void> clearNonFavoriteHistory() async {
    _history.removeWhere((item) => !item.isFavorite);
    await _saveHistory();
    notifyListeners();
  }

  // Load a history item into current conversion
  void loadHistoryItem(ConversionHistory item) {
    _selectedCategory = item.category;
    _fromUnit = item.fromUnit;
    _toUnit = item.toUnit;
    _inputValue = item.inputValue.toString();
    _resultValue = item.resultValue.toString();
    notifyListeners();
  }

  // Search history
  List<ConversionHistory> searchHistory(String query) {
    if (query.isEmpty) return _history;

    final lowerQuery = query.toLowerCase();
    return _history.where((item) {
      return item.category.toLowerCase().contains(lowerQuery) ||
          item.fromUnit.toLowerCase().contains(lowerQuery) ||
          item.toUnit.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // Get history for specific category
  List<ConversionHistory> getHistoryByCategory(String category) {
    return _history.where((item) => item.category == category).toList();
  }
}