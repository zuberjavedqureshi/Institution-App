import 'dart:io';

import 'package:auster_education/models/InstituteModel.dart';
import 'package:auster_education/models/StudentsFees.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class PaymentSummaryView extends StatefulWidget {
  final String sName;
  final String? course;
  final String sID;
  final double? totalAmt;
  final String? amtInWords;
  final String? receiverName;
  final String? date;
  final String? paymentMode;
  const PaymentSummaryView({
    Key? key,
    required this.course,
    required this.date,
    required this.sName,
    required this.sID,
    required this.totalAmt,
    required this.amtInWords,
    required this.receiverName,
    required this.paymentMode,
  }) : super(key: key);

  @override
  _PaymentSummaryViewState createState() => _PaymentSummaryViewState();
}

class _PaymentSummaryViewState extends State<PaymentSummaryView> {
  final db = FirebaseFirestore.instance;
  FeesReceipt feesReceipt = FeesReceipt();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Summary"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipPath(
                //clipper: MovieTicketBothSidesClipper(),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        border: Border.all(color: Colors.black, width: 2)),
                    height: 550,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, left: 50),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    "images/logo-02-removebg.png",
                                    width: 80,
                                    height: 80,
                                  ),
                                  Text(
                                    "Auster Education",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                        Center(
                          child: Text(
                            "Fee Receipt",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Name:",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      "${widget.sName}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Standard/Course:",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 100,
                                    child: Text(
                                      "${widget.course}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Paid Amout:",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "${widget.totalAmt}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Amout In Words:",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 150,
                                    child: Text(
                                      "${widget.amtInWords}".toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Date:",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "${widget.date}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Received By:",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "${widget.receiverName} Sir.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () async {
                      setState(() {
                        feesReceipt.sId = widget.sID;
                        feesReceipt.sName = widget.sName;
                        feesReceipt.standard = widget.course;
                        feesReceipt.totalAmtReceived = widget.totalAmt;
                        feesReceipt.amtInWords = widget.amtInWords;
                        feesReceipt.date = widget.date;
                        feesReceipt.whoReceived = "${widget.receiverName} Sir";

                        feesReceipt.paymentMethod = widget.paymentMode;
                      });
                      db
                          .collection("Students Fees Records")
                          .doc(widget.sID)
                          .collection("${widget.sName} Fees Record")
                          .add(feesReceipt.toJson())
                          .whenComplete(() => showSnackbar(context));
                    },
                    icon: Icon(Icons.save_alt_rounded),
                    iconSize: 40,
                    color: Colors.red),
                IconButton(
                    onPressed: () async {
                      FeesReceipt fees = FeesReceipt();

                      final pdfFile = await _generatePdf(fees);

                      _openFile(pdfFile);
                    },
                    icon: Icon(Icons.picture_as_pdf_rounded),
                    iconSize: 40,
                    color: Colors.red)
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<File> _generatePdf(FeesReceipt feesReceipt) async {
    final pdf = pw.Document();

    final logoUrl =
        (await rootBundle.load("images/logo-02.jpg")).buffer.asUint8List();
    final font = await rootBundle.load("assets/open-sans.ttf");
    final ttf = pw.Font.ttf(font);
    // final fontBold = await rootBundle.load("assets/open-sans-bold.ttf");
    //final ttfBold = pw.Font.ttf(fontBold);
    final fontItalic = await rootBundle.load("assets/open-sans-italic.ttf");
    final ttfItalic = pw.Font.ttf(fontItalic);
    // final fontBoldItalic =
    //     await rootBundle.load("assets/open-sans-bold-italic.ttf");
    // final ttfBoldItalic = pw.Font.ttf(fontBoldItalic);
    final pw.ThemeData? theme = pw.ThemeData.withFont(
      base: ttf,
      //bold: ttfBold,
      italic: ttfItalic,
      // boldItalic: ttfBoldItalic,
    );

    Institute institute = Institute(
        name: "Auster Education",
        address: "Near Lucky hotel Bandra West Mumbai",
        imageUrl: logoUrl);

    pdf.addPage(pw.MultiPage(
        theme: theme,
        pageFormat: PdfPageFormat.letter,
        build: (context) => [
              pw.Column(children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Image(pw.MemoryImage(institute.imageUrl, dpi: 100),
                          height: 100, width: 100),
                      pw.Column(children: [
                        pw.Text(institute.name),
                        pw.Text(institute.address),
                        pw.Text("+91 9768891328 / +91 8369180039"),
                        pw.Text("www.austereducation.com"),
                      ]),
                    ]),
                pw.Divider(thickness: 2),
                pw.SizedBox(height: 20),
                pw.Center(child: pw.Text("Fee Receipt")),
                pw.SizedBox(height: 50),
                pw.Row(children: [
                  pw.Align(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Text("Received from Mr./M/s:")),
                  pw.SizedBox(width: 20),
                  pw.Text(
                    "${widget.sName}",
                    style: pw.TextStyle(
                      color: PdfColor.fromHex("#FF0000"),
                      fontSize: 20,
                      fontStyle: pw.FontStyle.italic,
                      decoration: pw.TextDecoration.underline,
                      decorationColor: PdfColor.fromHex("#000000"),
                    ),
                  ),
                ]),
                pw.SizedBox(height: 20),
                pw.Row(children: [
                  pw.Align(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Text("The sum of amount In words:")),
                  pw.SizedBox(width: 20),
                  pw.Text(
                    "${widget.amtInWords}".toUpperCase(),
                    style: pw.TextStyle(
                      color: PdfColor.fromHex("#FF0000"),
                      fontSize: 20,
                      fontStyle: pw.FontStyle.italic,
                      decoration: pw.TextDecoration.underline,
                      decorationColor: PdfColor.fromHex("#000000"),
                    ),
                  ),
                ]),
                pw.SizedBox(height: 20),
                pw.Row(children: [
                  pw.Align(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Text("Cash/Cheque No:")),
                  pw.SizedBox(width: 20),
                  pw.Text(
                    "${widget.paymentMode}",
                    style: pw.TextStyle(
                      color: PdfColor.fromHex("#FF0000"),
                      fontSize: 20,
                      fontStyle: pw.FontStyle.italic,
                      decoration: pw.TextDecoration.underline,
                      decorationColor: PdfColor.fromHex("#000000"),
                    ),
                  ),
                ]),
                pw.SizedBox(height: 20),
                pw.Row(children: [
                  pw.Align(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Text("Date(MM/DDDD/YYYY):")),
                  pw.SizedBox(width: 20),
                  pw.Text(
                    "${widget.date}",
                    style: pw.TextStyle(
                      color: PdfColor.fromHex("#FF0000"),
                      fontSize: 20,
                      fontStyle: pw.FontStyle.italic,
                      decoration: pw.TextDecoration.underline,
                      decorationColor: PdfColor.fromHex("#000000"),
                      letterSpacing: 2,
                    ),
                  ),
                ]),
                pw.SizedBox(height: 20),
                pw.Row(children: [
                  pw.Align(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Text("Standard/Course:")),
                  pw.SizedBox(width: 20),
                  pw.Text(
                    "${widget.course}",
                    style: pw.TextStyle(
                      color: PdfColor.fromHex("#FF0000"),
                      fontSize: 20,
                      fontStyle: pw.FontStyle.italic,
                      decoration: pw.TextDecoration.underline,
                      decorationColor: PdfColor.fromHex("#000000"),
                    ),
                  ),
                ]),
                pw.SizedBox(height: 20),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Container(
                        width: 200,
                        height: 60,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                                color: PdfColor.fromHex("#000000"), width: 3),
                            borderRadius: pw.BorderRadius.circular(25)),
                        child: pw.Row(children: [
                          pw.SizedBox(width: 10),
                          pw.Text(
                            "Rs.",
                            style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 20,
                              fontStyle: pw.FontStyle.italic,
                            ),
                          ),
                          pw.VerticalDivider(thickness: 2),
                          pw.Text(
                            " ${widget.totalAmt}",
                            style: pw.TextStyle(
                              color: PdfColor.fromHex("#FF0000"),
                              fontSize: 20,
                              fontStyle: pw.FontStyle.italic,
                            ),
                          ),
                        ]),
                      ),
                      pw.Row(children: [
                        pw.Align(
                            alignment: pw.Alignment.topLeft,
                            child: pw.Text("Received By:")),
                        pw.SizedBox(width: 20),
                        pw.Text(
                          "${widget.receiverName} Sir.",
                          style: pw.TextStyle(
                            color: PdfColor.fromHex("#FF0000"),
                            fontSize: 20,
                            fontStyle: pw.FontStyle.italic,
                            decoration: pw.TextDecoration.underline,
                            decorationColor: PdfColor.fromHex("#000000"),
                          ),
                        ),
                      ]),
                    ]),
                pw.SizedBox(height: 20),
                pw.Divider(thickness: 2),
                pw.SizedBox(height: 20),
                pw.Center(child: pw.Text("THANK YOU")),
              ])
            ]));

    return _saveDocument(name: "${widget.sName}_fee_receipt.pdf", pdf: pdf);
  }

  static Future<File> _saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$name");

    await file.writeAsBytes(bytes);

    return file;
  }

  Future _openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
    return url;
  }
}

showSnackbar(context) {
  final snackBar = SnackBar(
    content: Text("Fees Record Added to DataBase!"),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
