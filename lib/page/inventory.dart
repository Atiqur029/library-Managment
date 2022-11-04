import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Inventory Page"),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("books").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    DocumentSnapshot book = snapshot.data!.docs[index];
                    return Card(
                      elevation: 10,
                      shadowColor: Colors.blueGrey,
                      color: Colors.greenAccent,
                      surfaceTintColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: Colors.greenAccent)),
                      child: ListTile(
                        title: Text(
                          book["name"],
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(book["author"],
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Text(book["genre"],
                                style: const TextStyle(
                                    color: Colors.brown,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                            Text(book["isbn"],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 119, 77, 91),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        trailing: Text(book["publisher"],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)),
                      ),
                    );
                  })),
            );
          },
        ),
      ),
    );
  }
}
