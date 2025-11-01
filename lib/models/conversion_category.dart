import 'package:flutter/material.dart';

class ConversionCategory {
  final String name;
  final IconData icon;
  final Color color;
  final List<String> units;
  final String description;

  ConversionCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.units,
    required this.description,
  });

  // Create a copy with updated values
  ConversionCategory copyWith({
    String? name,
    IconData? icon,
    Color? color,
    List<String>? units,
    String? description,
  }) {
    return ConversionCategory(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      units: units ?? this.units,
      description: description ?? this.description,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon.codePoint,
      'color': color.value,
      'units': units,
      'description': description,
    };
  }

  // Create from JSON
  factory ConversionCategory.fromJson(Map<String, dynamic> json) {
    return ConversionCategory(
      name: json['name'] as String,
      icon: IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
      color: Color(json['color'] as int),
      units: List<String>.from(json['units'] as List),
      description: json['description'] as String,
    );
  }

  @override
  String toString() {
    return 'ConversionCategory(name: $name, units: ${units.length})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ConversionCategory && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}