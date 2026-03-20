import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _hr = 64;
  int _spo2 = 98;
  int _br = 14;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (t) {
      if (mounted) {
        setState(() {
          _hr = 60 + Random().nextInt(10);
          _spo2 = 97 + Random().nextInt(3);
          _br = 12 + Random().nextInt(4);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 30),
          _buildHealthScoreCard(),
          const SizedBox(height: 24),
          _buildTwinAndTherapyRow(),
          const SizedBox(height: 24),
          const Text("Live Vitals Monitor",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          _buildVitalsGrid(),
          const SizedBox(height: 30),
          const Text("Overnight Heart Rate",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          _buildHeartRateChart(),
          const SizedBox(height: 30),
          const Text("AI Disease Prediction",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          _buildDiseasePredictionCard(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Good Morning, Alex",
                  style: TextStyle(color: AppColors.text2, fontSize: 14)),
              Text("Daily Health Summary",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(width: 16),
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.cardBg,
          backgroundImage: const NetworkImage(
              "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=200"),
          child: const Icon(Icons.person, color: AppColors.text1),
        )
      ],
    );
  }

  Widget _buildHealthScoreCard() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderColor: AppColors.primary.withOpacity(0.5),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: CircularProgressIndicator(
                  value: 0.92,
                  strokeWidth: 8,
                  color: AppColors.success,
                  backgroundColor: AppColors.bg0,
                  strokeCap: StrokeCap.round,
                ),
              ),
              const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("92",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Text("CREDIT",
                      style: TextStyle(
                          fontSize: 9,
                          color: AppColors.text2,
                          letterSpacing: 1)),
                ],
              )
            ],
          ),
          const SizedBox(width: 24),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Status: EXCELLENT",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: AppColors.success,
                        letterSpacing: 1)),
                SizedBox(height: 6),
                Text("90+ Excellent | 70-89 Healthy | <50 Critical",
                    style: TextStyle(
                        color: AppColors.text2,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text(
                    "Heart rhythm, SpO2, and temperature trends show optimal stability. Sleep apnea risk is 0%.",
                    style: TextStyle(
                        color: AppColors.text3, fontSize: 13, height: 1.4)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTwinAndTherapyRow() {
    return Row(children: [
      Expanded(
        child: _buildSmallFeatureCard(
            Icons.person_outline,
            "Sleep Digital Twin",
            "Virtual body model built. Future apnea prediction active.",
            AppColors.secondary),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: _buildSmallFeatureCard(
            Icons.spa,
            "AI Sleep Therapy",
            "Vibration therapy & breathing guidance engaged.",
            AppColors.primary),
      ),
    ]);
  }

  Widget _buildSmallFeatureCard(
      IconData icon, String title, String desc, Color color) {
    return GlassCard(
      borderColor: color.withOpacity(0.3),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 12),
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.white)),
          const SizedBox(height: 4),
          Text(desc,
              style: const TextStyle(color: AppColors.text3, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildVitalsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.2,
      children: [
        _buildVitalCard(
            "Heart Rate", "$_hr", "BPM", Icons.favorite, AppColors.danger),
        _buildVitalCard(
            "Blood Oxygen", "$_spo2", "%", Icons.air, AppColors.primary),
        _buildVitalCard(
            "Respiration", "$_br", "RPM", Icons.waves, AppColors.success),
        _buildVitalCard("Posture", "Side", "Optimal", Icons.airline_seat_flat,
            AppColors.secondary),
      ],
    );
  }

  Widget _buildVitalCard(
      String title, String value, String unit, IconData icon, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: color, blurRadius: 6)]),
              )
            ],
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1)),
                const SizedBox(width: 4),
                Text(unit,
                    style:
                        const TextStyle(fontSize: 12, color: AppColors.text2)),
              ],
            ),
          ),
          Text(title,
              style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.text3,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildHeartRateChart() {
    return GlassCard(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: SizedBox(
        height: 180,
        child: LineChart(LineChartData(
          gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (v) =>
                  FlLine(color: AppColors.border, strokeWidth: 1)),
          titlesData: FlTitlesData(
              show: true,
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (v, m) => Text(v.toInt().toString(),
                          style: const TextStyle(
                              color: AppColors.text3, fontSize: 10)))),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      getTitlesWidget: (v, m) {
                        const times = ['10PM', '12AM', '2AM', '4AM', '6AM'];
                        if (v.toInt() >= 0 && v.toInt() < times.length)
                          return Text(times[v.toInt()],
                              style: const TextStyle(
                                  color: AppColors.text3, fontSize: 10));
                        return const SizedBox();
                      }))),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 4,
          minY: 40,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 75),
                FlSpot(1, 62),
                FlSpot(2, 58),
                FlSpot(3, 60),
                FlSpot(4, 68)
              ],
              isCurved: true,
              color: AppColors.danger,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: [
                  AppColors.danger.withOpacity(0.3),
                  Colors.transparent
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget _buildDiseasePredictionCard() {
    return GlassCard(
      borderColor: AppColors.secondary.withOpacity(0.4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.2),
                shape: BoxShape.circle),
            child: const Icon(Icons.psychology, color: AppColors.secondary),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("No Abnormalities Detected",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 4),
                Text("Screened for Stroke, Apnea & 120+ conditions.",
                    style: TextStyle(color: AppColors.text2, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
