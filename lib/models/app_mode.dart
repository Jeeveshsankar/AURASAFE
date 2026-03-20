import 'package:flutter/material.dart';

enum AppMode { home, hospital, government }

final ValueNotifier<AppMode> appModeNotifier =
    ValueNotifier<AppMode>(AppMode.home);
