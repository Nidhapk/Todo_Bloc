import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_bloc_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.light) {
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  Timer? _debounce;

  Future<void> _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeMode> emit) async {
   
    if (_debounce?.isActive ?? false) _debounce?.cancel();

   
    final completer = Completer<void>();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      emit(event.isDark ? ThemeMode.dark : ThemeMode.light);
      completer.complete();
    });
    await completer.future;
  }
}
