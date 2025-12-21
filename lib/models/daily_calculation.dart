/// Model class for daily dairy calculation data
class DailyCalculation {
  final int? id;
  final DateTime date;

  // Colony (was Shillak Stock)
  final double colonyLitres;
  final double colonyRate;
  final double colonyTotal;

  // Ghoti (was Collection)
  final double ghotiLitres;
  final double ghotiRate;
  final double ghotiTotal;

  // Center (new)
  final double centerLitres;
  final double centerRate;
  final double centerTotal;

  // Total 1 (Colony + Ghoti + Center)
  final double total1Litres;
  final double total1Total;

  // Row I
  final double row1Litres;
  final double row1Rate;
  final double row1Total;

  // Row II
  final double row2Litres;
  final double row2Rate;
  final double row2Total;

  // Row III
  final double row3Litres;
  final double row3Rate;
  final double row3Total;

  // Total 2 (I + II + III)
  final double total2Litres;
  final double total2Total;

  // Final Difference (Total1 - Total2)
  final double finalDiffLitres;
  final double finalDiffTotal;

  // Timestamps
  final DateTime createdAt;
  final DateTime updatedAt;

  DailyCalculation({
    this.id,
    required this.date,
    this.colonyLitres = 0,
    this.colonyRate = 0,
    this.colonyTotal = 0,
    this.ghotiLitres = 0,
    this.ghotiRate = 0,
    this.ghotiTotal = 0,
    this.centerLitres = 0,
    this.centerRate = 0,
    this.centerTotal = 0,
    this.total1Litres = 0,
    this.total1Total = 0,
    this.row1Litres = 0,
    this.row1Rate = 0,
    this.row1Total = 0,
    this.row2Litres = 0,
    this.row2Rate = 0,
    this.row2Total = 0,
    this.row3Litres = 0,
    this.row3Rate = 0,
    this.row3Total = 0,
    this.total2Litres = 0,
    this.total2Total = 0,
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
      'colony_litres': colonyLitres,
      'colony_rate': colonyRate,
      'colony_total': colonyTotal,
      'ghoti_litres': ghotiLitres,
      'ghoti_rate': ghotiRate,
      'ghoti_total': ghotiTotal,
      'center_litres': centerLitres,
      'center_rate': centerRate,
      'center_total': centerTotal,
      'total1_litres': total1Litres,
      'total1_total': total1Total,
      'row1_litres': row1Litres,
      'row1_rate': row1Rate,
      'row1_total': row1Total,
      'row2_litres': row2Litres,
      'row2_rate': row2Rate,
      'row2_total': row2Total,
      'row3_litres': row3Litres,
      'row3_rate': row3Rate,
      'row3_total': row3Total,
      'total2_litres': total2Litres,
      'total2_total': total2Total,
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
      colonyLitres: (map['colony_litres'] as num?)?.toDouble() ?? 0,
      colonyRate: (map['colony_rate'] as num?)?.toDouble() ?? 0,
      colonyTotal: (map['colony_total'] as num?)?.toDouble() ?? 0,
      ghotiLitres: (map['ghoti_litres'] as num?)?.toDouble() ?? 0,
      ghotiRate: (map['ghoti_rate'] as num?)?.toDouble() ?? 0,
      ghotiTotal: (map['ghoti_total'] as num?)?.toDouble() ?? 0,
      centerLitres: (map['center_litres'] as num?)?.toDouble() ?? 0,
      centerRate: (map['center_rate'] as num?)?.toDouble() ?? 0,
      centerTotal: (map['center_total'] as num?)?.toDouble() ?? 0,
      total1Litres: (map['total1_litres'] as num?)?.toDouble() ?? 0,
      total1Total: (map['total1_total'] as num?)?.toDouble() ?? 0,
      row1Litres: (map['row1_litres'] as num?)?.toDouble() ?? 0,
      row1Rate: (map['row1_rate'] as num?)?.toDouble() ?? 0,
      row1Total: (map['row1_total'] as num?)?.toDouble() ?? 0,
      row2Litres: (map['row2_litres'] as num?)?.toDouble() ?? 0,
      row2Rate: (map['row2_rate'] as num?)?.toDouble() ?? 0,
      row2Total: (map['row2_total'] as num?)?.toDouble() ?? 0,
      row3Litres: (map['row3_litres'] as num?)?.toDouble() ?? 0,
      row3Rate: (map['row3_rate'] as num?)?.toDouble() ?? 0,
      row3Total: (map['row3_total'] as num?)?.toDouble() ?? 0,
      total2Litres: (map['total2_litres'] as num?)?.toDouble() ?? 0,
      total2Total: (map['total2_total'] as num?)?.toDouble() ?? 0,
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
    double? colonyLitres,
    double? colonyRate,
    double? colonyTotal,
    double? ghotiLitres,
    double? ghotiRate,
    double? ghotiTotal,
    double? centerLitres,
    double? centerRate,
    double? centerTotal,
    double? total1Litres,
    double? total1Total,
    double? row1Litres,
    double? row1Rate,
    double? row1Total,
    double? row2Litres,
    double? row2Rate,
    double? row2Total,
    double? row3Litres,
    double? row3Rate,
    double? row3Total,
    double? total2Litres,
    double? total2Total,
    double? finalDiffLitres,
    double? finalDiffTotal,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DailyCalculation(
      id: id ?? this.id,
      date: date ?? this.date,
      colonyLitres: colonyLitres ?? this.colonyLitres,
      colonyRate: colonyRate ?? this.colonyRate,
      colonyTotal: colonyTotal ?? this.colonyTotal,
      ghotiLitres: ghotiLitres ?? this.ghotiLitres,
      ghotiRate: ghotiRate ?? this.ghotiRate,
      ghotiTotal: ghotiTotal ?? this.ghotiTotal,
      centerLitres: centerLitres ?? this.centerLitres,
      centerRate: centerRate ?? this.centerRate,
      centerTotal: centerTotal ?? this.centerTotal,
      total1Litres: total1Litres ?? this.total1Litres,
      total1Total: total1Total ?? this.total1Total,
      row1Litres: row1Litres ?? this.row1Litres,
      row1Rate: row1Rate ?? this.row1Rate,
      row1Total: row1Total ?? this.row1Total,
      row2Litres: row2Litres ?? this.row2Litres,
      row2Rate: row2Rate ?? this.row2Rate,
      row2Total: row2Total ?? this.row2Total,
      row3Litres: row3Litres ?? this.row3Litres,
      row3Rate: row3Rate ?? this.row3Rate,
      row3Total: row3Total ?? this.row3Total,
      total2Litres: total2Litres ?? this.total2Litres,
      total2Total: total2Total ?? this.total2Total,
      finalDiffLitres: finalDiffLitres ?? this.finalDiffLitres,
      finalDiffTotal: finalDiffTotal ?? this.finalDiffTotal,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'DailyCalculation(id: $id, date: ${date.toIso8601String().split('T')[0]}, '
        'total1: $total1Total, total2: $total2Total, diff: $finalDiffTotal)';
  }
}
