import 'package:flutter/material.dart';

class WorkoutModel {
  final String id;
  final String title;
  final String workout;
  final String duration;
  final DateTime dateTime;
  final String svgAsset;
  final Color color;

  WorkoutModel({
    required this.id,
    required this.title,
    required this.workout,
    required this.duration,
    required this.dateTime,
    required this.svgAsset,
    required this.color,
  });

  WorkoutModel copyWith({
    String? id,
    String? title,
    String? workout,
    String? duration,
    DateTime? dateTime,
    String? svgAsset,
    Color? color,
  }) {
    return WorkoutModel(
      id: id ?? this.id,
      title: title ?? this.title,
      workout: workout ?? this.workout,
      duration: duration ?? this.duration,
      dateTime: dateTime ?? this.dateTime,
      svgAsset: svgAsset ?? this.svgAsset,
      color: color ?? this.color,
    );
  }
}
