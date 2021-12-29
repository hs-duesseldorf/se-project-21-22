import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PascalsTitle extends StatelessWidget {
  const PascalsTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Pascals Title',
      style: GoogleFonts.bangers(
        fontSize: 35,
      ),
      //),
    );
  }
}