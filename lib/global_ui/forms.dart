
import 'package:calendar_it/constants/theme_file.dart';
import 'package:flutter/material.dart';

InputDecoration formFieldStyle(AppTheme theme){
  return InputDecoration(
      filled: true,
      fillColor:theme==AppTheme.lightMode?
      const Color(0xffffffff):
      const Color(0xff3d3d3d),
      hintStyle:formsTextStyle(theme) ,
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      focusColor: Colors.grey,
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
   );
}

TextStyle formsTextStyle(AppTheme theme){
    return TextStyle(
        color: theme==AppTheme.lightMode?LightTheme.primary:DarkTheme.quaternary,
        fontSize:15
    );
}