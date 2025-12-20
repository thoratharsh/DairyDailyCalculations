import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

class MonthlyPage extends StatefulWidget {
  const MonthlyPage({super.key});

  @override
  State<MonthlyPage> createState() => _MonthlyPageState();
}

class _MonthlyPageState extends State<MonthlyPage>
    with SingleTickerProviderStateMixin {
  static const int _rowCount = 50;

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
      duration: const Duration(milliseconds: 600),
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
            const Text('33-day totals calculated'),
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: AppColors.goldenHay),
            const SizedBox(width: 12),
            const Text('Clear All Data?'),
          ],
        ),
        content: const Text(
          'This will remove all entries. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.barnRed,
            ),
            onPressed: () {
              Navigator.pop(context);
              _performClear();
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _performClear() {
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
        title: const Text('Monthly Calculation'),
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
              child: const Icon(Icons.info_outline_rounded, size: 18),
            ),
            onPressed: _showInfoDialog,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: _buildActionButtons(),
          ),
          _buildSummaryCard(),
          Expanded(
            child: _buildCalculationList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _calculateAll,
        backgroundColor: AppColors.forestGreen,
        icon: const Icon(Icons.calculate_rounded),
        label: const Text('Calculate'),
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.forestGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('📆', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 12),
            const Text('33-Day Cycle'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track milk collection for a complete dairy payment cycle.',
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 16),
            _buildInfoItem(Icons.edit_rounded, 'Enter quantity and rate'),
            _buildInfoItem(Icons.calculate_rounded, 'Auto-calculates amounts'),
            _buildInfoItem(Icons.summarize_rounded, 'View running totals'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.forestGreen),
          const SizedBox(width: 12),
          Text(text, style: AppTextStyles.label),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ActionButton(
            text: 'Clear All',
            icon: Icons.delete_outline_rounded,
            onPressed: _clearAll,
            isPrimary: false,
            isDestructive: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ActionButton(
            text: 'Calculate Totals',
            icon: Icons.calculate_rounded,
            onPressed: _calculateAll,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSummaryItem(
            'Total Qty',
            _totalQuantity == 0 ? '—' : _formatNumber(_totalQuantity),
            Icons.water_drop_outlined,
          ),
          Container(
            height: 30,
            width: 1,
            color: AppColors.border,
          ),
          _buildSummaryItem(
            'Total Amt',
            _totalAmount == 0 ? '—' : '₹${_formatNumber(_totalAmount)}',
            Icons.currency_rupee_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: AppColors.forestGreen),
            const SizedBox(width: 3),
            Text(label, style: AppTextStyles.caption.copyWith(fontSize: 10)),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.forestGreen,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildCalculationList() {
    return FadeTransition(
      opacity: _animController,
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 70),
        decoration: BoxDecoration(
          color: AppColors.warmWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              _buildHeader(),
              const Divider(color: AppColors.border, height: 1),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  itemCount: _rowCount,
                  itemBuilder: (context, index) {
                    return _buildRow(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.milkWhite,
      ),
      child: Row(
        children: [
          const SizedBox(width: 30),
          const SizedBox(width: 6),
          Expanded(
            flex: 3,
            child: Center(
              child: Text('Qty (L)', style: AppTextStyles.caption.copyWith(fontSize: 11)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Center(
              child: Text('Rate ₹', style: AppTextStyles.caption.copyWith(fontSize: 11)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Text('Amount',
                style: AppTextStyles.caption.copyWith(fontSize: 11), textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: index.isEven ? Colors.transparent : AppColors.cream.withOpacity(0.4),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          SerialBadge(number: '${index + 1}', isCompact: true),
          const SizedBox(width: 6),
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
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text('×', style: TextStyle(color: AppColors.textLight, fontSize: 11)),
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
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text('=', style: TextStyle(color: AppColors.textLight, fontSize: 11)),
          ),
          Expanded(
            flex: 3,
            child: ValueDisplay(
              value: _formatNumber(_results[index]),
              isHighlighted: _results[index] > 0,
              isUltraCompact: true,
              minWidth: 45,
            ),
          ),
        ],
      ),
    );
  }
}



