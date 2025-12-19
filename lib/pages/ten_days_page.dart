import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

class TenDaysPage extends StatefulWidget {
  const TenDaysPage({super.key});

  @override
  State<TenDaysPage> createState() => _TenDaysPageState();
}

class _TenDaysPageState extends State<TenDaysPage>
    with SingleTickerProviderStateMixin {
  static const int _rowCount = 10;

  late final List<TextEditingController> _quantityControllers;
  late final List<TextEditingController> _rateControllers;
  late final List<double> _results;
  late AnimationController _animController;

  double _totalQuantity = 0;
  double _totalAmount = 0;

  @override
  void initState() {
    super.initState();
    _quantityControllers =
        List.generate(_rowCount, (_) => TextEditingController());
    _rateControllers =
        List.generate(_rowCount, (_) => TextEditingController());
    _results = List.generate(_rowCount, (_) => 0.0);

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    for (var c in _quantityControllers) {
      c.dispose();
    }
    for (var c in _rateControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _updateRowResult(int index) {
    final qty = double.tryParse(_quantityControllers[index].text) ?? 0;
    final rate = double.tryParse(_rateControllers[index].text) ?? 0;
    setState(() {
      _results[index] = qty * rate;
    });
  }

  void _calculateAll() {
    setState(() {
      _totalQuantity = 0;
      _totalAmount = 0;

      for (int i = 0; i < _rowCount; i++) {
        final qty = double.tryParse(_quantityControllers[i].text) ?? 0;
        final rate = double.tryParse(_rateControllers[i].text) ?? 0;
        _results[i] = qty * rate;
        _totalQuantity += qty;
        _totalAmount += _results[i];
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline,
                color: Colors.white, size: 20),
            const SizedBox(width: 12),
            const Text('Calculations complete'),
          ],
        ),
        backgroundColor: AppColors.forestGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _clearAll() {
    setState(() {
      for (int i = 0; i < _rowCount; i++) {
        _quantityControllers[i].clear();
        _rateControllers[i].clear();
        _results[i] = 0;
      }
      _totalQuantity = 0;
      _totalAmount = 0;
    });
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
        title: const Text('10 Days Calculation'),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: _buildActionButtons(),
          ),
          Expanded(
            child: _buildCalculationList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
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
            text: 'Calculate All',
            icon: Icons.calculate_rounded,
            onPressed: _calculateAll,
          ),
        ),
      ],
    );
  }

  Widget _buildCalculationList() {
    return FadeTransition(
      opacity: _animController,
      child: GradientCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeader(),
            const Divider(color: AppColors.border, height: 16),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _rowCount,
                itemBuilder: (context, index) {
                  return _buildRow(index);
                },
              ),
            ),
            const Divider(color: AppColors.border, height: 16),
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
          const SizedBox(width: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Center(
              child: Text('Quantity', style: AppTextStyles.caption),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Center(
              child: Text('Rate (₹)', style: AppTextStyles.caption),
            ),
          ),
          const SizedBox(width: 24),
          SizedBox(
            width: 90,
            child: Text('Amount',
                style: AppTextStyles.caption, textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      decoration: BoxDecoration(
        color: index.isEven ? Colors.transparent : AppColors.milkWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SerialBadge(number: '${index + 1}'),
          const SizedBox(width: 12),
          Expanded(
            child: NumberInputField(
              controller: _quantityControllers[index],
              hint: '0',
              onChanged: (_) => _updateRowResult(index),
            ),
          ),
          const SizedBox(width: 8),
          const Text('×', style: TextStyle(color: AppColors.textLight)),
          const SizedBox(width: 8),
          Expanded(
            child: NumberInputField(
              controller: _rateControllers[index],
              hint: '0',
              onChanged: (_) => _updateRowResult(index),
            ),
          ),
          const SizedBox(width: 8),
          const Text('=', style: TextStyle(color: AppColors.textLight)),
          const SizedBox(width: 8),
          ValueDisplay(
            value: _formatNumber(_results[index]),
            width: 90,
            isHighlighted:
                _results[index] > 0,
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.forestGreen.withOpacity(0.08),
            AppColors.goldenHay.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.forestGreen.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const SerialBadge(number: 'Σ', isTotal: true),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.goldenHay.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _totalQuantity == 0 ? '—' : _formatNumber(_totalQuantity),
                textAlign: TextAlign.center,
                style: AppTextStyles.total,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text('', style: TextStyle(color: Colors.transparent)),
          const SizedBox(width: 8),
          const Expanded(child: SizedBox()),
          const SizedBox(width: 8),
          const Text('=', style: TextStyle(color: AppColors.forestGreen)),
          const SizedBox(width: 8),
          ValueDisplay(
            value: _totalAmount == 0 ? '' : '₹${_formatNumber(_totalAmount)}',
            width: 100,
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

