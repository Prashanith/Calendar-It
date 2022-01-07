import 'package:calendar_it/constants/theme_file.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class ThemeState extends Equatable {
  final AppTheme theme;

  const ThemeState({
    required this.theme,
  }) : super();

  @override
  List<Object?> get props =>[theme];
}