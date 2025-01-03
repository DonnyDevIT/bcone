import 'package:flutter/material.dart';

class Seat {
  final int id;
  final int tableNumber;
  final int occupantCount;
  final bool isMerged;
  final bool isEditing;
  final int? mergedInto;
  final int rowIndex;
  final int colIndex;
  final int rowSpan;
  final int colSpan;
  final String? reservationName;
  final Color? chosenColor;

  Seat({
    required this.id,
    required this.tableNumber,
    required this.occupantCount,
    required this.isMerged,
    this.isEditing = false,
    required this.mergedInto,
    required this.rowIndex,
    required this.colIndex,
    this.rowSpan = 1,
    this.colSpan = 1,
    this.reservationName,
    this.chosenColor,
  });

  Seat copyWith({
    int? id,
    int? tableNumber,
    int? occupantCount,
    bool? isMerged,
    bool? isEditing,
    int? mergedInto,
    int? rowIndex,
    int? colIndex,
    int? rowSpan,
    int? colSpan,
    String? reservationName,
    Color? chosenColor,
  }) {
    return Seat(
      id: id ?? this.id,
      tableNumber: tableNumber ?? this.tableNumber,
      occupantCount: occupantCount ?? this.occupantCount,
      isMerged: isMerged ?? this.isMerged,
      isEditing: isEditing ?? this.isEditing,
      mergedInto: mergedInto ?? this.mergedInto,
      rowIndex: rowIndex ?? this.rowIndex,
      colIndex: colIndex ?? this.colIndex,
      rowSpan: rowSpan ?? this.rowSpan,
      colSpan: colSpan ?? this.colSpan,
      reservationName: reservationName ?? this.reservationName,
      chosenColor: chosenColor ?? this.chosenColor,
    );
  }

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'] as int,
      tableNumber: json['table_number'] as int,
      occupantCount: json['occupant_count'] as int,
      isMerged: json['is_merged'] as bool,
      isEditing: json['is_editing'] as bool,
      mergedInto: json['merged_into'] as int?,
      rowIndex: json['row_index'] as int,
      colIndex: json['col_index'] as int,
      rowSpan: json['row_span'] as int,
      colSpan: json['col_span'] as int,
      reservationName: json['reservation_name'] as String?,
      chosenColor: json['chosen_color'] != null
          ? Color(int.parse(json['chosen_color'], radix: 16))
          : null,
    );
  }
}
