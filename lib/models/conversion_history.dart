class ConversionHistory {
  final String id;
  final String category;
  final double inputValue;
  final String fromUnit;
  final String toUnit;
  final double resultValue;
  final DateTime timestamp;
  final bool isFavorite;

  ConversionHistory({
    required this.id,
    required this.category,
    required this.inputValue,
    required this.fromUnit,
    required this.toUnit,
    required this.resultValue,
    required this.timestamp,
    this.isFavorite = false,
  });

  // Create a copy with updated values
  ConversionHistory copyWith({
    String? id,
    String? category,
    double? inputValue,
    String? fromUnit,
    String? toUnit,
    double? resultValue,
    DateTime? timestamp,
    bool? isFavorite,
  }) {
    return ConversionHistory(
      id: id ?? this.id,
      category: category ?? this.category,
      inputValue: inputValue ?? this.inputValue,
      fromUnit: fromUnit ?? this.fromUnit,
      toUnit: toUnit ?? this.toUnit,
      resultValue: resultValue ?? this.resultValue,
      timestamp: timestamp ?? this.timestamp,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'inputValue': inputValue,
      'fromUnit': fromUnit,
      'toUnit': toUnit,
      'resultValue': resultValue,
      'timestamp': timestamp.toIso8601String(),
      'isFavorite': isFavorite,
    };
  }

  // Create from JSON
  factory ConversionHistory.fromJson(Map<String, dynamic> json) {
    return ConversionHistory(
      id: json['id'] as String,
      category: json['category'] as String,
      inputValue: (json['inputValue'] as num).toDouble(),
      fromUnit: json['fromUnit'] as String,
      toUnit: json['toUnit'] as String,
      resultValue: (json['resultValue'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  // Format the conversion as a readable string
  String get formattedConversion {
    return '$inputValue $fromUnit = $resultValue $toUnit';
  }

  // Get a shortened display for the conversion
  String get displayText {
    return '${_formatNumber(inputValue)} $fromUnit → ${_formatNumber(resultValue)} $toUnit';
  }

  // Helper method to format numbers
  String _formatNumber(double value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
  }

  // Get time ago string
  String get timeAgo {
    final difference = DateTime.now().difference(timestamp);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  String toString() {
    return 'ConversionHistory(category: $category, $formattedConversion, time: $timeAgo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ConversionHistory && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}