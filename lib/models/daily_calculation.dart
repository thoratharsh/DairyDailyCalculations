/// Model class for daily dairy calculation data
class DailyCalculation {
  final int? id;
  final DateTime date;

  // Shillak Stock
  final double shillakLitres;
  final double shillakRate;
  final double shillakTotal;

  // Collection
  final double collectionLitres;
  final double collectionRate;
  final double collectionTotal;

  // Stock Calculation (Shillak + Collection)
  final double stockCalcLitres;
  final double stockCalcTotal;

  // Second Stock
  final double secondStockLitres;
  final double secondStockRate;
  final double secondStockTotal;

  // Today's Collection (Stock Calc - Second Stock)
  final double todayLitres;
  final double todayTotal;

  // Tanker
  final double tankerLitres;
  final double tankerRate;
  final double tankerTotal;

  // Final Difference (Tanker - Today)
  final double finalDiffLitres;
  final double finalDiffTotal;

  // Timestamps
  final DateTime createdAt;
  final DateTime updatedAt;

  DailyCalculation({
    this.id,
    required this.date,
    this.shillakLitres = 0,
    this.shillakRate = 0,
    this.shillakTotal = 0,
    this.collectionLitres = 0,
    this.collectionRate = 0,
    this.collectionTotal = 0,
    this.stockCalcLitres = 0,
    this.stockCalcTotal = 0,
    this.secondStockLitres = 0,
    this.secondStockRate = 0,
    this.secondStockTotal = 0,
    this.todayLitres = 0,
    this.todayTotal = 0,
    this.tankerLitres = 0,
    this.tankerRate = 0,
    this.tankerTotal = 0,
    this.finalDiffLitres = 0,
    this.finalDiffTotal = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  /// Convert model to map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String().split('T')[0], // Store as YYYY-MM-DD
      'shillak_litres': shillakLitres,
      'shillak_rate': shillakRate,
      'shillak_total': shillakTotal,
      'collection_litres': collectionLitres,
      'collection_rate': collectionRate,
      'collection_total': collectionTotal,
      'stock_calc_litres': stockCalcLitres,
      'stock_calc_total': stockCalcTotal,
      'second_stock_litres': secondStockLitres,
      'second_stock_rate': secondStockRate,
      'second_stock_total': secondStockTotal,
      'today_litres': todayLitres,
      'today_total': todayTotal,
      'tanker_litres': tankerLitres,
      'tanker_rate': tankerRate,
      'tanker_total': tankerTotal,
      'final_diff_litres': finalDiffLitres,
      'final_diff_total': finalDiffTotal,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Create model from database map
  factory DailyCalculation.fromMap(Map<String, dynamic> map) {
    return DailyCalculation(
      id: map['id'] as int?,
      date: DateTime.parse(map['date'] as String),
      shillakLitres: (map['shillak_litres'] as num?)?.toDouble() ?? 0,
      shillakRate: (map['shillak_rate'] as num?)?.toDouble() ?? 0,
      shillakTotal: (map['shillak_total'] as num?)?.toDouble() ?? 0,
      collectionLitres: (map['collection_litres'] as num?)?.toDouble() ?? 0,
      collectionRate: (map['collection_rate'] as num?)?.toDouble() ?? 0,
      collectionTotal: (map['collection_total'] as num?)?.toDouble() ?? 0,
      stockCalcLitres: (map['stock_calc_litres'] as num?)?.toDouble() ?? 0,
      stockCalcTotal: (map['stock_calc_total'] as num?)?.toDouble() ?? 0,
      secondStockLitres: (map['second_stock_litres'] as num?)?.toDouble() ?? 0,
      secondStockRate: (map['second_stock_rate'] as num?)?.toDouble() ?? 0,
      secondStockTotal: (map['second_stock_total'] as num?)?.toDouble() ?? 0,
      todayLitres: (map['today_litres'] as num?)?.toDouble() ?? 0,
      todayTotal: (map['today_total'] as num?)?.toDouble() ?? 0,
      tankerLitres: (map['tanker_litres'] as num?)?.toDouble() ?? 0,
      tankerRate: (map['tanker_rate'] as num?)?.toDouble() ?? 0,
      tankerTotal: (map['tanker_total'] as num?)?.toDouble() ?? 0,
      finalDiffLitres: (map['final_diff_litres'] as num?)?.toDouble() ?? 0,
      finalDiffTotal: (map['final_diff_total'] as num?)?.toDouble() ?? 0,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  /// Create a copy with updated fields
  DailyCalculation copyWith({
    int? id,
    DateTime? date,
    double? shillakLitres,
    double? shillakRate,
    double? shillakTotal,
    double? collectionLitres,
    double? collectionRate,
    double? collectionTotal,
    double? stockCalcLitres,
    double? stockCalcTotal,
    double? secondStockLitres,
    double? secondStockRate,
    double? secondStockTotal,
    double? todayLitres,
    double? todayTotal,
    double? tankerLitres,
    double? tankerRate,
    double? tankerTotal,
    double? finalDiffLitres,
    double? finalDiffTotal,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DailyCalculation(
      id: id ?? this.id,
      date: date ?? this.date,
      shillakLitres: shillakLitres ?? this.shillakLitres,
      shillakRate: shillakRate ?? this.shillakRate,
      shillakTotal: shillakTotal ?? this.shillakTotal,
      collectionLitres: collectionLitres ?? this.collectionLitres,
      collectionRate: collectionRate ?? this.collectionRate,
      collectionTotal: collectionTotal ?? this.collectionTotal,
      stockCalcLitres: stockCalcLitres ?? this.stockCalcLitres,
      stockCalcTotal: stockCalcTotal ?? this.stockCalcTotal,
      secondStockLitres: secondStockLitres ?? this.secondStockLitres,
      secondStockRate: secondStockRate ?? this.secondStockRate,
      secondStockTotal: secondStockTotal ?? this.secondStockTotal,
      todayLitres: todayLitres ?? this.todayLitres,
      todayTotal: todayTotal ?? this.todayTotal,
      tankerLitres: tankerLitres ?? this.tankerLitres,
      tankerRate: tankerRate ?? this.tankerRate,
      tankerTotal: tankerTotal ?? this.tankerTotal,
      finalDiffLitres: finalDiffLitres ?? this.finalDiffLitres,
      finalDiffTotal: finalDiffTotal ?? this.finalDiffTotal,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'DailyCalculation(id: $id, date: ${date.toIso8601String().split('T')[0]}, '
        'todayLitres: $todayLitres, todayTotal: $todayTotal)';
  }
}

