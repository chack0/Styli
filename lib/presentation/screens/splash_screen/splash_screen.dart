// FLUTTER IMPORTS.
import "package:flutter/material.dart";

// FLUTTER PLUGIN IMPORTS.
import "package:flutter_svg/flutter_svg.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/icon_vertical.svg",
            width: 70,
            height: 85,
          ),
          const SizedBox(width: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "test",
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 44,
                  color: Colors.black,
                ),
              ),
              Text(
                "STYLI",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 44,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
