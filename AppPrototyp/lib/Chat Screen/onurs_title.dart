import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnursTitle extends StatelessWidget {
  const OnursTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Lerngruppe HöMa',
        style: GoogleFonts.bangers(
          fontSize: 35,
        ));
  }
}
