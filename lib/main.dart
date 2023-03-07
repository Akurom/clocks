import 'package:clocks/const/color_constants.dart';
import 'package:clocks/models/app_model.dart';
import 'package:clocks/models/clock_model.dart';
import 'package:clocks/views/pages/clock_page.dart';
import 'package:clocks/views/widgets/analog_clock/analog_clock_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'commands/base_command.dart' as Commands;

void main() {
  // ------
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // ------
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppModel>(create: (_) => AppModel()),
        ChangeNotifierProvider<ClockModel>(create: (_) => ClockModel.reset()),
      ],
      child: Builder(
        builder: (context) {
          Commands.init(context);
          return MaterialApp(
            //theme: ThemeData(scaffoldBackgroundColor: Colors.black),
            theme: ThemeData(
              textTheme: TextTheme(
                displayLarge: GoogleFonts.roboto(fontSize: 92.0, color: ColorConstants.main),
                displayMedium: GoogleFonts.roboto(fontSize: 44.0, color: ColorConstants.main),
                displaySmall: GoogleFonts.roboto(fontSize: 24.0, color: ColorConstants.main),
                headlineLarge: GoogleFonts.roboto(color: ColorConstants.main),
                headlineMedium: GoogleFonts.roboto(color: ColorConstants.main),
                headlineSmall: GoogleFonts.roboto(color: ColorConstants.main),
                bodyLarge: GoogleFonts.roboto(color: ColorConstants.main),
                bodySmall: GoogleFonts.roboto(color: ColorConstants.main),
                labelLarge: GoogleFonts.roboto(color: ColorConstants.main),
                labelMedium: GoogleFonts.roboto(color: ColorConstants.main),
                labelSmall: GoogleFonts.roboto(color: ColorConstants.main),
              ),
            ),
            home: Scaffold(
              body: ClockPage(),
            ),
          );
        },
      ),
    );
  }
}
