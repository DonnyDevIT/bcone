import 'package:bcone/app/pages/home/widgets/reservation_sheet.dart';
import 'package:bcone/models/seat.dart';
import 'package:flutter/material.dart';

class DraggableTableWidget extends StatefulWidget {
  final Seat seat;
  final int colCount;
  final int rowCount;
  final double areaWidth;
  final double areaHeight;
  final ValueChanged<Seat> onPositionChange;
  final Function(Seat updatedSeat) onSave;

  const DraggableTableWidget({
    super.key,
    required this.seat,
    required this.colCount,
    required this.rowCount,
    required this.areaWidth,
    required this.areaHeight,
    required this.onPositionChange,
    required this.onSave,
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
    final color = _decideColor(widget.seat);

    return Positioned(
      left: pixelLeft,
      top: pixelTop,
      child: GestureDetector(
        onTap: () => _showReservationSheet(context, widget.seat),
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
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          width: tableWidth,
          height: tableHeight,
          padding: const EdgeInsets.all(2),
          child: _buildTableContent(),
        ),
      ),
    );
  }

  Widget _buildTableContent() {
    // Ad esempio mostri:
    // 1) T + table_number
    // 2) occupantCount con “p.”
    // 3) reservationName se esiste
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                "T${widget.seat.tableNumber}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${widget.seat.occupantCount} p.",
              ),
              if (widget.seat.reservationName != null)
                Text(
                  widget.seat.reservationName!,
                ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 5,
          color: widget.seat.chosenColor ?? Colors.black,
        ),
      ],
    );
  }

  Color _decideColor(Seat seat) {
    // 1) Se is_editing = true -> arancione
    if (seat.isEditing == true) {
      return Colors.orange[400]!;
    }
    // 2) Se occupantCount > 0 -> rosso
    else if (seat.occupantCount > 0) {
      return Colors.red[400]!;
    }
    // 3) Altrimenti (occupantCount == 0) -> verde
    else {
      return Colors.green[400]!;
    }
  }

  void _showReservationSheet(BuildContext context, Seat seat) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return ReservationSheet(
          seat: seat,
          onSave: widget.onSave,
        );
      },
    );
  }
}
