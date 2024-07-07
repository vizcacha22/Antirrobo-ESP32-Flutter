import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(27, 41, 27, 509.4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 371),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/image_2.png',
                      ),
                    ),
                  ),
                  child: Container(
                    width: 359,
                    height: 97,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 102),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color(0xFF8189D1),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x80000000),
                    offset: Offset(10, 10),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Container(
                width: 456,
                padding: EdgeInsets.fromLTRB(0, 14, 1.8, 8),
                child: Text(
                  'Activar protección',
                  style: GoogleFonts.getFont(
                    'Mukta',
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color(0xFF8189D1),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x80000000),
                    offset: Offset(10, 10),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Container(
                width: 456,
                padding: EdgeInsets.fromLTRB(0, 14, 0.6, 8),
                child: Text(
                  'Desactivar protección',
                  style: GoogleFonts.getFont(
                    'Mukta',
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}