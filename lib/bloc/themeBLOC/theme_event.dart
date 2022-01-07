import 'package:calendar_it/constants/theme_file.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
abstract class ThemeEvent extends Equatable {
  // Passing class fields in a list to the Equatable super class
  const ThemeEvent([List props = const []]) : super();
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;
  ThemeChanged({
    required this.theme,
  }) : super([theme]);

  @override
  List<Object?> get props => [theme];
}