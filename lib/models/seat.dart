class Seat {
  final int id;
  final int tableNumber;
  final int capacity;
  final int occupantCount;
  final bool isMerged;
  final int? mergedInto;
  final int rowIndex;
  final int colIndex;
  final int rowSpan;
  final int colSpan;

  Seat({
    required this.id,
    required this.tableNumber,
    required this.capacity,
    required this.occupantCount,
    required this.isMerged,
    required this.mergedInto,
    required this.rowIndex,
    required this.colIndex,
    this.rowSpan = 1,
    this.colSpan = 1,
  });

  Seat copyWith({
    int? id,
    int? tableNumber,
    int? capacity,
    int? occupantCount,
    bool? isMerged,
    int? mergedInto,
    int? rowIndex,
    int? colIndex,
    int? rowSpan,
    int? colSpan,
  }) {
    return Seat(
      id: id ?? this.id,
      tableNumber: tableNumber ?? this.tableNumber,
      capacity: capacity ?? this.capacity,
      occupantCount: occupantCount ?? this.occupantCount,
      isMerged: isMerged ?? this.isMerged,
      mergedInto: mergedInto ?? this.mergedInto,
      rowIndex: rowIndex ?? this.rowIndex,
      colIndex: colIndex ?? this.colIndex,
      rowSpan: rowSpan ?? this.rowSpan,
      colSpan: colSpan ?? this.colSpan,
    );
  }

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'] as int,
      tableNumber: json['table_number'] as int,
      capacity: json['capacity'] as int,
      occupantCount: json['occupant_count'] as int,
      isMerged: json['is_merged'] as bool,
      mergedInto: json['merged_into'] as int?,
      rowIndex: json['row_index'] as int,
      colIndex: json['col_index'] as int,
      rowSpan: json['row_span'] as int,
      colSpan: json['col_span'] as int,
    );
  }
}
