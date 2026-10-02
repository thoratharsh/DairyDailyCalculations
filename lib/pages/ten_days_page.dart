import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/collection_centers.dart';
import '../models/ten_day_calculation.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

class TenDaysPage extends StatefulWidget {
  const TenDaysPage({super.key});

  @override
  State<TenDaysPage> createState() => _TenDaysPageState();
}

class _TenDaysPageState extends State<TenDaysPage>
    with SingleTickerProviderStateMixin {
  static const int _rowCount = TenDayCalculation.rowCount;

  final DatabaseService _dbService = DatabaseService();

  late final List<TextEditingController> _quantityControllers;
  late final List<TextEditingController> _rateControllers;
  late final List<double> _results;
  late AnimationController _animController;

  DateTime _selectedDate = DateTime.now();
  String _selectedCenter = CollectionCenters.names.first;
  bool _isLoading = false;
  bool _hasExistingData = false;
  int? _currentRecordId;
  int _loadToken = 0;

  double _totalQuantity = 0;
  double _totalAmount = 0;

  @override
  void initState() {
    super.initState();
    _quantityControllers =
        List.generate(_rowCount, (_) => TextEditingController());
    _rateControllers = List.generate(_rowCount, (_) => TextEditingController());
    _results = List.generate(_rowCount, (_) => 0.0);

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _loadForSelection();
  }

  @override
  void dispose() {
    _animController.dispose();
    for (final controller in _quantityControllers) {
      controller.dispose();
    }
    for (final controller in _rateControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<String> get _centerOptions {
    final centers = List<String>.from(CollectionCenters.names);
    if (!centers.contains(_selectedCenter)) {
      centers.add(_selectedCenter);
    }
    return centers;
  }

  /// Load the sheet saved for the current center and date, or start blank.
  Future<void> _loadForSelection() async {
    final token = ++_loadToken;
    final center = _selectedCenter;
    final date = _selectedDate;
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      final record = await _dbService.getTenDayCalculation(center, date);
      if (!mounted || token != _loadToken) return;

      setState(() {
        if (record == null) {
          _resetNumbers();
          _hasExistingData = false;
          _currentRecordId = null;
        } else {
          _applyRecord(record);
        }
      });
    } catch (e) {
      if (mounted && token == _loadToken) {
        _showErrorSnackBar('Failed to load data: $e');
      }
    } finally {
      if (mounted && token == _loadToken) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _applyRecord(TenDayCalculation record) {
    for (var i = 0; i < _rowCount; i++) {
      _quantityControllers[i].text = _formatInput(record.quantities[i]);
      _rateControllers[i].text = _formatInput(record.rates[i]);
      _results[i] = record.amountAt(i);
    }
    _totalQuantity = record.totalQuantity;
    _totalAmount = record.totalAmount;
    _hasExistingData = true;
    _currentRecordId = record.id;
  }

  void _resetNumbers() {
    for (var i = 0; i < _rowCount; i++) {
      _quantityControllers[i].clear();
      _rateControllers[i].clear();
      _results[i] = 0;
    }
    _totalQuantity = 0;
    _totalAmount = 0;
  }

  void _updateRowResult(int index) {
    final qty = double.tryParse(_quantityControllers[index].text) ?? 0;
    final rate = double.tryParse(_rateControllers[index].text) ?? 0;
    setState(() {
      _results[index] = qty * rate;
    });
  }

  /// Multiply every row, then store the sheet against the selected center and date.
  Future<void> _calculateAndSave() async {
    final quantities = <double>[];
    final rates = <double>[];
    var totalQuantity = 0.0;
    var totalAmount = 0.0;

    for (var i = 0; i < _rowCount; i++) {
      final qty = double.tryParse(_quantityControllers[i].text) ?? 0;
      final rate = double.tryParse(_rateControllers[i].text) ?? 0;
      final amount = qty * rate;
      quantities.add(qty);
      rates.add(rate);
      totalQuantity += qty;
      totalAmount += amount;
    }

    setState(() {
      for (var i = 0; i < _rowCount; i++) {
        _results[i] = quantities[i] * rates[i];
      }
      _totalQuantity = totalQuantity;
      _totalAmount = totalAmount;
    });

    final calculation = TenDayCalculation(
      id: _currentRecordId,
      center: _selectedCenter,
      date: _selectedDate,
      quantities: quantities,
      rates: rates,
      totalQuantity: totalQuantity,
      totalAmount: totalAmount,
    );

    final isUpdate = _hasExistingData;
    try {
      await _dbService.saveTenDayCalculation(calculation);
      final saved = await _dbService.getTenDayCalculation(
        _selectedCenter,
        _selectedDate,
      );
      if (!mounted) return;

      setState(() {
        _hasExistingData = true;
        _currentRecordId = saved?.id;
      });
      _showSuccessSnackBar(
        isUpdate
            ? 'Updated for $_selectedCenter'
            : 'Saved for $_selectedCenter',
      );
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to save: $e');
      }
    }
  }

  void _clearAll() {
    setState(_resetNumbers);
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
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

    if (picked != null && !DateUtils.isSameDay(picked, _selectedDate)) {
      setState(() => _selectedDate = picked);
      await _loadForSelection();
    }
  }

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
          'Delete the $_selectedCenter sheet for '
          '${DateFormat('dd MMM yyyy').format(_selectedDate)}?\n'
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.barnRed),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await _dbService.deleteTenDayCalculation(_currentRecordId!);
      if (!mounted) return;
      setState(() {
        _resetNumbers();
        _hasExistingData = false;
        _currentRecordId = null;
      });
      _showSuccessSnackBar('Entry deleted');
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to delete: $e');
      }
    }
  }

  void _openHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _TenDayHistoryPage(
          onRecordSelected: (center, date) {
            final local = date.toLocal();
            setState(() {
              _selectedCenter = center;
              _selectedDate = DateTime(local.year, local.month, local.day);
            });
            _loadForSelection();
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
            Expanded(child: Text(message)),
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

  String _formatInput(double value) {
    if (value == 0) return '';
    return value.truncateToDouble() == value
        ? value.toInt().toString()
        : value.toString();
  }

  String _formatNumber(double value) {
    if (value == 0) return '';
    return value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text('11 Days Calculation'),
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
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                  child: _buildDateSelector(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: _buildCenterPicker(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
                  child: _buildActionButtons(),
                ),
                Expanded(child: _buildCalculationList()),
              ],
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
                gradient: const LinearGradient(
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
            Icon(
              Icons.calendar_today_rounded,
              color: AppColors.textSecondary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterPicker() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.warmWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Text('Center', style: AppTextStyles.caption),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCenter,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.forestGreen,
                ),
                items: _centerOptions
                    .map(
                      (name) => DropdownMenuItem<String>(
                        value: name,
                        child: Text(name, style: AppTextStyles.bodyBold),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null || value == _selectedCenter) return;
                  setState(() => _selectedCenter = value);
                  _loadForSelection();
                },
              ),
            ),
          ),
        ],
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
            onPressed: _clearAll,
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

  Widget _buildCalculationList() {
    return FadeTransition(
      opacity: _animController,
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.warmWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            _buildHeader(),
            const Divider(color: AppColors.border, height: 10),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _rowCount,
                itemBuilder: (context, index) => _buildRow(index),
              ),
            ),
            const Divider(color: AppColors.border, height: 10),
            _buildTotalRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          const SizedBox(width: 30),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Center(
              child: Text('Qty (L)', style: AppTextStyles.caption),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Center(
              child: Text('Rate ₹', style: AppTextStyles.caption),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Text(
              'Amount',
              style: AppTextStyles.caption,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      decoration: BoxDecoration(
        color: index.isEven
            ? Colors.transparent
            : AppColors.milkWhite.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          SerialBadge(number: '${index + 1}', isCompact: true),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: NumberInputField(
              controller: _quantityControllers[index],
              hint: '0',
              onChanged: (_) => _updateRowResult(index),
              isUltraCompact: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '×',
              style: TextStyle(color: AppColors.textLight, fontSize: 12),
            ),
          ),
          Expanded(
            flex: 3,
            child: NumberInputField(
              controller: _rateControllers[index],
              hint: '0',
              onChanged: (_) => _updateRowResult(index),
              isUltraCompact: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '=',
              style: TextStyle(color: AppColors.textLight, fontSize: 12),
            ),
          ),
          Expanded(
            flex: 3,
            child: ValueDisplay(
              value: _formatNumber(_results[index]),
              isHighlighted: _results[index] > 0,
              isUltraCompact: true,
              minWidth: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.forestGreen.withValues(alpha: 0.08),
            AppColors.goldenHay.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.forestGreen.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const SerialBadge(number: 'Σ', isTotal: true, isCompact: true),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.goldenHay.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _totalQuantity == 0 ? '—' : _formatNumber(_totalQuantity),
                textAlign: TextAlign.center,
                style: AppTextStyles.total.copyWith(fontSize: 14),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: SizedBox(width: 12),
          ),
          const Expanded(flex: 3, child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '=',
              style: TextStyle(color: AppColors.forestGreen, fontSize: 14),
            ),
          ),
          Expanded(
            flex: 3,
            child: ValueDisplay(
              value: _totalAmount == 0 ? '' : '₹${_formatNumber(_totalAmount)}',
              isTotal: true,
              isUltraCompact: true,
              minWidth: 50,
            ),
          ),
        ],
      ),
    );
  }
}

/// History lists saved 11-day sheets. Each row is a center plus a date.
/// There is no filter: tap a row to open that sheet.
class _TenDayHistoryPage extends StatefulWidget {
  final void Function(String center, DateTime date) onRecordSelected;

  const _TenDayHistoryPage({required this.onRecordSelected});

  @override
  State<_TenDayHistoryPage> createState() => _TenDayHistoryPageState();
}

class _TenDayHistoryPageState extends State<_TenDayHistoryPage> {
  final DatabaseService _dbService = DatabaseService();
  List<TenDayCalculation> _records = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final records = await _dbService.getAllTenDayCalculations();
      if (!mounted) return;
      setState(() => _records = records);
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
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text('11 Day History'),
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
          : _records.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  itemCount: _records.length,
                  itemBuilder: (context, index) =>
                      _buildHistoryItem(_records[index]),
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_rounded, size: 64, color: AppColors.textLight),
          const SizedBox(height: 16),
          Text(
            'No records yet',
            style: AppTextStyles.heading3.copyWith(color: AppColors.textLight),
          ),
          const SizedBox(height: 8),
          Text(
            'Save an 11-day calculation to see it here',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(TenDayCalculation record) {
    return GestureDetector(
      onTap: () {
        widget.onRecordSelected(record.center, record.date);
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
                    '${record.date.toLocal().day}',
                    style: TextStyle(
                      color: AppColors.forestGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  Text(
                    DateFormat('MMM')
                        .format(record.date.toLocal())
                        .toUpperCase(),
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
                  Text(record.center, style: AppTextStyles.bodyBold),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('EEEE, dd MMM yyyy')
                        .format(record.date.toLocal()),
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }
}
