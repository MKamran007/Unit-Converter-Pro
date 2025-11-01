class Unit {
  final String name;
  final String symbol;
  final String category;
  final double conversionFactor; // Factor to convert to base unit

  Unit({
    required this.name,
    required this.symbol,
    required this.category,
    required this.conversionFactor,
  });

  // Create a copy with updated values
  Unit copyWith({
    String? name,
    String? symbol,
    String? category,
    double? conversionFactor,
  }) {
    return Unit(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      category: category ?? this.category,
      conversionFactor: conversionFactor ?? this.conversionFactor,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'symbol': symbol,
      'category': category,
      'conversionFactor': conversionFactor,
    };
  }

  // Create from JSON
  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      category: json['category'] as String,
      conversionFactor: (json['conversionFactor'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Unit(name: $name, symbol: $symbol, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Unit &&
        other.name == name &&
        other.category == category;
  }

  @override
  int get hashCode => name.hashCode ^ category.hashCode;
}