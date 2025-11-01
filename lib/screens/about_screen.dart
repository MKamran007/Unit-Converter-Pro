import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App icon
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.calculate_rounded,
                    size: 80,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingLarge),

                // App name
                Text(
                  AppConstants.appName,
                  style: theme.textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.paddingSmall),

                // Version
                Text(
                  'Version ${AppConstants.appVersion}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: AppConstants.paddingLarge),

                // Description
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: AppConstants.paddingSmall),
                            Text(
                              'About',
                              style: theme.textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        Text(
                          'Unit Converter Pro is a simple, fast, and accurate unit conversion tool. Convert between different units of measurement across multiple categories including length, weight, temperature, volume, area, and speed.',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.paddingMedium),

                // Features
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star_outline,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: AppConstants.paddingSmall),
                            Text(
                              'Features',
                              style: theme.textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        _buildFeatureItem(
                          context,
                          Icons.straighten,
                          '6 Conversion Categories',
                        ),
                        _buildFeatureItem(
                          context,
                          Icons.offline_bolt,
                          'Works Completely Offline',
                        ),
                        _buildFeatureItem(
                          context,
                          Icons.history,
                          'Conversion History',
                        ),
                        _buildFeatureItem(
                          context,
                          Icons.star,
                          'Favorite Conversions',
                        ),
                        _buildFeatureItem(
                          context,
                          Icons.dark_mode,
                          'Dark Mode Support',
                        ),
                        _buildFeatureItem(
                          context,
                          Icons.speed,
                          'Real-time Conversion',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.paddingMedium),

                // Developer info
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: AppConstants.paddingSmall),
                            Text(
                              'Developer',
                              style: theme.textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        Text(
                          'Developed by ${AppConstants.developerName}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppConstants.paddingSmall),
                        Text(
                          AppConstants.developerEmail,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.paddingMedium),

                // Categories supported
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.category_outlined,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: AppConstants.paddingSmall),
                            Text(
                              'Supported Categories',
                              style: theme.textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: AppConstants.allCategories.map((category) {
                            return Chip(
                              avatar: Icon(
                                AppConstants.getIconForCategory(category),
                                size: 18,
                                color: AppConstants.getColorForCategory(category),
                              ),
                              label: Text(category),
                              backgroundColor: AppConstants.getColorForCategory(category)
                                  .withOpacity(0.1),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.paddingLarge),

                // Copyright
                Text(
                  '© 2024 ${AppConstants.appName}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
                Text(
                  'All rights reserved',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: AppConstants.paddingMedium),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}