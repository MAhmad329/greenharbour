import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_harbour/constants.dart';
import 'package:green_harbour/screens/widgets/forms_widgets.dart';

class GMCAForm extends StatefulWidget {
  const GMCAForm({super.key});

  @override
  State<GMCAForm> createState() => _GMCAFormState();
}

class _GMCAFormState extends State<GMCAForm> {
  final TextEditingController _householderName = TextEditingController();
  final TextEditingController _householderPhone = TextEditingController();
  final TextEditingController _householderEmail = TextEditingController();
  final TextEditingController _addressLine = TextEditingController();
  final TextEditingController _addressLine2 = TextEditingController();
  final TextEditingController _addressLine3 = TextEditingController();
  final TextEditingController _postCode = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evidence Form'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bulletText(
                    "Suppliers will be expected to be able to provide sufficient evidence for all ECO4 Flex measures to ensure that they meet the eligibility and compliance requirements of the scheme."),
                height(8),
                bulletText(
                    "Non-exhausCve list of evidence examples for Routes 1-4, please Cck which evidence you have provided."),
                height(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Date',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    height(4),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        height: 62,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Colors.black.withOpacity(0.8), width: 1),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              'Select Date',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                height(8),
                appTextfield(
                    title: 'Householder Name',
                    hintText: 'Enter Householder Name',
                    controller: _householderName),
                height(8),
                appTextfield(
                    title: 'Householder Phone',
                    hintText: 'Enter Householder Phone',
                    controller: _householderPhone),
                height(8),
                appTextfield(
                    title: 'Householder Email',
                    hintText: 'Enter Householder Email',
                    controller: _householderEmail),
                height(8),
                appTextfield(
                    title: 'Address Line',
                    hintText: 'Enter Address Line',
                    controller: _addressLine),
                height(8),
                appTextfield(
                    title: 'Address Line 2',
                    hintText: 'Enter Address Line 2',
                    controller: _addressLine2),
                height(8),
                appTextfield(
                    title: 'Address Line 3',
                    hintText: 'Enter Address Line 3',
                    controller: _addressLine3),
                height(8),
                appTextfield(
                    title: 'Postcode',
                    hintText: 'Enter Postcode',
                    controller: _postCode),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
