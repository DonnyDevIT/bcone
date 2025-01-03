import 'package:bcone/app/pages/home/widgets/draggable_table_widget.dart';
import 'package:bcone/models/seat.dart';
import 'package:bcone/utils/ui/grid_painter.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TableMap extends StatefulWidget {
  final List<Seat> seats;
  const TableMap({
    super.key,
    required this.seats,
  });

  @override
  State<TableMap> createState() => _TableMapState();
}

class _TableMapState extends State<TableMap> {
  static const cols = 100;
  static const rows = 100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final areaWidth = constraints.maxWidth;
        final areaHeight = constraints.maxHeight;

        return Stack(
          children: [
            // Griglia
            CustomPaint(
              size: Size(areaWidth, areaHeight),
              painter: GridPainter(
                cols: cols,
                rows: rows,
                lineColor: Colors.grey.withValues(alpha: 0.1),
                strokeWidth: 1.0,
              ),
            ),
            // Tavoli Draggabili
            for (final seat in widget.seats)
              DraggableTableWidget(
                colCount: cols,
                rowCount: rows,
                key: ValueKey(seat.id),
                seat: seat,
                areaWidth: areaWidth,
                areaHeight: areaHeight,
                onPositionChange: _handleSeatPositionChange,
                onSave: _onSaveReservation,
              )
          ],
        );
      },
    );
  }

  Future _handleSeatPositionChange(Seat updatedSeat) async {
    setState(() {
      final index = widget.seats.indexWhere((s) => s.id == updatedSeat.id);
      if (index != -1) {
        widget.seats[index] = updatedSeat;
      }
    });

    // Salvataggio su Supabase
    await Supabase.instance.client.from('seats').update({
      'col_index': updatedSeat.colIndex,
      'row_index': updatedSeat.rowIndex,
      // e se vuoi salvare anche col_span, row_span se l'utente li modifica
      // 'col_span': updatedSeat.colSpan,
      // 'row_span': updatedSeat.rowSpan,
    }).eq('id', updatedSeat.id);
  }

  Future _onSaveReservation(updatedSeat) async {
    // 1) Aggiorno la lista in memoria
    setState(() {
      final index = widget.seats.indexWhere((s) => s.id == updatedSeat.id);
      if (index != -1) {
        widget.seats[index] = updatedSeat;
      }
    });

    // 2) Aggiorno su Supabase
    await Supabase.instance.client.from('seats').update({
      'reservation_name': updatedSeat.reservationName,
      'occupant_count': updatedSeat.occupantCount,
    }).eq('id', updatedSeat.id);
  }
}
