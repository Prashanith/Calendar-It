import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:calendar_it/bloc/themeBLOC/theme_event.dart';
import 'package:calendar_it/bloc/themeBLOC/theme_state.dart';
import 'package:calendar_it/constants/theme_file.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(initialState) : super(const ThemeState(theme:AppTheme.lightMode));

  @override
  Stream<ThemeState> mapEventToState(
      ThemeEvent event,
      ) async* {
    if (event is ThemeChanged) {
      if(event.theme==AppTheme.darkMode){
        yield const ThemeState(theme:AppTheme.darkMode);
      }
      else{
        yield const ThemeState(theme: AppTheme.lightMode);
      }
    }
  }
}