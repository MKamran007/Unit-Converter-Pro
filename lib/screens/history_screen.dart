import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/conversion_provider.dart';
import '../utils/constants.dart';
import '../widgets/history_item.dart';
import 'conversion_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConversionProvider>(context);
    final history = _showFavoritesOnly
        ? provider.favoriteHistory
        : provider.history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          // Toggle favorites filter
          IconButton(
            icon: Icon(
              _showFavoritesOnly ? Icons.star : Icons.star_border,
            ),
            onPressed: () {
              setState(() {
                _showFavoritesOnly = !_showFavoritesOnly;
              });
            },
            tooltip: _showFavoritesOnly
                ? 'Show all'
                : 'Show favorites only',
          ),
          // Clear history menu
          if (history.isNotEmpty)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'clear_all') {
                  _showClearConfirmation(context, provider, true);
                } else if (value == 'clear_non_favorite') {
                  _showClearConfirmation(context, provider, false);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'clear_non_favorite',
                  child: Row(
                    children: [
                      Icon(Icons.delete_sweep),
                      SizedBox(width: 8),
                      Text('Clear non-favorites'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'clear_all',
                  child: Row(
                    children: [
                      Icon(Icons.delete_forever, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Clear all history'),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      body: history.isEmpty
          ? _buildEmptyState(context)
          : Column(
        children: [
          // Filter chip
          if (provider.history.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Wrap(
                spacing: 8,
                children: [
                  FilterChip(
                    label: Text('All (${provider.history.length})'),
                    selected: !_showFavoritesOnly,
                    onSelected: (selected) {
                      setState(() {
                        _showFavoritesOnly = false;
                      });
                    },
                  ),
                  FilterChip(
                    label: Text('Favorites (${provider.favoriteHistory.length})'),
                    selected: _showFavoritesOnly,
                    onSelected: (selected) {
                      setState(() {
                        _showFavoritesOnly = true;
                      });
                    },
                  ),
                ],
              ),
            ),
          // History list
          Expanded(
            child: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                return HistoryItem(
                  history: item,
                  onTap: () {
                    // Load this conversion and navigate to conversion screen
                    provider.loadHistoryItem(item);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConversionScreen(),
                      ),
                    );
                  },
                  onDelete: () {
                    provider.deleteHistoryItem(item.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Deleted from history'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  onToggleFavorite: () {
                    provider.toggleFavorite(item.id);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _showFavoritesOnly ? Icons.star_border : Icons.history,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            Text(
              _showFavoritesOnly
                  ? 'No Favorites Yet'
                  : 'No History Yet',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Text(
              _showFavoritesOnly
                  ? 'Star conversions to save them as favorites'
                  : 'Start converting units to see your history here',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showClearConfirmation(
      BuildContext context,
      ConversionProvider provider,
      bool clearAll,
      ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(clearAll ? 'Clear All History?' : 'Clear Non-Favorites?'),
        content: Text(
          clearAll
              ? 'This will delete all conversion history including favorites. This action cannot be undone.'
              : 'This will delete all non-favorite conversions. Favorites will be preserved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (clearAll) {
                provider.clearHistory();
              } else {
                provider.clearNonFavoriteHistory();
              }
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('History cleared'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}