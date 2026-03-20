import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Configuration",
              style: TextStyle(color: AppColors.text2, fontSize: 14)),
          const Text("Settings",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          GlassCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    leading:
                        const Icon(Icons.elderly, color: AppColors.primary),
                    title: const Text("Elderly Guardian Mode",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text(
                        "SOS on no movement, abnormal breathing, or bed fall",
                        style: TextStyle(color: AppColors.text2, fontSize: 11)),
                    trailing: Switch(
                        value: true,
                        activeColor: AppColors.primary,
                        onChanged: (val) {}),
                  ),
                  const Divider(color: AppColors.border, height: 1),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    leading:
                        const Icon(Icons.sensors, color: AppColors.warning),
                    title: const Text("Smart Posture-Correction",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text(
                        "Micro air pumps automatically lift head to prevent apnea",
                        style: TextStyle(color: AppColors.text2, fontSize: 11)),
                    trailing: Switch(
                        value: true,
                        activeColor: AppColors.warning,
                        onChanged: (val) {}),
                  ),
                  const Divider(color: AppColors.border, height: 1),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    leading:
                        const Icon(Icons.emergency, color: AppColors.danger),
                    title: const Text("Smart Emergency Auto-Response",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text(
                        "Auto-calls family & hospital if seizure or hypoxia occurs",
                        style: TextStyle(color: AppColors.text2, fontSize: 11)),
                    trailing: Switch(
                        value: true,
                        activeColor: AppColors.danger,
                        onChanged: (val) {}),
                  ),
                ],
              )),
          const SizedBox(height: 24),
          const Text("Smart IoT Hardware",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          GlassCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _buildSettingsTile(Icons.memory, "ESP32 Neural Core",
                      "Cloud MQTT Sync Active", AppColors.success),
                  const Divider(color: AppColors.border, height: 1),
                  _buildSettingsTile(Icons.monitor_heart, "MAX30102 Sensor",
                      "SpO2 & Optical HR array online", AppColors.danger),
                  const Divider(color: AppColors.border, height: 1),
                  _buildSettingsTile(
                      Icons.screen_rotation,
                      "MPU6050 Gyro/Accel",
                      "Motion & Sleep Posture AI tracking",
                      AppColors.primary),
                  const Divider(color: AppColors.border, height: 1),
                  _buildSettingsTile(Icons.waves, "Piezo-Electric & FSR Layer",
                      "Respiration rate & pressure mapping", AppColors.warning),
                  const Divider(color: AppColors.border, height: 1),
                  _buildSettingsTile(
                      Icons.water_drop,
                      "Modular Washable Unit",
                      "Electronics fully decoupled and secure",
                      AppColors.text2),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
      IconData icon, String title, String subtitle, Color color) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.bg0, borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: Text(subtitle,
          style: const TextStyle(color: AppColors.text2, fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, color: AppColors.text3),
      onTap: () {},
    );
  }
}
