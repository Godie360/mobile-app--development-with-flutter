import 'dart:io'; // Add this import statement

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReceiptGenerator extends StatefulWidget {
  const ReceiptGenerator({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReceiptGeneratorState createState() => _ReceiptGeneratorState();
}

class _ReceiptGeneratorState extends State<ReceiptGenerator> {
  final pdf = pw.Document();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _generatePdf();
          },
          child: const Text(
            'Generate PDF',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  void _generatePdf() {
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          );
        },
      ),
    );

    // Save the PDF to a file
    savePdf();
  }

  void savePdf() async {
    final file = File('receipt.pdf');
    await file.writeAsBytes(await pdf.save());

    print('PDF saved successfully.');
  }
}
