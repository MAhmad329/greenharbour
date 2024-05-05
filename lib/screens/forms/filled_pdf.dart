import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:green_harbour/Helpers/helper_functions.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFForm extends StatelessWidget {
  PDFForm(
      {super.key,
      required this.name,
      required this.address,
      required this.tenure,
      required this.route,
      required this.epc,
      required this.measure});

  final String name;
  final String address;
  final String tenure;
  final String route;
  final String epc;
  final String measure;

  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('assets/1.png');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> _createPDF2() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawImage(PdfBitmap(await _readImageData('name')),
        const Rect.fromLTRB(0, 0, 0, 0));
    page.graphics.drawString(
        name,
        bounds: const Rect.fromLTRB(100, 180, 0, 0),
        PdfStandardFont(
          PdfFontFamily.helvetica,
          20,
        ),
        brush: PdfSolidBrush(PdfColor.fromCMYK(1, 1, 1, 1)));
    // Save and dispose the document
    final modifiedBytes = await document.save();
    document.dispose();

    // Save and launch the modified PDF
    saveAndLaunchFile(modifiedBytes, 'Modified_Output.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Center(
        child: ElevatedButton(onPressed: _createPDF2, child: Text('Click')),
      ),
    );
  }
}
