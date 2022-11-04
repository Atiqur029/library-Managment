// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Books {
  String? name;
  String? author;
  String? uId;
  String? publisher;
  String? genre;
  String? isbn;
  String? status;
  Books({
    this.name,
    this.author,
    this.uId,
    this.publisher,
    this.genre,
    this.isbn,
    this.status,
  });

  // Books.fromSnapshot(DocumentSnapshot snapshot) {
  //   name = snapshot["name"];
  //   author = snapshot["author"];
  //   uId = snapshot.id;
  //   publisher = snapshot["publisher"];
  //   genre = snapshot["genre"];
  //   isbn = snapshot["isbn"];
  //   status = snapshot["status"];

  // }

  Books.fromSnapshot(DocumentSnapshot snapshot)
      // : name = snapshot.data["name"].toString(),
      : name = (snapshot.data() as dynamic)['name'],
        author = (snapshot.data() as dynamic)!["author"],
        //author = snapshot.data()!["author"].toString(),
        uId = snapshot.id,
        publisher = (snapshot.data() as dynamic)!["publisher"],
        genre = (snapshot.data() as dynamic)!["genre"],
        isbn = (snapshot.data() as dynamic)!["isbn"],
        status = (snapshot.data() as dynamic)!["status"];

  // publisher = snapshot.data()!["publisher"].toString(),
  // genre = snapshot.data()!["genre"].toString(),
  // isbn = snapshot.data()!["isbn"].toString(),
  // status = snapshot.data()!["status"].toString();

  tojson() => {
        "name": name,
        "author": author,
        "uId": uId,
        "publisher": publisher,
        "genre": genre,
        "isbn": isbn,
        "status": status,
      };
}

String result = "";
String reresult = "";
