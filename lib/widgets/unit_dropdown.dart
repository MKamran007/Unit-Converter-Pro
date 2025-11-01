import 'package:flutter/material.dart';
import '../utils/constants.dart';

class UnitDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final Color? color;

  const UnitDropdown({
    Key? key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = color ?? theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(
            left: AppConstants.paddingSmall,
            bottom: AppConstants.paddingSmall,
          ),
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ),
        // Dropdown
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            border: Border.all(
              color: primaryColor.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down,
                color: primaryColor,
              ),
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              dropdownColor: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              items: items.map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(
                    unit,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}