import 'package:bcone/models/seat.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReservationSheet extends StatefulWidget {
  final Seat seat;
  final Function(Seat updatedSeat) onSave;

  const ReservationSheet({
    super.key,
    required this.seat,
    required this.onSave,
  });

  @override
  State<ReservationSheet> createState() => _ReservationSheetState();
}

class _ReservationSheetState extends State<ReservationSheet> {
  late TextEditingController _nameController;
  late TextEditingController _occupantController;

  @override
  void initState() {
    super.initState();
    _setEdit(true);
    _nameController =
        TextEditingController(text: widget.seat.reservationName ?? "");
    _occupantController =
        TextEditingController(text: widget.seat.occupantCount.toString());
  }

  _setEdit(bool edit) async {
    await Supabase.instance.client
        .from('seats')
        .update({"is_editing": edit}).eq('id', widget.seat.id);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _occupantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            // Per non sovrapporre la tastiera
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Prenotazione Tavolo ${widget.seat.tableNumber}",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Nome Prenotazione",
                    hintText: "Es. Mario Rossi",
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _occupantController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Numero di persone",
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await _setEdit(false);

                        Navigator.pop(context);
                      },
                      child: const Text("Annulla"),
                    ),
                    ElevatedButton(
                      onPressed: _save,
                      child: const Text("Salva"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _save() async {
    final name = _nameController.text.trim();
    final occupantCount = int.tryParse(_occupantController.text.trim()) ?? 0;

    final updatedSeat = widget.seat.copyWith(
      reservationName: name.isEmpty ? null : name,
      occupantCount: occupantCount,
    );

    await widget.onSave(updatedSeat);
    await _setEdit(false);
    Navigator.pop(context);
  }
}
