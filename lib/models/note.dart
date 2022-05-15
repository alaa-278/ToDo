import 'dart:ui';

import 'package:flutter/material.dart';

class Note {
  int? id;
  late String title;
  String? description;
  late Color color;
  late bool isDone;
  String? base64Image = '';
  late DateTime dateTime;
  late DateTime dateTime2;

  Note.emptyNote() {
    title = '';
    description = '';
    dateTime = DateTime.now();
    color = Colors.teal;
    isDone = false;
    base64Image = '';
  }
  Note({
    required this.dateTime,
    required this.title,
    required this.color,
    this.description,
    this.id,
    required this.isDone,
    required this.base64Image,
  });

  factory Note.fromMap(Map<String, dynamic> json) {
// return class from Map
    //retrieve database
    return Note(
        dateTime: DateTime.parse(json['dateTime']),
        id: json['id'],
        title: json['title'],
        description: json['note'],
        color: Color(json['color']),
        isDone: json['isDone'] == 1,
        base64Image: json['base64Image']);
  }

  Map<String, dynamic> toMap() {
// take class and return it like Map
    // Add database
    return {
      'id': this.id,
      'title': this.title,
      'dateTime': this.dateTime.toString(),
      'note': this.description,
      'isDone': this.isDone ? 1 : 0,
      'color': this.color.value,
      'base64Image': this.base64Image,
    };
  }
}
