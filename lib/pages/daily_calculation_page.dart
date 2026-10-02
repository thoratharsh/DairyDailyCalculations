import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../models/collection_centers.dart';
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

  static const double _labelWidth = 84;

  // Controllers for Sangavi, Karkamb, Goti, and Tulshi
  final _sangaviLitresController = TextEditingController();
  final _sangaviRateController = TextEditingController();
  final _karkambLitresController = TextEditingController();
  final _karkambRateController = TextEditingController();
  final _gotiLitresController = TextEditingController();
  final _gotiRateController = TextEditingController();
  final _tulshiLitresController = TextEditingController();
  final _tulshiRateController = TextEditingController();

  // Controllers for I, II, III
  final _row1LitresController = TextEditingController();
  final _row1RateController = TextEditingController();
  final _row2LitresController = TextEditingController();
  final _row2RateController = TextEditingController();
  final _row3LitresController = TextEditingController();
  final _row3RateController = TextEditingController();

  // Calculated values
  double _sangaviTotal = 0;
  double _karkambTotal = 0;
  double _gotiTotal = 0;
  double _tulshiTotal = 0;
  double _total1Litres = 0;
  double _total1Total = 0;
  double _row1Total = 0;
  double _row2Total = 0;
  double _row3Total = 0;
  double _total2Litres = 0;
  double _total2Total = 0;
  double? _combinedLitres; // null = not calculated, show "—"
  double? _combinedTotal; // null = not calculated, show "—"

  @override
  void initState() {
    super.initState();
    _loadDataForDate(_selectedDate);
  }

  @override
  void dispose() {
    _sangaviLitresController.dispose();
    _sangaviRateController.dispose();
    _karkambLitresController.dispose();
    _karkambRateController.dispose();
    _gotiLitresController.dispose();
    _gotiRateController.dispose();
    _tulshiLitresController.dispose();
    _tulshiRateController.dispose();
    _row1LitresController.dispose();
    _row1RateController.dispose();
    _row2LitresController.dispose();
    _row2RateController.dispose();
    _row3LitresController.dispose();
    _row3RateController.dispose();
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
      _sangaviLitresController.text = _formatController(calc.sangaviLitres);
      _sangaviRateController.text = _formatController(calc.sangaviRate);
      _karkambLitresController.text = _formatController(calc.karkambLitres);
      _karkambRateController.text = _formatController(calc.karkambRate);
      _gotiLitresController.text = _formatController(calc.gotiLitres);
      _gotiRateController.text = _formatController(calc.gotiRate);
      _tulshiLitresController.text = _formatController(calc.tulshiLitres);
      _tulshiRateController.text = _formatController(calc.tulshiRate);
      _row1LitresController.text = _formatController(calc.row1Litres);
      _row1RateController.text = _formatController(calc.row1Rate);
      _row2LitresController.text = _formatController(calc.row2Litres);
      _row2RateController.text = _formatController(calc.row2Rate);
      _row3LitresController.text = _formatController(calc.row3Litres);
      _row3RateController.text = _formatController(calc.row3Rate);

      _sangaviTotal = calc.sangaviTotal;
      _karkambTotal = calc.karkambTotal;
      _gotiTotal = calc.gotiTotal;
      _tulshiTotal = calc.tulshiTotal;
      _total1Litres = calc.total1Litres;
      _total1Total = calc.total1Total;
      _row1Total = calc.row1Total;
      _row2Total = calc.row2Total;
      _row3Total = calc.row3Total;
      _total2Litres = calc.total2Litres;
      _total2Total = calc.total2Total;
      _combinedLitres = calc.combinedLitres;
      _combinedTotal = calc.combinedTotal;
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
    final sangaviLitres = double.tryParse(_sangaviLitresController.text) ?? 0;
    final sangaviRate = double.tryParse(_sangaviRateController.text) ?? 0;
    final karkambLitres = double.tryParse(_karkambLitresController.text) ?? 0;
    final karkambRate = double.tryParse(_karkambRateController.text) ?? 0;
    final gotiLitres = double.tryParse(_gotiLitresController.text) ?? 0;
    final gotiRate = double.tryParse(_gotiRateController.text) ?? 0;
    final tulshiLitres = double.tryParse(_tulshiLitresController.text) ?? 0;
    final tulshiRate = double.tryParse(_tulshiRateController.text) ?? 0;

    // Parse I, II, III values
    final row1Litres = double.tryParse(_row1LitresController.text) ?? 0;
    final row1Rate = double.tryParse(_row1RateController.text) ?? 0;
    final row2Litres = double.tryParse(_row2LitresController.text) ?? 0;
    final row2Rate = double.tryParse(_row2RateController.text) ?? 0;
    final row3Litres = double.tryParse(_row3LitresController.text) ?? 0;
    final row3Rate = double.tryParse(_row3RateController.text) ?? 0;

    // Calculate individual totals
    final sangaviTotal = sangaviLitres * sangaviRate;
    final karkambTotal = karkambLitres * karkambRate;
    final gotiTotal = gotiLitres * gotiRate;
    final tulshiTotal = tulshiLitres * tulshiRate;
    final row1Total = row1Litres * row1Rate;
    final row2Total = row2Litres * row2Rate;
    final row3Total = row3Litres * row3Rate;

    // Total 1 is Sangavi + Karkamb + Goti + Tulshi.
    final total1Litres =
        sangaviLitres + karkambLitres + gotiLitres + tulshiLitres;
    final total1Total = sangaviTotal + karkambTotal + gotiTotal + tulshiTotal;

    // Calculate Total 2 (I + II + III)
    final total2Litres = row1Litres + row2Litres + row3Litres;
    final total2Total = row1Total + row2Total + row3Total;

    // Combined total is Total 1 plus Total 2.
    final combinedLitres = total1Litres + total2Litres;
    final combinedTotal = total1Total + total2Total;

    // Update UI
    setState(() {
      _sangaviTotal = sangaviTotal;
      _karkambTotal = karkambTotal;
      _gotiTotal = gotiTotal;
      _tulshiTotal = tulshiTotal;
      _total1Litres = total1Litres;
      _total1Total = total1Total;
      _row1Total = row1Total;
      _row2Total = row2Total;
      _row3Total = row3Total;
      _total2Litres = total2Litres;
      _total2Total = total2Total;
      _combinedLitres = combinedLitres;
      _combinedTotal = combinedTotal;
    });

    // Create calculation object
    final calculation = DailyCalculation(
      id: _currentRecordId,
      date: _selectedDate,
      sangaviLitres: sangaviLitres,
      sangaviRate: sangaviRate,
      sangaviTotal: sangaviTotal,
      karkambLitres: karkambLitres,
      karkambRate: karkambRate,
      karkambTotal: karkambTotal,
      gotiLitres: gotiLitres,
      gotiRate: gotiRate,
      gotiTotal: gotiTotal,
      tulshiLitres: tulshiLitres,
      tulshiRate: tulshiRate,
      tulshiTotal: tulshiTotal,
      total1Litres: total1Litres,
      total1Total: total1Total,
      row1Litres: row1Litres,
      row1Rate: row1Rate,
      row1Total: row1Total,
      row2Litres: row2Litres,
      row2Rate: row2Rate,
      row2Total: row2Total,
      row3Litres: row3Litres,
      row3Rate: row3Rate,
      row3Total: row3Total,
      total2Litres: total2Litres,
      total2Total: total2Total,
      combinedLitres: combinedLitres,
      combinedTotal: combinedTotal,
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
      _sangaviLitresController.clear();
      _sangaviRateController.clear();
      _karkambLitresController.clear();
      _karkambRateController.clear();
      _gotiLitresController.clear();
      _gotiRateController.clear();
      _tulshiLitresController.clear();
      _tulshiRateController.clear();
      _row1LitresController.clear();
      _row1RateController.clear();
      _row2LitresController.clear();
      _row2RateController.clear();
      _row3LitresController.clear();
      _row3RateController.clear();

      _sangaviTotal = 0;
      _karkambTotal = 0;
      _gotiTotal = 0;
      _tulshiTotal = 0;
      _total1Litres = 0;
      _total1Total = 0;
      _row1Total = 0;
      _row2Total = 0;
      _row3Total = 0;
      _total2Litres = 0;
      _total2Total = 0;
      _combinedLitres = null; // Reset to null to show "—"
      _combinedTotal = null;
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
            const Icon(Icons.check_circle_outline,
                color: Colors.white, size: 20),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateSelector(),
                  const SizedBox(height: 10),
                  _buildActionButtons(),
                  const SizedBox(height: 12),
                  _buildCalculationTable(),
                  const SizedBox(height: 12),
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.warmWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hasExistingData
                ? AppColors.forestGreen.withValues(alpha: 0.5)
                : AppColors.border,
            width: _hasExistingData ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: AppColors.accentGradient,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_selectedDate.day}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  Text(
                    DateFormat('MMM').format(_selectedDate).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
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
              icon:
                  Icon(Icons.delete_outline_rounded, color: AppColors.barnRed),
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
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTableHeader(),
          const Divider(color: AppColors.border, height: 12),
          _buildInputRow(
            CollectionCenters.sangavi,
            _sangaviLitresController,
            _sangaviRateController,
            _formatNumber(_sangaviTotal),
          ),
          _buildInputRow(
            CollectionCenters.karkamb,
            _karkambLitresController,
            _karkambRateController,
            _formatNumber(_karkambTotal),
          ),
          _buildInputRow(
            CollectionCenters.goti,
            _gotiLitresController,
            _gotiRateController,
            _formatNumber(_gotiTotal),
          ),
          _buildInputRow(
            CollectionCenters.tulshi,
            _tulshiLitresController,
            _tulshiRateController,
            _formatNumber(_tulshiTotal),
          ),
          _buildCalculatedRow(
            'Total 1',
            _formatNumber(_total1Litres),
            _formatNumber(_total1Total),
            isHighlighted: true,
          ),
          const Divider(color: AppColors.border, height: 16),
          // I, II, III section
          _buildInputRow(
            'I',
            _row1LitresController,
            _row1RateController,
            _formatNumber(_row1Total),
          ),
          _buildInputRow(
            'II',
            _row2LitresController,
            _row2RateController,
            _formatNumber(_row2Total),
          ),
          _buildInputRow(
            'III',
            _row3LitresController,
            _row3RateController,
            _formatNumber(_row3Total),
          ),
          _buildCalculatedRow(
            'Total 2',
            _formatNumber(_total2Litres),
            _formatNumber(_total2Total),
            isSubtotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          SizedBox(
            width: _labelWidth,
            child: Text('Item',
                style: AppTextStyles.caption.copyWith(fontSize: 11)),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Text('Litres',
                  style: AppTextStyles.caption.copyWith(fontSize: 11)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Center(
              child: Text('Rate ₹',
                  style: AppTextStyles.caption.copyWith(fontSize: 11)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text('Total ₹',
                style: AppTextStyles.caption.copyWith(fontSize: 11),
                textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }

  Widget _buildInputRow(
    String label,
    TextEditingController litresController,
    TextEditingController rateController,
    String total,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          RowLabel(text: label, width: _labelWidth),
          Expanded(
            flex: 3,
            child: NumberInputField(
              controller: litresController,
              hint: 'Litres',
              isUltraCompact: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '×',
              style: TextStyle(
                color: AppColors.textLight,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: NumberInputField(
              controller: rateController,
              hint: 'Rate',
              isUltraCompact: true,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 4,
            child: ValueDisplay(
              value: total,
              isHighlighted: total.isNotEmpty,
              isUltraCompact: true,
              minWidth: 50,
            ),
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
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppColors.forestGreen.withValues(alpha: 0.08)
            : isSubtotal
                ? AppColors.goldenHay.withValues(alpha: 0.1)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isHighlighted || isSubtotal
            ? Border.all(
                color: isHighlighted
                    ? AppColors.forestGreen.withValues(alpha: 0.25)
                    : AppColors.goldenHay.withValues(alpha: 0.35),
                width: 1,
              )
            : null,
      ),
      child: Row(
        children: [
          RowLabel(
            text: label,
            width: _labelWidth,
            isSubLabel: isSubtotal,
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              decoration: BoxDecoration(
                color: AppColors.warmWhite,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                litres.isEmpty ? '—' : litres,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w600,
                  color: isHighlighted
                      ? AppColors.forestGreen
                      : AppColors.textPrimary,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: const SizedBox(),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 4,
            child: ValueDisplay(
              value: total,
              isTotal: isHighlighted,
              isHighlighted: isSubtotal,
              isUltraCompact: true,
              minWidth: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    final hasValue = _combinedTotal != null;
    final valueColor = hasValue ? AppColors.forestGreen : AppColors.textLight;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.forestGreen.withValues(alpha: 0.1),
            AppColors.forestGreen.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.forestGreen.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_rounded,
                color: AppColors.forestGreen,
                size: 22,
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  Text(
                    'Total',
                    style: AppTextStyles.heading3.copyWith(fontSize: 16),
                  ),
                  Text(
                    '(Total 1 + Total 2)',
                    style: AppTextStyles.caption.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('Litres', style: AppTextStyles.caption),
                  const SizedBox(height: 2),
                  Text(
                    _combinedLitres == null
                        ? '—'
                        : (_combinedLitres == 0
                            ? '0'
                            : _formatNumber(_combinedLitres!)),
                    style: AppTextStyles.heading3.copyWith(color: valueColor),
                  ),
                ],
              ),
              Container(
                height: 30,
                width: 1,
                color: AppColors.border,
              ),
              Column(
                children: [
                  Text('Total Amt', style: AppTextStyles.caption),
                  const SizedBox(height: 2),
                  Text(
                    _combinedTotal == null
                        ? '—'
                        : (_combinedTotal == 0
                            ? '₹0'
                            : '₹${_formatNumber(_combinedTotal!)}'),
                    style: AppTextStyles.heading3.copyWith(color: valueColor),
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

      // Sort by date descending (latest first) as a safeguard
      calculations.sort((a, b) => b.date.compareTo(a.date));

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
                    'Total1: ${_formatNumber(calc.total1Litres)}L • ₹${_formatNumber(calc.total1Total)}',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${_formatNumber(calc.combinedTotal)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.forestGreen,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Total',
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
