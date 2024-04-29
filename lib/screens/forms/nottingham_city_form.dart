import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_harbour/constants.dart';
import 'package:green_harbour/screens/widgets/button.dart';
import 'package:green_harbour/screens/widgets/forms_widgets.dart';

class NottinghamCityForm extends StatefulWidget {
  const NottinghamCityForm({super.key});

  @override
  State<NottinghamCityForm> createState() => _NottinghamCityFormState();
}

final TextEditingController _customername = TextEditingController();
final TextEditingController _fulladdress = TextEditingController();
final TextEditingController _tensure = TextEditingController();
final TextEditingController _measures = TextEditingController();
bool _checkBoxValue1 = false;
bool _checkBoxValue2 = false;
bool _checkBoxValue3 = false;

class _NottinghamCityFormState extends State<NottinghamCityForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nottingham City Council',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height(8),
              appTextfield(
                  title: 'Name',
                  hintText: "Enter Customer's Full Name",
                  controller: _customername),
              height(8),
              appTextfield(
                  title: 'Address',
                  hintText: "Enter Full Address",
                  controller: _fulladdress),
              height(8),
              appTextfield(
                  title: 'Tenure',
                  hintText: "Enter Tenure",
                  controller: _tensure),
              height(8),
              const Text(
                'Eligibility Route (Please tick)',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: primaryGreen,
                    value: _checkBoxValue1,
                    onChanged: (bool? value) {
                      setState(() {
                        _checkBoxValue1 = value!;
                      });
                    },
                  ),
                  const Text('Route 1'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: primaryGreen,
                    value: _checkBoxValue2,
                    onChanged: (bool? value) {
                      setState(() {
                        _checkBoxValue2 = value!;
                      });
                    },
                  ),
                  const Text('Route 2'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: primaryGreen,
                    value: _checkBoxValue3,
                    onChanged: (bool? value) {
                      setState(() {
                        _checkBoxValue3 = value!;
                      });
                    },
                  ),
                  const Text('Route 3'),
                ],
              ),
              height(8),
              appTextfield(
                  title: 'EPC; D / E / F / G',
                  hintText: "Enter Value",
                  controller: _measures),
              height(8),
              appTextfield(
                  title: 'Measures',
                  hintText: "Enter Measures",
                  controller: _measures),
              height(40),
              Center(
                child: MyButton(
                    buttonText: "Submit",
                    buttonColor: primaryGreen,
                    buttonWidth: 1.sw / 1.5,
                    buttonHeight: 54),
              )
            ],
          ),
        ),
      )),
    );
  }
}
