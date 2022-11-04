import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';

import 'package:librarymanagment/model/book_model.dart';
import 'package:librarymanagment/model/invoicesystem.dart';
import 'package:pdf/pdf.dart';

Future<Uint8List> genareteInvoice(
    String invoiceno,
    //AsyncSnapshot<DocumentSnapshot<Object?>> snapshot,
    DocumentSnapshot snap,
    String issuename,
    String issuephone,
    String issueemail,
    DateTime issued,
    DateTime due) async {
  final book = Books.fromSnapshot(snap);
  final invoice = Invoice(book, issuename, issueemail, issuephone,
      PdfColors.teal, PdfColors.grey900, issuephone, issued, due);
  return await invoice.buildpdf();
}
