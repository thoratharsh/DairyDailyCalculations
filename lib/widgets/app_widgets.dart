import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

/// Modern input field for number entry
class NumberInputField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final double width;
  final bool autoFocus;

  const NumberInputField({
    super.key,
    this.label,
    this.hint,
    required this.controller,
    this.onChanged,
    this.width = 100,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        autofocus: autoFocus,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        style: AppTextStyles.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        ],
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

/// Display field for calculated values
class ValueDisplay extends StatelessWidget {
  final String value;
  final double width;
  final TextAlign textAlign;
  final bool isTotal;
  final bool isHighlighted;

  const ValueDisplay({
    super.key,
    required this.value,
    this.width = 100,
    this.textAlign = TextAlign.right,
    this.isTotal = false,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppColors.forestGreen.withOpacity(0.08)
            : isTotal
                ? AppColors.goldenHay.withOpacity(0.15)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isTotal
            ? Border.all(color: AppColors.goldenHay.withOpacity(0.3))
            : null,
      ),
      child: Text(
        value.isEmpty ? '—' : value,
        textAlign: textAlign,
        style: isTotal
            ? AppTextStyles.total
            : value.isEmpty
                ? AppTextStyles.number.copyWith(color: AppColors.textLight)
                : AppTextStyles.number,
      ),
    );
  }
}

/// Row label widget
class RowLabel extends StatelessWidget {
  final String text;
  final double width;
  final bool isBold;
  final bool isSubLabel;

  const RowLabel({
    super.key,
    required this.text,
    this.width = 120,
    this.isBold = true,
    this.isSubLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: isSubLabel
            ? AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)
            : isBold
                ? AppTextStyles.bodyBold
                : AppTextStyles.label,
      ),
    );
  }
}

/// Serial number badge
class SerialBadge extends StatelessWidget {
  final String number;
  final bool isTotal;

  const SerialBadge({
    super.key,
    required this.number,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isTotal
            ? AppColors.forestGreen
            : AppColors.forestGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        number,
        style: TextStyle(
          fontSize: isTotal ? 11 : 13,
          fontWeight: FontWeight.w600,
          color: isTotal ? Colors.white : AppColors.forestGreen,
        ),
      ),
    );
  }
}

/// Action button with icon
class ActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isDestructive;

  const ActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isPrimary = true,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDestructive
        ? AppColors.barnRed.withOpacity(0.1)
        : isPrimary
            ? AppColors.forestGreen
            : AppColors.forestGreen.withOpacity(0.1);

    final foregroundColor = isDestructive
        ? AppColors.barnRed
        : isPrimary
            ? Colors.white
            : AppColors.forestGreen;

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: isDestructive || !isPrimary
              ? BorderSide(color: foregroundColor.withOpacity(0.3))
              : BorderSide.none,
        ),
      ),
    );
  }
}

/// Card with gradient background
class GradientCard extends StatelessWidget {
  final Widget child;
  final List<Color>? gradient;
  final EdgeInsets? padding;
  final double? width;

  const GradientCard({
    super.key,
    required this.child,
    this.gradient,
    this.padding,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient ?? AppColors.primaryGradient,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Date display widget
class DateDisplay extends StatelessWidget {
  const DateDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.warmWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_rounded,
            size: 16,
            color: AppColors.forestGreen,
          ),
          const SizedBox(width: 8),
          Text(
            '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]} ${now.year}',
            style: AppTextStyles.label.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Section header
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.heading3),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!, style: AppTextStyles.caption),
          ],
        ],
      ),
    );
  }
}

/// Calculation row widget - simplified for 10/33 day pages
class CalculationRow extends StatelessWidget {
  final int index;
  final TextEditingController quantityController;
  final TextEditingController rateController;
  final String result;
  final ValueChanged<String> onQuantityChanged;
  final ValueChanged<String> onRateChanged;
  final bool isAnimated;

  const CalculationRow({
    super.key,
    required this.index,
    required this.quantityController,
    required this.rateController,
    required this.result,
    required this.onQuantityChanged,
    required this.onRateChanged,
    this.isAnimated = true,
  });

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
              controller: quantityController,
              hint: 'Qty',
              onChanged: onQuantityChanged,
            ),
          ),
          const SizedBox(width: 8),
          const Text('×', style: TextStyle(color: AppColors.textLight)),
          const SizedBox(width: 8),
          Expanded(
            child: NumberInputField(
              controller: rateController,
              hint: 'Rate',
              onChanged: onRateChanged,
            ),
          ),
          const SizedBox(width: 8),
          const Text('=', style: TextStyle(color: AppColors.textLight)),
          const SizedBox(width: 8),
          ValueDisplay(
            value: result,
            width: 90,
            isHighlighted: result.isNotEmpty && result != '0.00',
          ),
        ],
      ),
    );

    if (isAnimated) {
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: Duration(milliseconds: 200 + (index * 30)),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: child,
            ),
          );
        },
        child: child,
      );
    }
    return child;
  }
}

/// Total row widget
class TotalRow extends StatelessWidget {
  final String totalQuantity;
  final String totalAmount;

  const TotalRow({
    super.key,
    required this.totalQuantity,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.forestGreen.withOpacity(0.05),
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
            child: ValueDisplay(
              value: totalQuantity,
              isTotal: true,
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
            value: totalAmount,
            width: 90,
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

