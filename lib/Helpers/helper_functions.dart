import 'package:intl/intl.dart';
import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

String dateTypeConverter({required String date}) {
  DateTime originalDate = DateTime.parse(date);
  String formattedDate = DateFormat('d MMM y').format(originalDate);
  return formattedDate;
}

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> saveAndLaunchFile2(List<int> bytes, String fileName) async {
  try {
    final path = (await getExternalStorageDirectory())!.path;

    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  } catch (e) {
    print('Error: $e');
  }
}
