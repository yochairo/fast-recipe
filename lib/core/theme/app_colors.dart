import 'package:flutter/material.dart';

abstract final class AppColors {
  // Light Palette
  static const Color lightBackground = Color(0xFFF7F8F2);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightPrimary = Color(0xFF2F8F62);
  static const Color lightPrimaryDark = Color(0xFF24704C);
  static const Color lightAccent = Color(0xFFF28C5B);
  static const Color lightText = Color(0xFF17211C);
  static const Color lightSecondary = Color(0xFF66736C);
  static const Color lightBorder = Color(0xFFD9E1DB);
  static const Color lightSuccess = Color(0xFF348A57);
  static const Color lightError = Color(0xFFD9534F);

  // Dark Palette
  static const Color darkBackground = Color(0xFF101815);
  static const Color darkSurface = Color(0xFF19221E);
  static const Color darkPrimary = Color(0xFF63C994);
  static const Color darkPrimaryDark = Color(0xFF49A978);
  static const Color darkAccent = Color(0xFFFF9E76);
  static const Color darkText = Color(0xFFF1F5F2);
  static const Color darkSecondary = Color(0xFFA7B5AD);
  static const Color darkBorder = Color(0xFF2E3A34);
  static const Color darkSuccess = Color(0xFF73D69A);
  static const Color darkError = Color(0xFFFF7770);
}

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.primary,
    required this.primaryDark,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.surface,
    required this.text,
    required this.border,
    required this.success,
    required this.error,
  });

  final Color primary;
  final Color primaryDark;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color text;
  final Color border;
  final Color success;
  final Color error;

  static const AppColorsExtension light = AppColorsExtension(
    primary: AppColors.lightPrimary,
    primaryDark: AppColors.lightPrimaryDark,
    secondary: AppColors.lightSecondary,
    accent: AppColors.lightAccent,
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    text: AppColors.lightText,
    border: AppColors.lightBorder,
    success: AppColors.lightSuccess,
    error: AppColors.lightError,
  );

  static const AppColorsExtension dark = AppColorsExtension(
    primary: AppColors.darkPrimary,
    primaryDark: AppColors.darkPrimaryDark,
    secondary: AppColors.darkSecondary,
    accent: AppColors.darkAccent,
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    text: AppColors.darkText,
    border: AppColors.darkBorder,
    success: AppColors.darkSuccess,
    error: AppColors.darkError,
  );

  @override
  AppColorsExtension copyWith({
    Color? primary,
    Color? primaryDark,
    Color? secondary,
    Color? accent,
    Color? background,
    Color? surface,
    Color? text,
    Color? border,
    Color? success,
    Color? error,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      text: text ?? this.text,
      border: border ?? this.border,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t) ?? primaryDark,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      accent: Color.lerp(accent, other.accent, t) ?? accent,
      background: Color.lerp(background, other.background, t) ?? background,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      text: Color.lerp(text, other.text, t) ?? text,
      border: Color.lerp(border, other.border, t) ?? border,
      success: Color.lerp(success, other.success, t) ?? success,
      error: Color.lerp(error, other.error, t) ?? error,
    );
  }
}

extension AppThemeContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>() ?? AppColorsExtension.light;
}

