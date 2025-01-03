import 'package:auto_route/auto_route.dart';
import 'package:bcone/app/pages/home/widgets/table_map_widget.dart';
import 'package:bcone/models/seat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;
  List<Seat> seats = [];

  @override
  void initState() {
    super.initState();
    // 1) Prima carichiamo la lista iniziale
    _fetchSeats();

    // 2) Attiviamo la subscription in real-time
    supabase.from('seats').stream(primaryKey: ['id']).listen(
      (List<Map<String, dynamic>> data) {
        if (kDebugMode) print("-- Seats changed in Realtime!\n$data");
        setState(() {
          seats = data.map((seat) => Seat.fromJson(seat)).toList();
        });
      },
    );
  }

  Future<void> _fetchSeats() async {
    final response = await supabase.from('seats').select('*').order('id');

    final data = response as List<dynamic>;
    if (kDebugMode) {
      print("-- Seats fetched\n$data");
    }
    setState(() {
      seats = data.map((seat) => Seat.fromJson(seat)).toList();
    });
  }

  // Esempio di update occupant_count
  Future<void> updateSeatOccupantCount(Seat seat, int occupantCount) async {
    final updates = {
      'occupant_count': occupantCount,
      'is_merged': false,
      'merged_into': null,
    };
    await supabase.from('seats').update(updates).eq('id', seat.id);
  }

  // Esempio di merge
  Future<void> mergeSeats(Seat mainSeat, Seat seatToMerge) async {
    final newOccupantCount = mainSeat.occupantCount + seatToMerge.occupantCount;

    // Aggiorna tavolo principale
    await supabase
        .from('seats')
        .update({'occupant_count': newOccupantCount}).eq('id', mainSeat.id);

    // Aggiorna il tavolo "merged"
    await supabase.from('seats').update({
      'is_merged': true,
      'merged_into': mainSeat.id,
      'occupant_count': 0,
    }).eq('id', seatToMerge.id);
  }

  @override
  Widget build(BuildContext context) {
    return _buildMaterialScaffold();
  }

  Widget _buildMaterialScaffold() {
    if (kDebugMode) {
      print("-- Current seats list: $seats");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: (seats.isEmpty)
          ? const Center(
              child: Text('No Seats'),
            )
          : Center(
              child: TableMap(seats: seats),
            ),
    );
  }
}
