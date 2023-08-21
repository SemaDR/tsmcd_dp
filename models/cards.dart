import 'package:flutter/material.dart';

_buildCard(String restuarantName, String type, String date, String rating,
    String imgPath) {
  return Container(
    padding: EdgeInsets.all(8.0),
    height: 150.0,
    width: 150.0,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 3.0,
          spreadRadius: 3.0,
          color: Colors.grey.withOpacity(0.2),
        ),
      ],
    ),
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              height: 100.0,
              width: 140.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                top: 60.0,
                left: 100.0,
                child: Container(
                  height: 25.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.5),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 3.0,
                      ),
                      Icon(Icons.star, color: Colors.red, size: 12.0),
                    ],
                  ),
                )),
          ],
        )
      ],
    ),
  );
}
