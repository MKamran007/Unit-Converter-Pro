import '../utils/constants.dart';

class ConversionLogic {
  // Main conversion method
  static double convert(
      double value,
      String fromUnit,
      String toUnit,
      String category,
      ) {
    if (value.isNaN || value.isInfinite) {
      throw ArgumentError('Invalid input value');
    }

    if (fromUnit == toUnit) {
      return value;
    }

    switch (category) {
      case AppConstants.categoryLength:
        return _convertLength(value, fromUnit, toUnit);
      case AppConstants.categoryWeight:
        return _convertWeight(value, fromUnit, toUnit);
      case AppConstants.categoryTemperature:
        return _convertTemperature(value, fromUnit, toUnit);
      case AppConstants.categoryVolume:
        return _convertVolume(value, fromUnit, toUnit);
      case AppConstants.categoryArea:
        return _convertArea(value, fromUnit, toUnit);
      case AppConstants.categorySpeed:
        return _convertSpeed(value, fromUnit, toUnit);
      default:
        throw ArgumentError('Unknown category: $category');
    }
  }

  // LENGTH CONVERSIONS (Base unit: Meters)
  static double _convertLength(double value, String fromUnit, String toUnit) {
    // Convert to meters first
    double meters;
    switch (fromUnit) {
      case 'Meters':
        meters = value;
        break;
      case 'Kilometers':
        meters = value * 1000;
        break;
      case 'Centimeters':
        meters = value / 100;
        break;
      case 'Millimeters':
        meters = value / 1000;
        break;
      case 'Miles':
        meters = value * 1609.34;
        break;
      case 'Yards':
        meters = value * 0.9144;
        break;
      case 'Feet':
        meters = value * 0.3048;
        break;
      case 'Inches':
        meters = value * 0.0254;
        break;
      default:
        throw ArgumentError('Unknown length unit: $fromUnit');
    }

    // Convert from meters to target unit
    switch (toUnit) {
      case 'Meters':
        return meters;
      case 'Kilometers':
        return meters / 1000;
      case 'Centimeters':
        return meters * 100;
      case 'Millimeters':
        return meters * 1000;
      case 'Miles':
        return meters / 1609.34;
      case 'Yards':
        return meters / 0.9144;
      case 'Feet':
        return meters / 0.3048;
      case 'Inches':
        return meters / 0.0254;
      default:
        throw ArgumentError('Unknown length unit: $toUnit');
    }
  }

  // WEIGHT CONVERSIONS (Base unit: Kilograms)
  static double _convertWeight(double value, String fromUnit, String toUnit) {
    // Convert to kilograms first
    double kilograms;
    switch (fromUnit) {
      case 'Kilograms':
        kilograms = value;
        break;
      case 'Grams':
        kilograms = value / 1000;
        break;
      case 'Milligrams':
        kilograms = value / 1000000;
        break;
      case 'Pounds':
        kilograms = value * 0.453592;
        break;
      case 'Ounces':
        kilograms = value * 0.0283495;
        break;
      case 'Tons':
        kilograms = value * 1000;
        break;
      default:
        throw ArgumentError('Unknown weight unit: $fromUnit');
    }

    // Convert from kilograms to target unit
    switch (toUnit) {
      case 'Kilograms':
        return kilograms;
      case 'Grams':
        return kilograms * 1000;
      case 'Milligrams':
        return kilograms * 1000000;
      case 'Pounds':
        return kilograms / 0.453592;
      case 'Ounces':
        return kilograms / 0.0283495;
      case 'Tons':
        return kilograms / 1000;
      default:
        throw ArgumentError('Unknown weight unit: $toUnit');
    }
  }

  // TEMPERATURE CONVERSIONS (Special case - not linear)
  static double _convertTemperature(
      double value, String fromUnit, String toUnit) {
    double celsius;

    // Convert to Celsius first
    switch (fromUnit) {
      case 'Celsius':
        celsius = value;
        break;
      case 'Fahrenheit':
        celsius = (value - 32) * 5 / 9;
        break;
      case 'Kelvin':
        celsius = value - 273.15;
        break;
      default:
        throw ArgumentError('Unknown temperature unit: $fromUnit');
    }

    // Convert from Celsius to target unit
    switch (toUnit) {
      case 'Celsius':
        return celsius;
      case 'Fahrenheit':
        return (celsius * 9 / 5) + 32;
      case 'Kelvin':
        return celsius + 273.15;
      default:
        throw ArgumentError('Unknown temperature unit: $toUnit');
    }
  }

  // VOLUME CONVERSIONS (Base unit: Liters)
  static double _convertVolume(double value, String fromUnit, String toUnit) {
    // Convert to liters first
    double liters;
    switch (fromUnit) {
      case 'Liters':
        liters = value;
        break;
      case 'Milliliters':
        liters = value / 1000;
        break;
      case 'Gallons (US)':
        liters = value * 3.78541;
        break;
      case 'Quarts (US)':
        liters = value * 0.946353;
        break;
      case 'Pints (US)':
        liters = value * 0.473176;
        break;
      case 'Cups':
        liters = value * 0.236588;
        break;
      case 'Fluid Ounces':
        liters = value * 0.0295735;
        break;
      default:
        throw ArgumentError('Unknown volume unit: $fromUnit');
    }

    // Convert from liters to target unit
    switch (toUnit) {
      case 'Liters':
        return liters;
      case 'Milliliters':
        return liters * 1000;
      case 'Gallons (US)':
        return liters / 3.78541;
      case 'Quarts (US)':
        return liters / 0.946353;
      case 'Pints (US)':
        return liters / 0.473176;
      case 'Cups':
        return liters / 0.236588;
      case 'Fluid Ounces':
        return liters / 0.0295735;
      default:
        throw ArgumentError('Unknown volume unit: $toUnit');
    }
  }

  // AREA CONVERSIONS (Base unit: Square Meters)
  static double _convertArea(double value, String fromUnit, String toUnit) {
    // Convert to square meters first
    double squareMeters;
    switch (fromUnit) {
      case 'Square Meters':
        squareMeters = value;
        break;
      case 'Square Kilometers':
        squareMeters = value * 1000000;
        break;
      case 'Square Centimeters':
        squareMeters = value / 10000;
        break;
      case 'Square Miles':
        squareMeters = value * 2589988.11;
        break;
      case 'Square Yards':
        squareMeters = value * 0.836127;
        break;
      case 'Square Feet':
        squareMeters = value * 0.092903;
        break;
      case 'Acres':
        squareMeters = value * 4046.86;
        break;
      case 'Hectares':
        squareMeters = value * 10000;
        break;
      default:
        throw ArgumentError('Unknown area unit: $fromUnit');
    }

    // Convert from square meters to target unit
    switch (toUnit) {
      case 'Square Meters':
        return squareMeters;
      case 'Square Kilometers':
        return squareMeters / 1000000;
      case 'Square Centimeters':
        return squareMeters * 10000;
      case 'Square Miles':
        return squareMeters / 2589988.11;
      case 'Square Yards':
        return squareMeters / 0.836127;
      case 'Square Feet':
        return squareMeters / 0.092903;
      case 'Acres':
        return squareMeters / 4046.86;
      case 'Hectares':
        return squareMeters / 10000;
      default:
        throw ArgumentError('Unknown area unit: $toUnit');
    }
  }

  // SPEED CONVERSIONS (Base unit: Meters per Second)
  static double _convertSpeed(double value, String fromUnit, String toUnit) {
    // Convert to meters per second first
    double metersPerSecond;
    switch (fromUnit) {
      case 'Meters/Second':
        metersPerSecond = value;
        break;
      case 'Kilometers/Hour':
        metersPerSecond = value / 3.6;
        break;
      case 'Miles/Hour':
        metersPerSecond = value * 0.44704;
        break;
      case 'Feet/Second':
        metersPerSecond = value * 0.3048;
        break;
      case 'Knots':
        metersPerSecond = value * 0.514444;
        break;
      default:
        throw ArgumentError('Unknown speed unit: $fromUnit');
    }

    // Convert from meters per second to target unit
    switch (toUnit) {
      case 'Meters/Second':
        return metersPerSecond;
      case 'Kilometers/Hour':
        return metersPerSecond * 3.6;
      case 'Miles/Hour':
        return metersPerSecond / 0.44704;
      case 'Feet/Second':
        return metersPerSecond / 0.3048;
      case 'Knots':
        return metersPerSecond / 0.514444;
      default:
        throw ArgumentError('Unknown speed unit: $toUnit');
    }
  }

  // Format result to avoid excessive decimal places
  static String formatResult(double value) {
    if (value.isInfinite) return 'Infinity';
    if (value.isNaN) return 'Error';

    // For very large or very small numbers, use scientific notation
    if (value.abs() >= 1e10 || (value.abs() < 1e-6 && value != 0)) {
      return value.toStringAsExponential(4);
    }

    // For whole numbers, don't show decimal places
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }

    // For other numbers, show up to 6 decimal places, removing trailing zeros
    String result = value.toStringAsFixed(AppConstants.maxDecimalPlaces);
    result = result.replaceAll(RegExp(r'0*$'), ''); // Remove trailing zeros
    result = result.replaceAll(RegExp(r'\.$'), ''); // Remove trailing decimal point
    return result;
  }

  // Validate input
  static bool isValidInput(String input) {
    if (input.isEmpty) return false;
    final number = double.tryParse(input);
    return number != null && !number.isNaN && !number.isInfinite;
  }
}