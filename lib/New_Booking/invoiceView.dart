// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

// import 'package:pdf/widgets.dart' as pw;

// class MyHomePage extends StatefulWidget {
//   MyHomePage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final pdf = pw.Document();

//   void _generatePDF() {
//     pdf.addPage(pw.Page(
//       build: (pw.Context context) {
//         return pw.Center(
//           child: pw.Text("Hello, World!"),
//         ); // Replace this with your own PDF content
//       },
//     ));

//     savePDF();
//   }

//   Future<void> savePDF() async {
//     final dir = await getExternalStorageDirectory();
//     final file = File("${dir!.path}/example.pdf");
//     await file.writeAsBytes(await pdf.save());

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text("PDF saved to ${file.path}"),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Hello"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Click the button below to generate and download a PDF:',
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _generatePDF,
//         tooltip: 'Generate PDF',
//         child: Icon(Icons.picture_as_pdf),
//       ),
//     );
//   }
// }
