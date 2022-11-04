// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';

import 'package:librarymanagment/model/book_model.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:pdf/widgets.dart' as pw;

class Invoice {
  final Books book;
  final String customerName;
  final String customerEmail;
  final String invoiceNumber;
  final PdfColor baseColor;
  final PdfColor accentColor;
  final String customerPhone;
  final DateTime issueDate;
  final DateTime duedate;
  static const _darkcolor = PdfColors.blueGrey800;
  static const _lightcolor = PdfColors.white;

  Invoice(
      this.book,
      this.customerName,
      this.customerEmail,
      this.invoiceNumber,
      this.baseColor,
      this.accentColor,
      this.customerPhone,
      this.issueDate,
      this.duedate);

  PdfColor get _accentTextColor =>
      baseColor.luminance < 0.5 ? _lightcolor : _darkcolor;
  late PdfImage _logo;

  Future<Uint8List> buildpdf() async {
    final doc = pw.Document();
    PdfPageFormat pageFormat = PdfPageFormat.a4;
    final font1 = await rootBundle.load("asset/roboto1.ttf");
    final font2 = await rootBundle.load("asset/roboto2.ttf");
    final font3 = await rootBundle.load("asset/roboto3.ttf");
    _logo = PdfImage.file(doc.document,
        bytes: (await rootBundle.load("asset/image/logo.png"))
            .buffer
            .asUint8List());

    doc.addPage(pw.MultiPage(
      pageTheme: _buildtheme(
        pageFormat,
        pw.Font.ttf(font1),
        pw.Font.ttf(font2),
        pw.Font.ttf(font3),
      ),
      header: (context) => _builHeader(context),
      build: (context) => [
        _contentHeader(context),
        _contentTable(context),
        pw.SizedBox(height: 20),
        _contentFooter(context),
        pw.SizedBox(height: 20),
        _termsAndConditions(context),
      ],
    ));
    return doc.save();
  }

  pw.PageTheme _buildtheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font ittalic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(base: base, bold: bold, italic: ittalic),
      buildBackground: (context) => pw.FullPage(
          ignoreMargins: true,
          child: pw.Stack(children: [
            pw.Positioned(
              bottom: 0,
              left: 0,
              child: pw.Container(
                height: 20,
                width: pageFormat.width / 2,
                decoration: pw.BoxDecoration(
                  gradient: pw.LinearGradient(
                    colors: [baseColor, PdfColors.white],
                  ),
                ),
              ),
            ),
            pw.Positioned(
              bottom: 20,
              left: 0,
              child: pw.Container(
                height: 20,
                width: pageFormat.width / 4,
                decoration: pw.BoxDecoration(
                  gradient: pw.LinearGradient(
                    colors: [accentColor, PdfColors.white],
                  ),
                ),
              ),
            ),
            pw.Positioned(
                top: pageFormat.marginTop + 72,
                left: 0,
                right: 0,
                child: pw.Container(
                  height: 3,
                  color: baseColor,
                ))
          ])),
    );
  }

  pw.Widget _builHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    padding: const pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      'ISSUED',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.circular(2)),
                    color: accentColor,
                    padding: const pw.EdgeInsets.only(
                        left: 40, top: 10, bottom: 10, right: 20),
                    alignment: pw.Alignment.centerLeft,
                    height: 50,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: _accentTextColor,
                        fontSize: 12,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          pw.Text('Invoice #'),
                          pw.Text(invoiceNumber),
                          pw.Text('Issue Date:'),
                          pw.Text(_formatDate(issueDate)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topRight,
                    padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                    height: 72,
                    child: pw.PdfLogo(),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      pw.Expanded(
          child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 20),
              child: pw.FittedBox(
                  child: pw.Text("Due :${_formatDate(issueDate)}")))),
      pw.Expanded(
          child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 20),
              child: pw.Text("Invoice to:",
                  style: pw.TextStyle(
                      color: _darkcolor,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12)))),
      pw.Expanded(
          child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 20),
              child: pw.RichText(
                  text: pw.TextSpan(
                      text: "$customerName :\n",
                      style: pw.TextStyle(
                          color: _darkcolor,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12),
                      children: [
                    const pw.TextSpan(
                      text: "\n",
                      style: pw.TextStyle(fontSize: 5),
                    ),
                    pw.TextSpan(
                        text: customerEmail,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.normal,
                          fontSize: 10,
                        )),
                    const pw.TextSpan(
                      text: '\n',
                      style: pw.TextStyle(
                        fontSize: 5,
                      ),
                    ),
                    pw.TextSpan(
                        text: customerPhone,
                        style: pw.TextStyle(
                            fontSize: 12, fontWeight: pw.FontWeight.normal))
                  ]))))
    ]);
  }

  pw.Widget _contentTable(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            "Books Details",
            style: pw.TextStyle(
              fontSize: 30,
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            "Name    : ${book.name}",
            style: pw.TextStyle(
              color: PdfColors.cyan,
              fontWeight: pw.FontWeight.bold,
              fontSize: 15,
            ),
          ),
          pw.Text("Author   : ${book.author}",
              style: pw.TextStyle(
                  color: PdfColors.cyan,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 15)),
          pw.Text("Genre   : ${book.genre}",
              style: pw.TextStyle(
                  color: PdfColors.cyan,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 15)),
          pw.Text("Unique ID   : ${book.uId}",
              style: pw.TextStyle(
                  color: PdfColors.cyan,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 15)),
          pw.Text(
              book.isbn == null
                  ? "ISBN     :Not Available"
                  : "ISBN     : ${book.isbn}",
              style: pw.TextStyle(
                  color: PdfColors.cyan,
                  fontSize: 15,
                  fontWeight: pw.FontWeight.bold))
        ]);
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Thank you for Visiting',
                style: pw.TextStyle(
                    color: _darkcolor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 20),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
                child: pw.Text(
                  "IssuedBy",
                  style: pw.TextStyle(
                    fontSize: 15,
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                FirebaseAuth.instance.currentUser!.email.toString(),
                style: const pw.TextStyle(
                  fontSize: 12,
                  lineSpacing: 5,
                  color: _darkcolor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _termsAndConditions(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  color: accentColor,
                  borderRadius: pw.BorderRadius.circular(12),
                ),
                padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
                child: pw.Text(
                  'Terms & Conditions',
                  style: pw.TextStyle(
                    fontSize: 15,
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                "* Return On Time",
                textAlign: pw.TextAlign.justify,
                style: const pw.TextStyle(
                  fontSize: 12,
                  lineSpacing: 2,
                  color: _darkcolor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.SizedBox(),
        ),
      ],
    );
  }

  // Invoice copyWith({
  //   Books? book,
  //   String? customerName,
  //   String? customerEmail,
  //   String? invoiceNumber,
  //   PdfColor? baseColor,
  //   PdfColor? accentColor,
  //   String? customerPhone,
  //   DateTime? issueDate,
  //   DateTime? duedate,
  // }) {
  //   return Invoice(
  //     book ?? this.book,
  //     customerName ?? this.customerName,
  //     customerEmail ?? this.customerEmail,
  //     invoiceNumber ?? this.invoiceNumber,
  //     baseColor ?? this.baseColor,
  //     accentColor ?? this.accentColor,
  //     customerPhone ?? this.customerPhone,
  //     issueDate ?? this.issueDate,
  //     duedate ?? this.duedate,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'book': book.toMap(),
  //     'customerName': customerName,
  //     'customerEmail': customerEmail,
  //     'invoiceNumber': invoiceNumber,
  //     'baseColor': baseColor.toMap(),
  //     'accentColor': accentColor.toMap(),
  //     'customerPhone': customerPhone,
  //     'issueDate': issueDate.millisecondsSinceEpoch,
  //     'duedate': duedate.millisecondsSinceEpoch,
  //   };
  // }

  // factory Invoice.fromMap(Map<String, dynamic> map) {
  //   return Invoice(
  //     Books.fromMap(map['book'] as Map<String,dynamic>),
  //     map['customerName'] as String,
  //     map['customerEmail'] as String,
  //     map['invoiceNumber'] as String,
  //     PdfColor.fromMap(map['baseColor'] as Map<String,dynamic>),
  //     PdfColor.fromMap(map['accentColor'] as Map<String,dynamic>),
  //     map['customerPhone'] as String,
  //     DateTime.fromMillisecondsSinceEpoch(map['issueDate'] as int),
  //     DateTime.fromMillisecondsSinceEpoch(map['duedate'] as int),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Invoice.fromJson(String source) => Invoice.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'Invoice(book: $book, customerName: $customerName, customerEmail: $customerEmail, invoiceNumber: $invoiceNumber, baseColor: $baseColor, accentColor: $accentColor, customerPhone: $customerPhone, issueDate: $issueDate, duedate: $duedate)';
  // }

  // @override
  // bool operator ==(covariant Invoice other) {
  //   if (identical(this, other)) return true;

  //   return other.book == book &&
  //       other.customerName == customerName &&
  //       other.customerEmail == customerEmail &&
  //       other.invoiceNumber == invoiceNumber &&
  //       other.baseColor == baseColor &&
  //       other.accentColor == accentColor &&
  //       other.customerPhone == customerPhone &&
  //       other.issueDate == issueDate &&
  //       other.duedate == duedate;
  // }

//   @override
//   int get hashCode {
//     return book.hashCode ^
//       customerName.hashCode ^
//       customerEmail.hashCode ^
//       invoiceNumber.hashCode ^
//       baseColor.hashCode ^
//       accentColor.hashCode ^
//       customerPhone.hashCode ^
//       issueDate.hashCode ^
//       duedate.hashCode;
//   }
// }
}

String _formatDate(DateTime issueDate) {
  final format = DateFormat.yMMMd('en_US').toString();
  return format;
}
