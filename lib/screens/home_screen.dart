import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/conversion_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/constants.dart';
import '../widgets/category_card.dart';
import 'conversion_screen.dart';
import 'history_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const HistoryScreen(),
    const AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final conversionProvider = Provider.of<ConversionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          // Theme toggle button
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
            tooltip: 'Toggle theme',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              child: Column(
                children: [
                  Icon(
                    Icons.calculate_rounded,
                    size: 60,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),
                  Text(
                    'Choose a Category',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),
                  Text(
                    'Select a unit type to start converting',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Category grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: AppConstants.paddingMedium,
                  mainAxisSpacing: AppConstants.paddingMedium,
                ),
                itemCount: AppConstants.allCategories.length,
                itemBuilder: (context, index) {
                  final category = AppConstants.allCategories[index];
                  return CategoryCard(
                    categoryName: category,
                    onTap: () {
                      // Set category and navigate to conversion screen
                      conversionProvider.setCategory(category);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConversionScreen(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}