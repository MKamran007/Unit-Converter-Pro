import 'package:flutter/material.dart';
import '../models/conversion_history.dart';
import '../utils/constants.dart';

class HistoryItem extends StatelessWidget {
  final ConversionHistory history;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onToggleFavorite;

  const HistoryItem({
    Key? key,
    required this.history,
    required this.onTap,
    required this.onDelete,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoryColor = AppConstants.getColorForCategory(history.category);
    final categoryIcon = AppConstants.getIconForCategory(history.category);

    return Dismissible(
      key: Key(history.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppConstants.paddingLarge),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      onDismissed: (_) => onDelete(),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingSmall,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Row(
              children: [
                // Category icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    categoryIcon,
                    color: categoryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingMedium),
                // Conversion details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category name
                      Text(
                        history.category,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Conversion text
                      Text(
                        history.displayText,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Time ago
                      Text(
                        history.timeAgo,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                // Favorite button
                IconButton(
                  icon: Icon(
                    history.isFavorite ? Icons.star : Icons.star_border,
                    color: history.isFavorite
                        ? Colors.amber
                        : theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                  onPressed: onToggleFavorite,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}