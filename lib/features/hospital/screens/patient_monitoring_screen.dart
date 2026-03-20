import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';
import '../widgets/waveform_painter.dart';

class PatientMonitoringScreen extends StatelessWidget {
  const PatientMonitoringScreen({super.key});

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
          _buildICUPatientCard("Alice Smith", "ICU Bed 04", 142, 88, 28,
              "Tachycardia / Hypoxia", AppColors.danger,
              isAlert: true),
          const SizedBox(height: 16),
          _buildICUPatientCard("John Doe", "Ward A - Bed 12", 68, 98, 14,
              "Stable Sleep", AppColors.success),
          const SizedBox(height: 16),
          _buildICUPatientCard("Robert Fox", "Ward A - Bed 15", 58, 96, 12,
              "Deep REM Phase", AppColors.primary),
          const SizedBox(height: 16),
          _buildICUPatientCard("Emma Stone", "Ward B - Bed 02", 72, 95, 16,
              "Awake / Restless", AppColors.warning),
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
              Text("ICU Command Center",
                  style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2)),
              SizedBox(height: 4),
              Text("Live Ward Telemetry",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
              color: AppColors.danger.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.danger.withOpacity(0.5))),
          child: const Row(
            children: [
              Icon(Icons.warning_amber_rounded,
                  color: AppColors.danger, size: 20),
              SizedBox(width: 8),
              Text("1 CRITICAL",
                  style: TextStyle(
                      color: AppColors.danger,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      letterSpacing: 1)),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildICUPatientCard(String name, String location, int hr, int spo2,
      int br, String status, Color accentColor,
      {bool isAlert = false}) {
    return GlassCard(
        borderColor: isAlert ? AppColors.danger : AppColors.border,
        opacity: isAlert ? 0.8 : 0.4,
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.15),
                  border: Border(
                      bottom: BorderSide(color: accentColor.withOpacity(0.3)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: accentColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: accentColor, blurRadius: 8)
                              ]),
                        ),
                        const SizedBox(width: 12),
                        Text(location,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                letterSpacing: 1,
                                color: Colors.white70)),
                      ],
                    ),
                  ),
                  Text(status.toUpperCase(),
                      style: TextStyle(
                          color: accentColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: accentColor.withOpacity(0.5),
                                      width: 1,
                                      style: BorderStyle.solid))),
                          child: CustomPaint(
                              painter: WaveformPainter(
                                  color: accentColor, isAlert: isAlert)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildICUVital("HR", "$hr", AppColors.danger),
                        _buildICUVital("SpO2", "$spo2%", AppColors.primary),
                        _buildICUVital("RR", "$br", AppColors.success),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildICUVital(String label, String val, Color c) {
    return Column(
      children: [
        Text(val,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: c,
                fontFamily: 'monospace')),
        Text(label,
            style: const TextStyle(
                fontSize: 10,
                color: AppColors.text2,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
