import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_export.dart';

/// Text style helper for iBorrow application
class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  // Display Styles - Large headers
  TextStyle get display36RegularInter => GoogleFonts.inter(
        fontSize: 36.fSize,
        fontWeight: FontWeight.w400,
        color: appTheme.blackCustom,
      );

  TextStyle get display36Regular => GoogleFonts.inter(
        fontSize: 36.fSize,
        fontWeight: FontWeight.w400,
        color: appTheme.blackCustom,
      );

  // Title Styles
  TextStyle get title20RegularRoboto => GoogleFonts.inter(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
        color: appTheme.blackCustom,
      );

  TextStyle get title18Bold => GoogleFonts.inter(
        fontSize: 18.fSize,
        fontWeight: FontWeight.bold,
        color: appTheme.blackCustom,
      );

  // Body Styles - Standard content
  TextStyle get body16Regular => GoogleFonts.inter(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w400,
        color: appTheme.blackCustom,
      );

  TextStyle get body14 => GoogleFonts.inter(
        fontSize: 14.fSize,
        color: appTheme.blackCustom,
      );

  TextStyle get body13RegularInter => GoogleFonts.inter(
        fontSize: 13.fSize,
        fontWeight: FontWeight.w400,
        color: appTheme.blackCustom,
      );

  TextStyle get body13Regular => GoogleFonts.inter(
        fontSize: 13.fSize,
        fontWeight: FontWeight.w400,
        color: appTheme.blackCustom,
      );

  TextStyle get body13 => GoogleFonts.inter(
        fontSize: 13.fSize,
        color: appTheme.blackCustom,
      );

  // Label Styles - Small text
  TextStyle get label12Regular => GoogleFonts.inter(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
        color: appTheme.blackCustom,
      );

  TextStyle get label10RegularInter => GoogleFonts.inter(
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
        color: appTheme.blackCustom,
      );

  TextStyle get label10BoldInter => GoogleFonts.inter(
        fontSize: 10.fSize,
        fontWeight: FontWeight.w700,
        color: appTheme.colorFFA34A,
      );

  TextStyle get label10Regular => GoogleFonts.inter(
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
        color: appTheme.blackCustom,
      );

  TextStyle get label10Bold => GoogleFonts.inter(
        fontSize: 10.fSize,
        fontWeight: FontWeight.bold,
        color: appTheme.colorFFA34A,
      );

  // Button Styles
  TextStyle get buttonText => GoogleFonts.inter(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
        color: appTheme.whiteCustom,
      );

  // Other Styles
  TextStyle get bodyTextInter => GoogleFonts.inter(
        color: appTheme.blackCustom,
      );

  // Error and Success styles
  TextStyle get errorText => GoogleFonts.inter(
        fontSize: 12.fSize,
        color: Colors.red,
        fontWeight: FontWeight.w400,
      );

  TextStyle get successText => GoogleFonts.inter(
        fontSize: 12.fSize,
        color: Colors.green,
        fontWeight: FontWeight.w400,
      );
}