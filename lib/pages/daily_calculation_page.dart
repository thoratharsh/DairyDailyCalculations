import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../models/daily_calculation.dart';
import '../services/database_service.dart';

class DailyCalculationPage extends StatefulWidget {
  const DailyCalculationPage({super.key});

  @override
  State<DailyCalculationPage> createState() => _DailyCalculationPageState();
}

class _DailyCalculationPageState extends State<DailyCalculationPage> {
  final DatabaseService _dbService = DatabaseService();

  // Selected date
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;
  bool _hasExistingData = false;
  int? _currentRecordId;

  // Controllers
  final _shillakLitresController = TextEditingController();
  final _shillakRateController = TextEditingController();
  final _collectionLitresController = TextEditingController();
  final _collectionRateController = TextEditingController();
  final _secondStockLitresController = TextEditingController();
  final _secondStockRateController = TextEditingController();
  final _tankerLitresController = TextEditingController();
  final _tankerRateController = TextEditingController();

  // Calculated values
  double _shillakTotal = 0;
  double _collectionTotal = 0;
  double _stockCalcLitres = 0;
  double _stockCalcTotal = 0;
  double _secondStockTotal = 0;
  double _todayLitres = 0;
  double _todayTotal = 0;
  double _tankerTotal = 0;
  double _finalDiffLitres = 0;
  double _finalDiffTotal = 0;

  @override
  void initState() {
    super.initState();
    _loadDataForDate(_selectedDate);
  }

  @override
  void dispose() {
    _shillakLitresController.dispose();
    _shillakRateController.dispose();
    _collectionLitresController.dispose();
    _collectionRateController.dispose();
    _secondStockLitresController.dispose();
    _secondStockRateController.dispose();
    _tankerLitresController.dispose();
    _tankerRateController.dispose();
    super.dispose();
  }

  /// Load data for a specific date from database
  Future<void> _loadDataForDate(DateTime date) async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      final calculation = await _dbService.getDailyCalculationByDate(date);

      if (!mounted) return;

      if (calculation != null) {
        _populateFromCalculation(calculation);
        _hasExistingData = true;
        _currentRecordId = calculation.id;
      } else {
        _clearAllFields();
        _hasExistingData = false;
        _currentRecordId = null;
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to load data: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Populate fields from a calculation object
  void _populateFromCalculation(DailyCalculation calc) {
    setState(() {
      _shillakLitresController.text = _formatController(calc.shillakLitres);
      _shillakRateController.text = _formatController(calc.shillakRate);
      _collectionLitresController.text =
          _formatController(calc.collectionLitres);
      _collectionRateController.text = _formatController(calc.collectionRate);
      _secondStockLitresController.text =
          _formatController(calc.secondStockLitres);
      _secondStockRateController.text =
          _formatController(calc.secondStockRate);
      _tankerLitresController.text = _formatController(calc.tankerLitres);
      _tankerRateController.text = _formatController(calc.tankerRate);

      _shillakTotal = calc.shillakTotal;
      _collectionTotal = calc.collectionTotal;
      _stockCalcLitres = calc.stockCalcLitres;
      _stockCalcTotal = calc.stockCalcTotal;
      _secondStockTotal = calc.secondStockTotal;
      _todayLitres = calc.todayLitres;
      _todayTotal = calc.todayTotal;
      _tankerTotal = calc.tankerTotal;
      _finalDiffLitres = calc.finalDiffLitres;
      _finalDiffTotal = calc.finalDiffTotal;
    });
  }

  String _formatController(double value) {
    if (value == 0) return '';
    return value.truncateToDouble() == value
        ? value.toInt().toString()
        : value.toString();
  }

  /// Calculate and save to database
  Future<void> _calculateAndSave() async {
    // Parse values
    final shillakLitres =
        double.tryParse(_shillakLitresController.text) ?? 0;
    final shillakRate = double.tryParse(_shillakRateController.text) ?? 0;
    final collectionLitres =
        double.tryParse(_collectionLitresController.text) ?? 0;
    final collectionRate =
        double.tryParse(_collectionRateController.text) ?? 0;
    final secondStockLitres =
        double.tryParse(_secondStockLitresController.text) ?? 0;
    final secondStockRate =
        double.tryParse(_secondStockRateController.text) ?? 0;
    final tankerLitres = double.tryParse(_tankerLitresController.text) ?? 0;
    final tankerRate = double.tryParse(_tankerRateController.text) ?? 0;

    // Calculate totals
    final shillakTotal = shillakLitres * shillakRate;
    final collectionTotal = collectionLitres * collectionRate;
    final stockCalcLitres = shillakLitres + collectionLitres;
    final stockCalcTotal = shillakTotal + collectionTotal;
    final secondStockTotal = secondStockLitres * secondStockRate;
    final todayLitres = stockCalcLitres - secondStockLitres;
    final todayTotal = stockCalcTotal - secondStockTotal;
    final tankerTotal = tankerLitres * tankerRate;
    final finalDiffLitres = tankerLitres - todayLitres;
    final finalDiffTotal = tankerTotal - todayTotal;

    // Update UI
    setState(() {
      _shillakTotal = shillakTotal;
      _collectionTotal = collectionTotal;
      _stockCalcLitres = stockCalcLitres;
      _stockCalcTotal = stockCalcTotal;
      _secondStockTotal = secondStockTotal;
      _todayLitres = todayLitres;
      _todayTotal = todayTotal;
      _tankerTotal = tankerTotal;
      _finalDiffLitres = finalDiffLitres;
      _finalDiffTotal = finalDiffTotal;
    });

    // Create calculation object
    final calculation = DailyCalculation(
      id: _currentRecordId,
      date: _selectedDate,
      shillakLitres: shillakLitres,
      shillakRate: shillakRate,
      shillakTotal: shillakTotal,
      collectionLitres: collectionLitres,
      collectionRate: collectionRate,
      collectionTotal: collectionTotal,
      stockCalcLitres: stockCalcLitres,
      stockCalcTotal: stockCalcTotal,
      secondStockLitres: secondStockLitres,
      secondStockRate: secondStockRate,
      secondStockTotal: secondStockTotal,
      todayLitres: todayLitres,
      todayTotal: todayTotal,
      tankerLitres: tankerLitres,
      tankerRate: tankerRate,
      tankerTotal: tankerTotal,
      finalDiffLitres: finalDiffLitres,
      finalDiffTotal: finalDiffTotal,
    );

    // Save to database
    final isUpdate = _hasExistingData;
    try {
      await _dbService.saveDailyCalculation(calculation);

      if (!mounted) return;

      _hasExistingData = true;

      // Reload to get the ID
      final saved = await _dbService.getDailyCalculationByDate(_selectedDate);
      if (saved != null) {
        _currentRecordId = saved.id;
      }

      _showSuccessSnackBar(isUpdate ? 'Data updated' : 'Data saved');
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to save: $e');
      }
    }
  }

  /// Clear all fields
  void _clearAllFields() {
    setState(() {
      _shillakLitresController.clear();
      _shillakRateController.clear();
      _collectionLitresController.clear();
      _collectionRateController.clear();
      _secondStockLitresController.clear();
      _secondStockRateController.clear();
      _tankerLitresController.clear();
      _tankerRateController.clear();

      _shillakTotal = 0;
      _collectionTotal = 0;
      _stockCalcLitres = 0;
      _stockCalcTotal = 0;
      _secondStockTotal = 0;
      _todayLitres = 0;
      _todayTotal = 0;
      _tankerTotal = 0;
      _finalDiffLitres = 0;
      _finalDiffTotal = 0;
    });
  }

  /// Show date picker
  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.forestGreen,
              onPrimary: Colors.white,
              surface: AppColors.warmWhite,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
      await _loadDataForDate(picked);
    }
  }

  /// Delete current record
  Future<void> _deleteRecord() async {
    if (!_hasExistingData || _currentRecordId == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: AppColors.barnRed),
            const SizedBox(width: 12),
            const Text('Delete Entry?'),
          ],
        ),
        content: Text(
          'Delete data for ${DateFormat('dd MMM yyyy').format(_selectedDate)}?\n'
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.barnRed,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _dbService.deleteDailyCalculation(_currentRecordId!);

        if (!mounted) return;

        _clearAllFields();
        _hasExistingData = false;
        _currentRecordId = null;
        _showSuccessSnackBar('Entry deleted');
      } catch (e) {
        if (mounted) {
          _showErrorSnackBar('Failed to delete: $e');
        }
      }
    }
  }

  /// Navigate to history page
  void _openHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _HistoryPage(
          onDateSelected: (date) {
            setState(() => _selectedDate = date);
            _loadDataForDate(date);
          },
        ),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: AppColors.forestGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.barnRed,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String _formatNumber(double value) {
    if (value == 0) return '';
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text('Daily Calculation'),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.warmWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.warmWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: const Icon(Icons.history_rounded, size: 18),
            ),
            onPressed: _openHistory,
            tooltip: 'View History',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateSelector(),
                  const SizedBox(height: 16),
                  _buildActionButtons(),
                  const SizedBox(height: 20),
                  _buildCalculationTable(),
                  const SizedBox(height: 20),
                  _buildResultCard(),
                ],
              ),
            ),
    );
  }

  Widget _buildDateSelector() {
    final isToday = DateUtils.isSameDay(_selectedDate, DateTime.now());

    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.warmWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hasExistingData
                ? AppColors.forestGreen.withValues(alpha: 0.5)
                : AppColors.border,
            width: _hasExistingData ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: AppColors.accentGradient,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_selectedDate.day}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  Text(
                    DateFormat('MMM').format(_selectedDate).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        DateFormat('EEEE').format(_selectedDate),
                        style: AppTextStyles.bodyBold,
                      ),
                      if (isToday) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.forestGreen.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Today',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.forestGreen,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('dd MMMM yyyy').format(_selectedDate),
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                if (_hasExistingData)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.forestGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.forestGreen,
                      size: 18,
                    ),
                  ),
                const SizedBox(height: 4),
                Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        if (_hasExistingData)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: _deleteRecord,
              icon: Icon(Icons.delete_outline_rounded, color: AppColors.barnRed),
              tooltip: 'Delete entry',
              style: IconButton.styleFrom(
                backgroundColor: AppColors.barnRed.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        Expanded(
          child: ActionButton(
            text: 'Clear',
            icon: Icons.refresh_rounded,
            onPressed: _clearAllFields,
            isPrimary: false,
            isDestructive: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ActionButton(
            text: _hasExistingData ? 'Update & Save' : 'Calculate & Save',
            icon: Icons.save_rounded,
            onPressed: _calculateAndSave,
          ),
        ),
      ],
    );
  }

  Widget _buildCalculationTable() {
    return GradientCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTableHeader(),
          const Divider(color: AppColors.border, height: 24),
          _buildInputRow(
            'Shillak Stock',
            _shillakLitresController,
            _shillakRateController,
            _formatNumber(_shillakTotal),
          ),
          _buildInputRow(
            'Collection',
            _collectionLitresController,
            _collectionRateController,
            _formatNumber(_collectionTotal),
          ),
          _buildCalculatedRow(
            'Stock Calc',
            _formatNumber(_stockCalcLitres),
            _formatNumber(_stockCalcTotal),
            isSubtotal: true,
          ),
          _buildInputRow(
            'Second Stock',
            _secondStockLitresController,
            _secondStockRateController,
            _formatNumber(_secondStockTotal),
          ),
          _buildCalculatedRow(
            'Today Collection',
            _formatNumber(_todayLitres),
            _formatNumber(_todayTotal),
            isHighlighted: true,
          ),
          _buildInputRow(
            'Tanker',
            _tankerLitresController,
            _tankerRateController,
            _formatNumber(_tankerTotal),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text('Description', style: AppTextStyles.caption),
        ),
        Expanded(
          child: Center(
            child: Text('Litres', style: AppTextStyles.caption),
          ),
        ),
        Expanded(
          child: Center(
            child: Text('₹/Litre', style: AppTextStyles.caption),
          ),
        ),
        SizedBox(
          width: 90,
          child: Text('Total ₹',
              style: AppTextStyles.caption, textAlign: TextAlign.right),
        ),
      ],
    );
  }

  Widget _buildInputRow(
    String label,
    TextEditingController litresController,
    TextEditingController rateController,
    String total,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          RowLabel(text: label),
          Expanded(
            child: NumberInputField(
              controller: litresController,
              hint: '0',
            ),
          ),
          const SizedBox(width: 8),
          const Text('×', style: TextStyle(color: AppColors.textLight)),
          const SizedBox(width: 8),
          Expanded(
            child: NumberInputField(
              controller: rateController,
              hint: '0',
            ),
          ),
          const SizedBox(width: 8),
          ValueDisplay(
            value: total,
            isHighlighted: total.isNotEmpty,
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatedRow(
    String label,
    String litres,
    String total, {
    bool isSubtotal = false,
    bool isHighlighted = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppColors.forestGreen.withValues(alpha: 0.08)
            : isSubtotal
                ? AppColors.goldenHay.withValues(alpha: 0.1)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: isHighlighted || isSubtotal
            ? Border.all(
                color: isHighlighted
                    ? AppColors.forestGreen.withValues(alpha: 0.2)
                    : AppColors.goldenHay.withValues(alpha: 0.3))
            : null,
      ),
      child: Row(
        children: [
          RowLabel(
            text: label,
            isSubLabel: isSubtotal,
          ),
          Expanded(
            child: Center(
              child: Text(
                litres.isEmpty ? '—' : litres,
                style: isHighlighted ? AppTextStyles.total : AppTextStyles.number,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          ValueDisplay(
            value: total,
            isTotal: isHighlighted,
            isHighlighted: isSubtotal,
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    final isPositive = _finalDiffTotal >= 0;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isPositive
              ? [
                  AppColors.forestGreen.withValues(alpha: 0.1),
                  AppColors.forestGreen.withValues(alpha: 0.05),
                ]
              : [
                  AppColors.barnRed.withValues(alpha: 0.1),
                  AppColors.barnRed.withValues(alpha: 0.05),
                ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPositive
              ? AppColors.forestGreen.withValues(alpha: 0.3)
              : AppColors.barnRed.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isPositive
                    ? Icons.trending_up_rounded
                    : Icons.trending_down_rounded,
                color: isPositive ? AppColors.forestGreen : AppColors.barnRed,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                'Final Difference',
                style: AppTextStyles.heading3,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('Litres', style: AppTextStyles.caption),
                  const SizedBox(height: 4),
                  Text(
                    _finalDiffLitres == 0
                        ? '—'
                        : _formatNumber(_finalDiffLitres),
                    style: AppTextStyles.heading2.copyWith(
                      color:
                          isPositive ? AppColors.forestGreen : AppColors.barnRed,
                    ),
                  ),
                ],
              ),
              Container(
                height: 40,
                width: 1,
                color: AppColors.border,
              ),
              Column(
                children: [
                  Text('Total Amount', style: AppTextStyles.caption),
                  const SizedBox(height: 4),
                  Text(
                    _finalDiffTotal == 0
                        ? '—'
                        : '₹${_formatNumber(_finalDiffTotal)}',
                    style: AppTextStyles.heading2.copyWith(
                      color:
                          isPositive ? AppColors.forestGreen : AppColors.barnRed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============ History Page ============

class _HistoryPage extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const _HistoryPage({required this.onDateSelected});

  @override
  State<_HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<_HistoryPage> {
  final DatabaseService _dbService = DatabaseService();
  List<DailyCalculation> _calculations = [];
  bool _isLoading = true;
  Map<String, double> _summary = {};

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final calculations = await _dbService.getAllDailyCalculations();
      final summary = await _dbService.getDailyCalculationsSummary();

      if (!mounted) return;

      setState(() {
        _calculations = calculations;
        _summary = summary;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load history: $e'),
            backgroundColor: AppColors.barnRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _formatNumber(double value) {
    if (value == 0) return '0';
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text('History'),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.warmWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _calculations.isEmpty
              ? _buildEmptyState()
              : Column(
                  children: [
                    _buildSummaryCard(),
                    Expanded(child: _buildHistoryList()),
                  ],
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_rounded,
            size: 64,
            color: AppColors.textLight,
          ),
          const SizedBox(height: 16),
          Text(
            'No records yet',
            style: AppTextStyles.heading3.copyWith(color: AppColors.textLight),
          ),
          const SizedBox(height: 8),
          Text(
            'Start by adding your first daily calculation',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.forestGreen.withValues(alpha: 0.1),
            AppColors.goldenHay.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.forestGreen.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text('Overall Summary', style: AppTextStyles.heading3),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSummaryItem(
                'Total Records',
                '${_calculations.length}',
                Icons.calendar_month_rounded,
              ),
              _buildSummaryItem(
                'Total Litres',
                _formatNumber(_summary['total_litres'] ?? 0),
                Icons.water_drop_outlined,
              ),
              _buildSummaryItem(
                'Total Amount',
                '₹${_formatNumber(_summary['total_amount'] ?? 0)}',
                Icons.currency_rupee_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppColors.forestGreen),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.caption),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.bodyBold.copyWith(color: AppColors.forestGreen),
        ),
      ],
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: _calculations.length,
      itemBuilder: (context, index) {
        final calc = _calculations[index];
        return _buildHistoryItem(calc);
      },
    );
  }

  Widget _buildHistoryItem(DailyCalculation calc) {
    final isPositive = calc.finalDiffTotal >= 0;

    return GestureDetector(
      onTap: () {
        widget.onDateSelected(calc.date);
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.warmWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.forestGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${calc.date.day}',
                    style: TextStyle(
                      color: AppColors.forestGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  Text(
                    DateFormat('MMM').format(calc.date).toUpperCase(),
                    style: TextStyle(
                      color: AppColors.forestGreen,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('EEEE').format(calc.date),
                    style: AppTextStyles.bodyBold,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Today: ${_formatNumber(calc.todayLitres)}L • ₹${_formatNumber(calc.todayTotal)}',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      isPositive
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      size: 14,
                      color: isPositive
                          ? AppColors.forestGreen
                          : AppColors.barnRed,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '₹${_formatNumber(calc.finalDiffTotal)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isPositive
                            ? AppColors.forestGreen
                            : AppColors.barnRed,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Diff',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textLight,
            ),
          ],
        ),
      ),
    );
  }
}
