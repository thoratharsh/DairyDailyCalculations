/// Model class for daily dairy calculation data
class DailyCalculation {
  final int? id;
  final DateTime date;

  // Section 1 centers. Each total is litres × rate.
  final double sangaviLitres;
  final double sangaviRate;
  final double sangaviTotal;
  final double karkambLitres;
  final double karkambRate;
  final double karkambTotal;
  final double gotiLitres;
  final double gotiRate;
  final double gotiTotal;
  final double tulshiLitres;
  final double tulshiRate;
  final double tulshiTotal;

  // Total 1 (Sangavi + Karkamb + Goti + Tulshi)
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

  // Combined total of both sections (Total 1 + Total 2).
  // Kept in the existing final_diff columns so older saved days still open.
  final double combinedLitres;
  final double combinedTotal;

  // Timestamps
  final DateTime createdAt;
  final DateTime updatedAt;

  DailyCalculation({
    this.id,
    required this.date,
    this.sangaviLitres = 0,
    this.sangaviRate = 0,
    this.sangaviTotal = 0,
    this.karkambLitres = 0,
    this.karkambRate = 0,
    this.karkambTotal = 0,
    this.gotiLitres = 0,
    this.gotiRate = 0,
    this.gotiTotal = 0,
    this.tulshiLitres = 0,
    this.tulshiRate = 0,
    this.tulshiTotal = 0,
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
    this.combinedLitres = 0,
    this.combinedTotal = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  /// Convert model to map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String().split('T')[0], // Store as YYYY-MM-DD
      'sangavi_litres': sangaviLitres,
      'sangavi_rate': sangaviRate,
      'sangavi_total': sangaviTotal,
      'karkamb_litres': karkambLitres,
      'karkamb_rate': karkambRate,
      'karkamb_total': karkambTotal,
      'goti_litres': gotiLitres,
      'goti_rate': gotiRate,
      'goti_total': gotiTotal,
      'tulshi_litres': tulshiLitres,
      'tulshi_rate': tulshiRate,
      'tulshi_total': tulshiTotal,
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
      'final_diff_litres': combinedLitres,
      'final_diff_total': combinedTotal,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Create model from database map
  factory DailyCalculation.fromMap(Map<String, dynamic> map) {
    return DailyCalculation(
      id: map['id'] as int?,
      date: DateTime.parse(map['date'] as String),
      sangaviLitres: (map['sangavi_litres'] as num?)?.toDouble() ?? 0,
      sangaviRate: (map['sangavi_rate'] as num?)?.toDouble() ?? 0,
      sangaviTotal: (map['sangavi_total'] as num?)?.toDouble() ?? 0,
      karkambLitres: (map['karkamb_litres'] as num?)?.toDouble() ?? 0,
      karkambRate: (map['karkamb_rate'] as num?)?.toDouble() ?? 0,
      karkambTotal: (map['karkamb_total'] as num?)?.toDouble() ?? 0,
      gotiLitres: (map['goti_litres'] as num?)?.toDouble() ?? 0,
      gotiRate: (map['goti_rate'] as num?)?.toDouble() ?? 0,
      gotiTotal: (map['goti_total'] as num?)?.toDouble() ?? 0,
      tulshiLitres: (map['tulshi_litres'] as num?)?.toDouble() ?? 0,
      tulshiRate: (map['tulshi_rate'] as num?)?.toDouble() ?? 0,
      tulshiTotal: (map['tulshi_total'] as num?)?.toDouble() ?? 0,
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
      combinedLitres: (map['total1_litres'] as num? ?? 0).toDouble() +
          (map['total2_litres'] as num? ?? 0).toDouble(),
      combinedTotal: (map['total1_total'] as num? ?? 0).toDouble() +
          (map['total2_total'] as num? ?? 0).toDouble(),
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  /// Create a copy with updated fields
  DailyCalculation copyWith({
    int? id,
    DateTime? date,
    double? sangaviLitres,
    double? sangaviRate,
    double? sangaviTotal,
    double? karkambLitres,
    double? karkambRate,
    double? karkambTotal,
    double? gotiLitres,
    double? gotiRate,
    double? gotiTotal,
    double? tulshiLitres,
    double? tulshiRate,
    double? tulshiTotal,
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
    double? combinedLitres,
    double? combinedTotal,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DailyCalculation(
      id: id ?? this.id,
      date: date ?? this.date,
      sangaviLitres: sangaviLitres ?? this.sangaviLitres,
      sangaviRate: sangaviRate ?? this.sangaviRate,
      sangaviTotal: sangaviTotal ?? this.sangaviTotal,
      karkambLitres: karkambLitres ?? this.karkambLitres,
      karkambRate: karkambRate ?? this.karkambRate,
      karkambTotal: karkambTotal ?? this.karkambTotal,
      gotiLitres: gotiLitres ?? this.gotiLitres,
      gotiRate: gotiRate ?? this.gotiRate,
      gotiTotal: gotiTotal ?? this.gotiTotal,
      tulshiLitres: tulshiLitres ?? this.tulshiLitres,
      tulshiRate: tulshiRate ?? this.tulshiRate,
      tulshiTotal: tulshiTotal ?? this.tulshiTotal,
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
      combinedLitres: combinedLitres ?? this.combinedLitres,
      combinedTotal: combinedTotal ?? this.combinedTotal,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'DailyCalculation(id: $id, date: ${date.toIso8601String().split('T')[0]}, '
        'total1: $total1Total, total2: $total2Total, combined: $combinedTotal)';
  }
}
