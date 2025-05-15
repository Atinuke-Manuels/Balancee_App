import 'package:flutter/material.dart';
import 'package:vehicle_repair_app/constants/app_text_styles.dart';
import '../constants/app_colors.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_button.dart';

class BookingFormScreen extends StatefulWidget {
  final String stationName;

  const BookingFormScreen({super.key, required this.stationName});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _vehicleType = 'Car';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _descController = TextEditingController();
  final AppColors appColors = AppColors();

  void _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        setState(() {
          _selectedDate = date;
          _selectedTime = time;
        });
      }
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedTime != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) =>  Center(child: CircularProgressIndicator(color: appColors.primaryColor,)),
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context); // Remove spinner
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment booked!')),
        );
        Navigator.pop(context); // Back to Home Screen
      });
    } else {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please pick date and time')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = AppTextStyles();
    final dateText = _selectedDate != null && _selectedTime != null
        ? '${_selectedDate!.toLocal().toString().split(' ')[0]} at ${_selectedTime!.format(context)}'
        : 'Pick Date & Time';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book at ${widget.stationName}',
          style: textStyles.headingText(context),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DropdownButtonFormField<String>(
                          value: _vehicleType,
                          decoration:
                              const InputDecoration(labelText: 'Vehicle Type'),
                          items: ['Car', 'Bike', 'Truck']
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) =>
                              setState(() => _vehicleType = val!),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: _descController,
                          label: 'Description',
                          validator: (val) =>
                              val!.isEmpty ? 'Enter a description' : null,
                        ),
                        const SizedBox(height: 16),
                        AppButton(
                          onPressed: _pickDateTime,
                          label: dateText,
                          labelColor: appColors.primaryColor,
                          btnColor: appColors.greyColor,
                        ),
                        const SizedBox(height: 24),
                        AppButton(
                          onPressed: _submit,
                          label: 'Book Appointment',
                          btnColor: appColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
