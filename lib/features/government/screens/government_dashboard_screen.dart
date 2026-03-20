import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';

class GovernmentDashboardScreen extends StatelessWidget {
  const GovernmentDashboardScreen({super.key});

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
            _buildMonitoredCitizensCard(),
            const SizedBox(height: 24),
            const Text("District Risk Topology",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _buildMapSimulator(),
            const SizedBox(height: 24),
            const Text("Epidemiological Early Warnings",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _buildStatsGrid(),
          ],
        ));
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Federated Population Health",
                  style: TextStyle(
                      color: AppColors.warning,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1)),
              SizedBox(height: 4),
              Text("District Intelligence",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border)),
          child: const Icon(Icons.public, color: AppColors.warning),
        )
      ],
    );
  }

  Widget _buildMonitoredCitizensCard() {
    return GlassCard(
        borderColor: AppColors.warning.withOpacity(0.5),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Monitored Citizens",
                    style: TextStyle(
                        color: AppColors.text2,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1)),
                Icon(Icons.monitor_heart, color: AppColors.success, size: 16),
              ],
            ),
            const SizedBox(height: 12),
            const Text("184,290",
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -2)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: AppColors.bg0, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.hub, color: AppColors.primary, size: 14),
                  const SizedBox(width: 8),
                  Text("Data pooled from 42 local hospitals & clinics",
                      style: TextStyle(
                          color: AppColors.primary.withOpacity(0.8),
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildMapSimulator() {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: 180,
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.1,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6),
                    itemCount: 36,
                    itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white))),
                  ),
                ),
              ),
              Positioned(
                  top: 20,
                  left: 40,
                  child: _buildHeatmapBlob(AppColors.danger, 80)),
              Positioned(
                  bottom: 10,
                  right: 60,
                  child: _buildHeatmapBlob(AppColors.warning, 120)),
              Positioned(
                  top: 80,
                  left: 150,
                  child: _buildHeatmapBlob(AppColors.success, 100)),
              const Positioned(
                bottom: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ZONE 4 - NORTH",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, letterSpacing: 1)),
                    Text("High concentration of sleep apnea detected.",
                        style: TextStyle(fontSize: 10, color: AppColors.text2)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeatmapBlob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.4),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.6), blurRadius: 40, spreadRadius: 20)
          ]),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.0,
      children: [
        _buildGovStatCard(
            "Stroke Risk Cluster",
            "+15%",
            "Detected in Zone 4 affecting elders.",
            AppColors.danger,
            Icons.sick),
        _buildGovStatCard("Apnea Prevalence", "+32%",
            "Rising steadily across district.", AppColors.warning, Icons.air),
        _buildGovStatCard(
            "Elderly Alert SOS",
            "84",
            "Emergency dispatches this week.",
            AppColors.secondary,
            Icons.elderly),
        _buildGovStatCard(
            "Cardiac Rhythm",
            "Stable",
            "Overall district avg resting HR 68.",
            AppColors.success,
            Icons.monitor_heart),
      ],
    );
  }

  Widget _buildGovStatCard(
      String title, String val, String subtitle, Color color, IconData icon) {
    return GlassCard(
        padding: const EdgeInsets.all(16),
        borderColor: color.withOpacity(0.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(val,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: color)),
                const SizedBox(height: 4),
                Text(title,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.text3, height: 1.3)),
              ],
            )
          ],
        ));
  }
}
