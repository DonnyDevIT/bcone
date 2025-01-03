import 'package:bcone/models/seat.dart';
import 'package:flutter/material.dart';

class DraggableTableWidget extends StatefulWidget {
  final Seat seat;
  final int colCount;
  final int rowCount;
  final double areaWidth;
  final double areaHeight;
  final ValueChanged<Seat> onPositionChange;

  const DraggableTableWidget({
    super.key,
    required this.seat,
    required this.colCount,
    required this.rowCount,
    required this.areaWidth,
    required this.areaHeight,
    required this.onPositionChange,
  });

  @override
  State<DraggableTableWidget> createState() => _DraggableTableWidgetState();
}

class _DraggableTableWidgetState extends State<DraggableTableWidget> {
  late double pixelLeft;
  late double pixelTop;

  double get cellWidth => widget.areaWidth / widget.colCount;
  double get cellHeight => widget.areaHeight / widget.rowCount;

  // Larghezza e altezza effettive del tavolo in pixel
  double get tableWidth => cellWidth * widget.seat.colSpan;
  double get tableHeight => cellHeight * widget.seat.rowSpan;

  @override
  void initState() {
    super.initState();
    // Posizione in pixel = colIndex * cellWidth, rowIndex * cellHeight
    pixelLeft = widget.seat.colIndex * cellWidth;
    pixelTop = widget.seat.rowIndex * cellHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: pixelLeft,
      top: pixelTop,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            pixelLeft += details.delta.dx;
            pixelTop += details.delta.dy;

            // Limiti orizzontali
            final maxLeft = widget.areaWidth - tableWidth; // Non oltre
            pixelLeft = pixelLeft.clamp(0.0, maxLeft);

            // Limiti verticali
            final maxTop = widget.areaHeight - tableHeight;
            pixelTop = pixelTop.clamp(0.0, maxTop);
          });
        },
        onPanEnd: (details) {
          // Calcoliamo la colonna e la riga in base ai pixel
          final newColIndex = (pixelLeft / cellWidth).round();
          final newRowIndex = (pixelTop / cellHeight).round();

          // Evitiamo di superare colCount - colSpan
          final clampedColIndex =
              newColIndex.clamp(0, widget.colCount - widget.seat.colSpan);
          final clampedRowIndex =
              newRowIndex.clamp(0, widget.rowCount - widget.seat.rowSpan);

          // Ora allineiamo i pixel
          setState(() {
            pixelLeft = clampedColIndex * cellWidth;
            pixelTop = clampedRowIndex * cellHeight;
          });

          // Creiamo un nuovo Seat con colIndex/rowIndex aggiornati
          final updatedSeat = widget.seat.copyWith(
            colIndex: clampedColIndex,
            rowIndex: clampedRowIndex,
          );

          widget.onPositionChange(updatedSeat);
        },
        child: Container(
          width: tableWidth,
          height: tableHeight,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text("T${widget.seat.id}"),
        ),
      ),
    );
  }
}
