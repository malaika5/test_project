import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget bold10Text(
  String text, {
  Color? color,
  double? fontSize,
  FontWeight fontWeight = FontWeight.w400,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: GoogleFonts.mulish(
      fontSize: fontSize ?? 10.sp,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget bold12Text(
  String text, {
  Color? color,
  double? fontSize,
  FontWeight fontWeight = FontWeight.w700,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: GoogleFonts.mulish(
      fontSize: fontSize ?? 12.sp,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget bold14Text(
  String text, {
  Color? color,
  double? fontSize,
  FontWeight fontWeight = FontWeight.w700,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: GoogleFonts.mulish(
      fontSize: fontSize ?? 14.sp,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget bold16Text(
  String text, {
  Color? color,
  double? fontSize,
  FontWeight fontWeight = FontWeight.w700,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: GoogleFonts.mulish(
      fontSize: fontSize ?? 16.sp,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget bold18Text(
  String text, {
  Color? color,
  double? fontSize,
  FontWeight fontWeight = FontWeight.w700,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: GoogleFonts.mulish(
      fontSize: fontSize ?? 18.sp,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget bold24Text(
  String text, {
  Color? color,
  double? fontSize,
  FontWeight fontWeight = FontWeight.w700,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: GoogleFonts.mulish(
      fontSize: fontSize ?? 24.sp,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget bold40Text(
  String text, {
  Color? color,
  double? fontSize,
  FontWeight fontWeight = FontWeight.w700,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: GoogleFonts.mulish(
      fontSize: fontSize ?? 40.sp,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}
