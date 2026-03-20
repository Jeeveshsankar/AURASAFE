import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Long-term Health",
              style: TextStyle(color: AppColors.text2, fontSize: 14)),
          const Text("Analytics & Trends",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          GlassCard(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Stroke Risk Probability",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: LineChart(LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 10,
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 2),
                        FlSpot(1, 1.8),
                        FlSpot(2, 2.1),
                        FlSpot(3, 1.5),
                        FlSpot(4, 1.2),
                        FlSpot(5, 1.0),
                        FlSpot(6, 0.5)
                      ],
                      isCurved: true,
                      color: AppColors.success,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                          show: true,
                          color: AppColors.success.withOpacity(0.1)),
                    ),
                  ],
                )),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.trending_down, color: AppColors.success),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text("Risk reduced by 15% this month",
                          style: TextStyle(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600))),
                ],
              )
            ],
          )),
          const SizedBox(height: 24),
          const Text("AI Trend Predictions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          _buildPredictionCard(
              "Sleep Apnea",
              2,
              "Low probability based on breathing rhythm stability over 30 days.",
              AppColors.success),
          const SizedBox(height: 12),
          _buildPredictionCard(
              "Arrhythmia",
              12,
              "Slight micro-irregularities detected. Not significant, but monitoring.",
              AppColors.warning),
          const SizedBox(height: 12),
          _buildPredictionCard(
              "Metabolic Shift",
              1,
              "Body temperature norms represent optimal metabolic resting states.",
              AppColors.success),
        ],
      ),
    );
  }

  Widget _buildPredictionCard(
      String condition, int riskPercent, String description, Color color) {
    return GlassCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(condition,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text("$riskPercent% Risk",
                      style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
            const SizedBox(height: 12),
            Text(description,
                style: const TextStyle(
                    color: AppColors.text2, fontSize: 13, height: 1.4)),
          ],
        ));
  }
}
