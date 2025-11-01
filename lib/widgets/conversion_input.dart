import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/constants.dart';

class ConversionInput extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final bool readOnly;
  final Color? color;

  const ConversionInput({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.readOnly = false,
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
        // Input field
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            border: Border.all(
              color: readOnly
                  ? primaryColor.withOpacity(0.2)
                  : primaryColor.withOpacity(0.3),
              width: readOnly ? 1 : 1.5,
            ),
          ),
          child: TextField(
            controller: TextEditingController(text: value)
              ..selection = TextSelection.fromPosition(
                TextPosition(offset: value.length),
              ),
            onChanged: onChanged,
            readOnly: readOnly,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: readOnly
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: readOnly ? 'Result' : 'Enter value',
              hintStyle: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.3),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingMedium,
                vertical: AppConstants.paddingLarge,
              ),
            ),
          ),
        ),
      ],
    );
  }
}