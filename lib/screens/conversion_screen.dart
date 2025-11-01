import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/conversion_provider.dart';
import '../utils/constants.dart';
import '../widgets/unit_dropdown.dart';
import '../widgets/conversion_input.dart';

class ConversionScreen extends StatelessWidget {
  const ConversionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConversionProvider>(context);
    final categoryColor = AppConstants.getColorForCategory(provider.selectedCategory);

    return Scaffold(
      appBar: AppBar(
        title: Text(provider.selectedCategory),
        backgroundColor: categoryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              children: [
                const SizedBox(height: AppConstants.paddingMedium),

                // Input value
                ConversionInput(
                  label: 'Enter Value',
                  value: provider.inputValue,
                  onChanged: (value) {
                    provider.setInputValue(value);
                  },
                  color: categoryColor,
                ),

                const SizedBox(height: AppConstants.paddingMedium),

                // From unit dropdown
                UnitDropdown(
                  label: 'From',
                  value: provider.fromUnit,
                  items: provider.currentUnits,
                  onChanged: (value) {
                    if (value != null) {
                      provider.setFromUnit(value);
                    }
                  },
                  color: categoryColor,
                ),

                const SizedBox(height: AppConstants.paddingMedium),

                // Swap button
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: categoryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.swap_vert,
                        color: categoryColor,
                        size: 32,
                      ),
                      onPressed: () {
                        provider.swapUnits();
                      },
                      tooltip: 'Swap units',
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.paddingMedium),

                // To unit dropdown
                UnitDropdown(
                  label: 'To',
                  value: provider.toUnit,
                  items: provider.currentUnits,
                  onChanged: (value) {
                    if (value != null) {
                      provider.setToUnit(value);
                    }
                  },
                  color: categoryColor,
                ),

                const SizedBox(height: AppConstants.paddingMedium),

                // Result value
                ConversionInput(
                  label: 'Result',
                  value: provider.resultValue,
                  onChanged: (_) {},
                  readOnly: true,
                  color: categoryColor,
                ),

                const SizedBox(height: AppConstants.paddingLarge),

                // Action buttons
                Row(
                  children: [
                    // Clear button
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          provider.clear();
                        },
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppConstants.paddingMedium,
                          ),
                          side: BorderSide(color: categoryColor),
                          foregroundColor: categoryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstants.borderRadius,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppConstants.paddingMedium),
                    // Save to history button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: provider.inputValue.isEmpty ||
                            provider.resultValue.isEmpty ||
                            provider.resultValue == 'Error'
                            ? null
                            : () {
                          provider.saveToHistory();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Saved to history'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Save'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppConstants.paddingMedium,
                          ),
                          backgroundColor: categoryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstants.borderRadius,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.paddingLarge),

                // Info card
                Card(
                  color: categoryColor.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: categoryColor,
                        ),
                        const SizedBox(width: AppConstants.paddingMedium),
                        Expanded(
                          child: Text(
                            'Enter a value above to see the conversion result. Tap the swap button to reverse units.',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}