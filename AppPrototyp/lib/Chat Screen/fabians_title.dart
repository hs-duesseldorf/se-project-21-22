import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FabiansTitle extends StatelessWidget {
  const FabiansTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Fabians Titel',
      style: GoogleFonts.bangers(
        fontSize: 55,
      ),
      //),
    );
  }
}
