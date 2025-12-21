import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'daily_calculation_page.dart';
import 'ten_days_page.dart';
import 'monthly_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late List<Animation<double>> _cardAnimations;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _cardAnimations = List.generate(3, (index) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _scaleController,
          curve: Interval(
            index * 0.15,
            0.6 + index * 0.15,
            curve: Curves.easeOutBack,
          ),
        ),
      );
    });

    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.primaryGradient,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                _buildHeader(),
                const SizedBox(height: 40),
                Expanded(
                  child: _buildCalculationCards(),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeTransition(
      opacity: _fadeController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.forestGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  '🥛',
                  style: TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dairy Daily',
                      style: AppTextStyles.heading1,
                    ),
                    Text(
                      'Calculations made simple',
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildDateCard(),
        ],
      ),
    );
  }

  Widget _buildDateCard() {
    final now = DateTime.now();
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warmWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
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
                  '${now.day}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                Text(
                  months[now.month - 1].substring(0, 3).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                days[now.weekday - 1],
                style: AppTextStyles.bodyBold,
              ),
              const SizedBox(height: 2),
              Text(
                '${months[now.month - 1]} ${now.year}',
                style: AppTextStyles.caption,
              ),
            ],
          ),
          const Spacer(),
          Icon(
            Icons.wb_sunny_rounded,
            color: AppColors.goldenHay,
            size: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildCalculationCards() {
    final calculationTypes = [
      _CalculationType(
        title: 'Daily',
        subtitle: 'Quick daily milk calculations',
        icon: Icons.today_rounded,
        color: AppColors.forestGreen,
        secondaryColor: const Color(0xFF6B9F78),
        emoji: '📊',
        page: const DailyCalculationPage(),
      ),
      _CalculationType(
        title: '10 Days',
        subtitle: 'Track 10-day collection period',
        icon: Icons.date_range_rounded,
        color: AppColors.skyBlue,
        secondaryColor: const Color(0xFF8BB8D9),
        emoji: '📅',
        page: const TenDaysPage(),
      ),
      _CalculationType(
        title: 'Monthly',
        subtitle: 'Complete 33-day cycle tracking',
        icon: Icons.calendar_month_rounded,
        color: AppColors.goldenHay,
        secondaryColor: const Color(0xFFE0BC6A),
        emoji: '📆',
        page: const MonthlyPage(),
      ),
    ];

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: calculationTypes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final type = calculationTypes[index];
        return AnimatedBuilder(
          animation: _cardAnimations[index],
          builder: (context, child) {
            return Transform.scale(
              scale: 0.8 + (0.2 * _cardAnimations[index].value),
              child: Opacity(
                opacity: _cardAnimations[index].value,
                child: child,
              ),
            );
          },
          child: _buildCalculationCard(type),
        );
      },
    );
  }

  Widget _buildCalculationCard(_CalculationType type) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => type.page,
            transitionsBuilder: (_, animation, __, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.warmWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: type.color.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [type.color, type.secondaryColor],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: type.color.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  type.emoji,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${type.title} Calculation',
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    type.subtitle,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: type.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: type.color,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalculationType {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color secondaryColor;
  final String emoji;
  final Widget page;

  const _CalculationType({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.secondaryColor,
    required this.emoji,
    required this.page,
  });
}

