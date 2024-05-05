import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_harbour/constants.dart';

import 'package:green_harbour/screens/widgets/button.dart';
import 'package:green_harbour/screens/widgets/forms_widgets.dart';

import 'package:green_harbour/Helpers/helper_functions.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class NottinghamCityForm extends StatefulWidget {
  const NottinghamCityForm({super.key});

  @override
  State<NottinghamCityForm> createState() => _NottinghamCityFormState();
}

Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load(name);
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

Future<void> createPDF2(
    {required String name,
    required String address,
    required String tenure,
    required String epc,
    required String measure}) async {
  PdfDocument document = PdfDocument();
  final page = document.pages.add();

  page.graphics.drawImage(PdfBitmap(await _readImageData('assets/1.png')),
      const Rect.fromLTRB(0, 0, 0, 0));
  page.graphics.drawString(
    name,
    bounds: const Rect.fromLTRB(110, 180, 0, 0),
    PdfStandardFont(
      PdfFontFamily.helvetica,
      20,
    ),
  );
  page.graphics.drawString(
    address,
    bounds: const Rect.fromLTRB(110, 250, 0, 0),
    PdfStandardFont(
      PdfFontFamily.helvetica,
      20,
    ),
  );
  page.graphics.drawString(
    tenure,
    bounds: const Rect.fromLTRB(110, 380, 0, 0),
    PdfStandardFont(
      PdfFontFamily.helvetica,
      20,
    ),
  );
  page.graphics.drawImage(PdfBitmap(await _readImageData('assets/tick.png')),
      const Rect.fromLTWH(110, 483, 30, 30));
  page.graphics.drawString(
    epc,
    bounds: const Rect.fromLTRB(100, 640, 0, 0),
    PdfStandardFont(
      PdfFontFamily.helvetica,
      20,
    ),
  );
  page.graphics.drawString(
    measure,
    bounds: const Rect.fromLTRB(110, 710, 0, 0),
    PdfStandardFont(
      PdfFontFamily.helvetica,
      20,
    ),
  );
  // Save and dispose the document
  final modifiedBytes = await document.save();
  document.dispose();

  // Save and launch the modified PDF
  saveAndLaunchFile(modifiedBytes, 'Modified_Output.pdf');
}

final TextEditingController _customername = TextEditingController();
final TextEditingController _fulladdress = TextEditingController();
final TextEditingController _tensure = TextEditingController();
final TextEditingController _measures = TextEditingController();
final TextEditingController _epc = TextEditingController();
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
                  controller: _epc),
              height(8),
              appTextfield(
                  title: 'Measures',
                  hintText: "Enter Measures",
                  controller: _measures),
              height(40),
              Center(
                child: MyButton(
                    onTap: () {
                      createPDF2(
                          name: _customername.text,
                          address: _fulladdress.text,
                          tenure: _tensure.text,
                          epc: _epc.text,
                          measure: _measures.text);
                    },
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
