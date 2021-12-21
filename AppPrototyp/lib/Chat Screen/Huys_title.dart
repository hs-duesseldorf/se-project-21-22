
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HuysTitle extends StatelessWidget {
  const HuysTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Lerngruppe Huy',
        style: GoogleFonts.bangers(
          fontSize: 40,
        ));
  }
}
