import 'package:flutter/material.dart';
import 'package:vehicle_repair_app/screens/login_screen.dart';
import '../constants/app_text_styles.dart';
import '../models/station.dart';
import '../utils/dummy_data.dart';
import '../widgets/station_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void logOut(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = AppTextStyles();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stations',
          style: textStyles.headingText(context),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              tooltip: 'logOut',
              onPressed: () => logOut(context),
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.builder(
          itemCount: stations.length,
          itemBuilder: (context, index) {
            return StationTile(station: stations[index]);
          },
        ),
      ),
    );
  }
}
