import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';

class HospitalAnalyticsScreen extends StatelessWidget {
  const HospitalAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Multi-Patient Trends",
                style: TextStyle(color: AppColors.text2, fontSize: 14)),
            const Text("Hospital Analytics",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            GlassCard(
                borderColor: AppColors.secondary.withOpacity(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.bed, color: AppColors.secondary),
                        const SizedBox(width: 8),
                        const Expanded(
                            child: Text("Ward Occupancy",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text("80% capacity",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text(
                        "40 active beds monitoring. 3 require attention.",
                        style: TextStyle(color: AppColors.text2)),
                  ],
                )),
            const SizedBox(height: 24),
            const Text("Diagnostic Insights (AI)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _buildDiagCard("Hypoxia Risk Spike", 3, AppColors.danger,
                "3 patients detected with <90% SpO2 concurrently."),
            const SizedBox(height: 12),
            _buildDiagCard("Arrhythmia Stability", 12, AppColors.success,
                "Cardiac rhythm anomalies decreased globally across ward tonight."),
          ],
        ));
  }

  Widget _buildDiagCard(String title, int count, Color color, String desc) {
    return GlassCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
                const SizedBox(width: 8),
                CircleAvatar(
                    radius: 12,
                    backgroundColor: color.withOpacity(0.2),
                    child: Text("$count",
                        style: TextStyle(
                            fontSize: 12,
                            color: color,
                            fontWeight: FontWeight.bold)))
              ],
            ),
            const SizedBox(height: 12),
            Text(desc,
                style: const TextStyle(
                    color: AppColors.text2, fontSize: 13, height: 1.4)),
          ],
        ));
  }
}
