import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';

class AlertCenterScreen extends StatelessWidget {
  const AlertCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Notifications",
              style: TextStyle(color: AppColors.text2, fontSize: 14)),
          const Text("Alert Center",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          _buildAlertItem(
              "Oxygen Drop Prevented",
              "At 3:15 AM, SpO2 dropped below 92%. AuraSafe triggered gentle vibration, prompting you to change posture. SpO2 recovered instantly.",
              "Today, 3:20 AM",
              Icons.healing,
              AppColors.primary),
          const SizedBox(height: 16),
          _buildAlertItem(
              "System Update",
              "AuraSafe system successfully deployed. Your device now tracks 200 additional biomarkers.",
              "Yesterday, 10:00 AM",
              Icons.update,
              AppColors.text3),
          const SizedBox(height: 16),
          _buildAlertItem(
              "Family Alert Tested",
              "Emergency contact (Mom) successfully pinged during the test sequence.",
              "Mon, 8:45 PM",
              Icons.verified_user,
              AppColors.success),
          const SizedBox(height: 30),
          GlassCard(
              borderColor: AppColors.danger.withOpacity(0.5),
              child: Column(
                children: [
                  const Icon(Icons.emergency,
                      color: AppColors.danger, size: 40),
                  const SizedBox(height: 16),
                  const Text("Emergency Protocol",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.danger)),
                  const SizedBox(height: 8),
                  const Text(
                      "If a fatal event (like Cardiac Arrest or Seizure) is detected, the system will instantly call emergency services and notify your family list.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.text2, fontSize: 13)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.danger.withOpacity(0.2),
                          foregroundColor: AppColors.danger,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                          side: BorderSide(
                              color: AppColors.danger.withOpacity(0.5)),
                          padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: const Text("TEST SOS PIPELINE"),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildAlertItem(
      String title, String desc, String time, IconData icon, Color color) {
    return GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.15), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15))),
                      const SizedBox(width: 8),
                      Text(time,
                          style: const TextStyle(
                              color: AppColors.text3, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(desc,
                      style: const TextStyle(
                          color: AppColors.text2, fontSize: 13, height: 1.4)),
                ],
              ),
            )
          ],
        ));
  }
}
