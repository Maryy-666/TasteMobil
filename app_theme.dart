import 'package:flutter/material.dart';
import '../models/my_recipe.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  static const _weekDays = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
  static const _weekValues = [320.0, 480.0, 210.0, 890.0, 540.0, 670.0, 340.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(title: const Text('Kazanç')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStatsRow(),
          const SizedBox(height: 20),
          _buildEarningsChart(),
          const SizedBox(height: 20),
          const Text(
            'Son İşlemler',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._buildTransactions(),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: MetricCard(
            value: '₺6.840',
            label: 'Bu Ay',
            delta: '+23%',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: MetricCard(
            value: '47',
            label: 'Satış',
            delta: '+8%',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: MetricCard(
            value: '4.8',
            label: 'Puan',
            delta: '+0.2',
          ),
        ),
      ],
    );
  }

  Widget _buildEarningsChart() {
    final maxVal = _weekValues.reduce((a, b) => a > b ? a : b);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Son 7 Günlük Kazanç',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(_weekDays.length, (i) {
                final heightPct = _weekValues[i] / maxVal;
                final isHighlight = i == 3; // Per
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: FractionallySizedBox(
                              heightFactor: heightPct,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isHighlight
                                      ? AppColors.brand
                                      : AppColors.brand.withOpacity(0.45),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _weekDays[i],
                          style: TextStyle(
                            fontSize: 10,
                            color: isHighlight
                                ? AppColors.brand
                                : AppColors.textMuted,
                            fontWeight: isHighlight
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'En yüksek gün: Perşembe',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              Text(
                '₺890',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTransactions() {
    return TransactionData.getAll().map((t) {
      Widget? trailing;
      if (t.isEarning && t.amount != null) {
        trailing = Text(
          '+₺${t.amount!.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.success,
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: NotifItem(
          boldPart: t.boldPart,
          message: t.message,
          time: t.time,
          isRead: t.isRead,
          trailing: trailing,
        ),
      );
    }).toList();
  }
}
