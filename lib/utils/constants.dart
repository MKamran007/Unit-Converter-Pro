import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'Unit Converter Pro';
  static const String appVersion = '1.0.0';
  static const String developerName = 'Muhammad Kamran'; // Change this
  static const String developerEmail = 'youremail@example.com'; // Change this

  // Conversion Categories
  static const String categoryLength = 'Length';
  static const String categoryWeight = 'Weight';
  static const String categoryTemperature = 'Temperature';
  static const String categoryVolume = 'Volume';
  static const String categoryArea = 'Area';
  static const String categorySpeed = 'Speed';

  // Category Icons
  static const IconData iconLength = Icons.straighten;
  static const IconData iconWeight = Icons.fitness_center;
  static const IconData iconTemperature = Icons.thermostat;
  static const IconData iconVolume = Icons.water_drop;
  static const IconData iconArea = Icons.crop_square;
  static const IconData iconSpeed = Icons.speed;

  // Length Units
  static const List<String> lengthUnits = [
    'Meters',
    'Kilometers',
    'Centimeters',
    'Millimeters',
    'Miles',
    'Yards',
    'Feet',
    'Inches',
  ];

  // Weight Units
  static const List<String> weightUnits = [
    'Kilograms',
    'Grams',
    'Milligrams',
    'Pounds',
    'Ounces',
    'Tons',
  ];

  // Temperature Units
  static const List<String> temperatureUnits = [
    'Celsius',
    'Fahrenheit',
    'Kelvin',
  ];

  // Volume Units
  static const List<String> volumeUnits = [
    'Liters',
    'Milliliters',
    'Gallons (US)',
    'Quarts (US)',
    'Pints (US)',
    'Cups',
    'Fluid Ounces',
  ];

  // Area Units
  static const List<String> areaUnits = [
    'Square Meters',
    'Square Kilometers',
    'Square Centimeters',
    'Square Miles',
    'Square Yards',
    'Square Feet',
    'Acres',
    'Hectares',
  ];

  // Speed Units
  static const List<String> speedUnits = [
    'Meters/Second',
    'Kilometers/Hour',
    'Miles/Hour',
    'Feet/Second',
    'Knots',
  ];

  // Get units for a category
  static List<String> getUnitsForCategory(String category) {
    switch (category) {
      case categoryLength:
        return lengthUnits;
      case categoryWeight:
        return weightUnits;
      case categoryTemperature:
        return temperatureUnits;
      case categoryVolume:
        return volumeUnits;
      case categoryArea:
        return areaUnits;
      case categorySpeed:
        return speedUnits;
      default:
        return [];
    }
  }

  // Get icon for a category
  static IconData getIconForCategory(String category) {
    switch (category) {
      case categoryLength:
        return iconLength;
      case categoryWeight:
        return iconWeight;
      case categoryTemperature:
        return iconTemperature;
      case categoryVolume:
        return iconVolume;
      case categoryArea:
        return iconArea;
      case categorySpeed:
        return iconSpeed;
      default:
        return Icons.calculate;
    }
  }

  // Get color for a category
  static Color getColorForCategory(String category) {
    switch (category) {
      case categoryLength:
        return const Color(0xFF2196F3); // Blue
      case categoryWeight:
        return const Color(0xFFFF5722); // Deep Orange
      case categoryTemperature:
        return const Color(0xFFF44336); // Red
      case categoryVolume:
        return const Color(0xFF03A9F4); // Light Blue
      case categoryArea:
        return const Color(0xFF4CAF50); // Green
      case categorySpeed:
        return const Color(0xFF9C27B0); // Purple
      default:
        return const Color(0xFF607D8B); // Blue Grey
    }
  }

  // All categories list
  static const List<String> allCategories = [
    categoryLength,
    categoryWeight,
    categoryTemperature,
    categoryVolume,
    categoryArea,
    categorySpeed,
  ];

  // SharedPreferences Keys
  static const String keyThemeMode = 'theme_mode';
  static const String keyConversionHistory = 'conversion_history';
  static const String keyFavorites = 'favorites';

  // UI Constants
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;

  // Animation Durations
  static const Duration animationShort = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationLong = Duration(milliseconds: 500);

  // Number Formatting
  static const int maxDecimalPlaces = 6;

  // Error Messages
  static const String errorInvalidInput = 'Please enter a valid number';
  static const String errorConversionFailed = 'Conversion failed. Please try again.';
  static const String errorEmptyInput = 'Please enter a value to convert';
}