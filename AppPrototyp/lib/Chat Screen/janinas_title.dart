import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JaninasTitle extends StatelessWidget {
  const JaninasTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Janinas Title',
      style: GoogleFonts.bangers(
        fontSize: 35,
      ),
      //),
    );
  }
}
