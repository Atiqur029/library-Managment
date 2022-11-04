import 'package:flutter/material.dart';

display1(
    BuildContext context, ontap, String title, Color c1, Color c2, Color texc) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: ontap,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: Colors.black,
          elevation: 8,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [c1, c2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(15)),
            width: MediaQuery.of(context).size.width - 40,
            height: 105,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 27,
                            color: texc,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ));
}
