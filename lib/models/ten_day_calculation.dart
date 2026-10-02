import 'dart:convert';

/// One saved 11-day milk sheet for a single center on a single date.
///
/// A center can have many sheets (one per date). Saving the same center
/// and date again replaces that sheet instead of creating a second copy.
class TenDayCalculation {
  static const int rowCount = 11;

  final int? id;
  final String center;
  final DateTime date;
  final List<double> quantities;
  final List<double> rates;
  final double totalQuantity;
  final double totalAmount;
  final DateTime createdAt;
  final DateTime updatedAt;

  TenDayCalculation({
    this.id,
    required this.center,
    required this.date,
    required List<double> quantities,
    required List<double> rates,
    this.totalQuantity = 0,
    this.totalAmount = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : quantities = _fit(quantities),
        rates = _fit(rates),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  static List<double> _fit(List<double> values) {
    final fitted = List<double>.from(values);
    if (fitted.length > rowCount) {
      return fitted.sublist(0, rowCount);
    }
    while (fitted.length < rowCount) {
      fitted.add(0);
    }
    return fitted;
  }

  /// Row amount is always litres × rate, same as the on-screen row total.
  double amountAt(int index) => quantities[index] * rates[index];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'center': center,
      'date': _dateKey(date),
      'quantities': jsonEncode(quantities),
      'rates': jsonEncode(rates),
      'total_quantity': totalQuantity,
      'total_amount': totalAmount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory TenDayCalculation.fromMap(Map<String, dynamic> map) {
    return TenDayCalculation(
      id: map['id'] as int?,
      center: map['center'] as String,
      date: DateTime.parse(map['date'] as String),
      quantities: _decodeList(map['quantities'] as String?),
      rates: _decodeList(map['rates'] as String?),
      totalQuantity: (map['total_quantity'] as num?)?.toDouble() ?? 0,
      totalAmount: (map['total_amount'] as num?)?.toDouble() ?? 0,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  TenDayCalculation copyWith({
    int? id,
    String? center,
    DateTime? date,
    List<double>? quantities,
    List<double>? rates,
    double? totalQuantity,
    double? totalAmount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TenDayCalculation(
      id: id ?? this.id,
      center: center ?? this.center,
      date: date ?? this.date,
      quantities: quantities ?? this.quantities,
      rates: rates ?? this.rates,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  static String _dateKey(DateTime date) => date.toIso8601String().split('T')[0];

  static List<double> _decodeList(String? raw) {
    if (raw == null || raw.isEmpty) {
      return List<double>.filled(rowCount, 0);
    }
    final decoded = jsonDecode(raw);
    if (decoded is! List) {
      return List<double>.filled(rowCount, 0);
    }
    return _fit(decoded.map((value) => (value as num).toDouble()).toList());
  }
}
