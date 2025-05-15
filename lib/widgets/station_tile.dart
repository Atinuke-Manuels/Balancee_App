import 'package:flutter/material.dart';
import '../models/station.dart';
import '../screens/booking_form_screen.dart';

class StationTile extends StatelessWidget {
  final Station station;

  const StationTile({super.key, required this.station});

  Widget _buildRatingStars(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.amber, size: 16);
        } else if (index == fullStars && hasHalfStar) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 16);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 16);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blue.shade100,
          child: Icon(Icons.ev_station, size: 30, color: Colors.blue.shade700),
        ),
        title: Text(
          station.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(station.type, style: TextStyle(color: Colors.grey.shade700)),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text('${station.distance}',
                          style: TextStyle(color: Colors.grey.shade700)),
                    ],
                  ),

                ],
              ),
              const SizedBox(height: 10),
              _buildRatingStars(station.rating),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookingFormScreen(stationName: station.name),
            ),
          );
        },
      ),
    );
  }
}
