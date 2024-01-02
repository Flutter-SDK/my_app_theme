import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app_theme/features/settings/presentation/widgets/my_app_theme.dart';
import 'package:my_app_theme/features/settings/presentation/providers/theme_provider.dart'
    as theme_provider;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _seedColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _loadSeedColor();
  }

  // Load the seed color from shared preferences
  Future<void> _loadSeedColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorString =
        prefs.getString('seedColor') ?? '0000FF'; // Default to blue
    setState(() {
      _seedColor =
          Color(int.parse(colorString, radix: 16) | 0xFF000000); // Parse color
    });
  }

  // Save the seed color to shared preferences
  Future<void> _saveSeedColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    final colorString = color.value
        .toRadixString(16)
        .substring(2)
        .toUpperCase(); // Convert color to string
    await prefs.setString('seedColor', colorString);
  }

  void _updateSeedColor(theme_provider.CustomThemeData theme) {
    setState(() {
      _seedColor = theme.color1;
      _saveSeedColor(theme.color1); // Save the selected color
    });
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle unselectedLabelStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    );

    const TextStyle selectedLabelStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
        useMaterial3: true,
        navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return selectedLabelStyle;
              }
              return unselectedLabelStyle;
            },
          ),
        ),
      ),
      home: RootPage(onThemeSelected: _updateSeedColor),
    );
  }
}

class RootPage extends StatefulWidget {
  final Function(theme_provider.CustomThemeData) onThemeSelected;

  const RootPage({super.key, required this.onThemeSelected});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return SettingPage(onThemeSelected: widget.onThemeSelected);
  }
}

class SettingPage extends StatefulWidget {
  final Function(theme_provider.CustomThemeData) onThemeSelected;

  const SettingPage({super.key, required this.onThemeSelected});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          MyAppTheme(onThemeSelected: widget.onThemeSelected),
        ],
      ),
    );
  }
}
