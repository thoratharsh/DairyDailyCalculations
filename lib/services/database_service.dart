import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../models/daily_calculation.dart';

/// Service class for SQLite database operations
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;
  static bool _isInitialized = false;

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  /// Initialize the database factory for the current platform
  static void initializeDatabaseFactory() {
    if (_isInitialized) return;

    if (kIsWeb) {
      // Web platform - sqflite not supported
      return;
    }

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Initialize FFI for desktop platforms
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    _isInitialized = true;
  }

  /// Get the database instance, initializing if necessary
  Future<Database> get database async {
    // Ensure database factory is initialized
    initializeDatabaseFactory();

    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize the database
  Future<Database> _initDatabase() async {
    final dbPath = await databaseFactory.getDatabasesPath();
    final path = join(dbPath, 'dairy_daily.db');

    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      ),
    );
  }

  /// Create database tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE daily_calculations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL UNIQUE,
        shillak_litres REAL DEFAULT 0,
        shillak_rate REAL DEFAULT 0,
        shillak_total REAL DEFAULT 0,
        collection_litres REAL DEFAULT 0,
        collection_rate REAL DEFAULT 0,
        collection_total REAL DEFAULT 0,
        stock_calc_litres REAL DEFAULT 0,
        stock_calc_total REAL DEFAULT 0,
        second_stock_litres REAL DEFAULT 0,
        second_stock_rate REAL DEFAULT 0,
        second_stock_total REAL DEFAULT 0,
        today_litres REAL DEFAULT 0,
        today_total REAL DEFAULT 0,
        tanker_litres REAL DEFAULT 0,
        tanker_rate REAL DEFAULT 0,
        tanker_total REAL DEFAULT 0,
        final_diff_litres REAL DEFAULT 0,
        final_diff_total REAL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Create index on date for faster lookups
    await db.execute('''
      CREATE INDEX idx_daily_calculations_date 
      ON daily_calculations (date)
    ''');
  }

  /// Handle database upgrades
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle future migrations here
  }

  // ============ CRUD Operations for Daily Calculations ============

  /// Insert a new daily calculation
  Future<int> insertDailyCalculation(DailyCalculation calculation) async {
    final db = await database;
    return await db.insert(
      'daily_calculations',
      calculation.toMap()..remove('id'),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Update an existing daily calculation
  Future<int> updateDailyCalculation(DailyCalculation calculation) async {
    final db = await database;
    return await db.update(
      'daily_calculations',
      calculation.toMap(),
      where: 'id = ?',
      whereArgs: [calculation.id],
    );
  }

  /// Save (insert or update) a daily calculation for a specific date
  Future<int> saveDailyCalculation(DailyCalculation calculation) async {
    final existing = await getDailyCalculationByDate(calculation.date);
    if (existing != null) {
      // Update existing record
      final updated = calculation.copyWith(
        id: existing.id,
        createdAt: existing.createdAt,
      );
      return await updateDailyCalculation(updated);
    } else {
      // Insert new record
      return await insertDailyCalculation(calculation);
    }
  }

  /// Get a daily calculation by date
  Future<DailyCalculation?> getDailyCalculationByDate(DateTime date) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];

    final results = await db.query(
      'daily_calculations',
      where: 'date = ?',
      whereArgs: [dateStr],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return DailyCalculation.fromMap(results.first);
  }

  /// Get a daily calculation by ID
  Future<DailyCalculation?> getDailyCalculationById(int id) async {
    final db = await database;
    final results = await db.query(
      'daily_calculations',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return DailyCalculation.fromMap(results.first);
  }

  /// Get all daily calculations (ordered by date descending)
  Future<List<DailyCalculation>> getAllDailyCalculations() async {
    final db = await database;
    final results = await db.query(
      'daily_calculations',
      orderBy: 'date DESC',
    );

    return results.map((map) => DailyCalculation.fromMap(map)).toList();
  }

  /// Get daily calculations for a date range
  Future<List<DailyCalculation>> getDailyCalculationsInRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final db = await database;
    final startStr = startDate.toIso8601String().split('T')[0];
    final endStr = endDate.toIso8601String().split('T')[0];

    final results = await db.query(
      'daily_calculations',
      where: 'date >= ? AND date <= ?',
      whereArgs: [startStr, endStr],
      orderBy: 'date DESC',
    );

    return results.map((map) => DailyCalculation.fromMap(map)).toList();
  }

  /// Get recent daily calculations (last N entries)
  Future<List<DailyCalculation>> getRecentDailyCalculations({
    int limit = 10,
  }) async {
    final db = await database;
    final results = await db.query(
      'daily_calculations',
      orderBy: 'date DESC',
      limit: limit,
    );

    return results.map((map) => DailyCalculation.fromMap(map)).toList();
  }

  /// Delete a daily calculation by ID
  Future<int> deleteDailyCalculation(int id) async {
    final db = await database;
    return await db.delete(
      'daily_calculations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete a daily calculation by date
  Future<int> deleteDailyCalculationByDate(DateTime date) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];

    return await db.delete(
      'daily_calculations',
      where: 'date = ?',
      whereArgs: [dateStr],
    );
  }

  /// Get count of all daily calculations
  Future<int> getDailyCalculationsCount() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM daily_calculations',
    );
    if (result.isEmpty) return 0;
    return (result.first['count'] as int?) ?? 0;
  }

  /// Get summary statistics
  Future<Map<String, double>> getDailyCalculationsSummary() async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT 
        SUM(today_litres) as total_litres,
        SUM(today_total) as total_amount,
        AVG(today_litres) as avg_litres,
        AVG(today_total) as avg_amount
      FROM daily_calculations
    ''');

    if (result.isEmpty) {
      return {
        'total_litres': 0,
        'total_amount': 0,
        'avg_litres': 0,
        'avg_amount': 0,
      };
    }

    final row = result.first;
    return {
      'total_litres': (row['total_litres'] as num?)?.toDouble() ?? 0,
      'total_amount': (row['total_amount'] as num?)?.toDouble() ?? 0,
      'avg_litres': (row['avg_litres'] as num?)?.toDouble() ?? 0,
      'avg_amount': (row['avg_amount'] as num?)?.toDouble() ?? 0,
    };
  }

  /// Close the database
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
