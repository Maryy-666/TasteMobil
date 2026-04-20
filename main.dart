import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';
import '../widgets/recipe_card.dart';
import '../widgets/common_widgets.dart';
import 'recipe_detail_screen.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'Tümü';
  List<Recipe> _all = [];
  List<Recipe> _filtered = [];

  @override
  void initState() {
    super.initState();
    _all = RecipeData.getAll();
    _filtered = _all;
    _searchController.addListener(_applyFilter);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilter() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filtered = _all.where((r) {
        final matchCat = _selectedCategory == 'Tümü' ||
            r.category.toLowerCase() == _selectedCategory.toLowerCase() ||
            r.tags.any((t) => t.toLowerCase() == _selectedCategory.toLowerCase());
        final matchQ = query.isEmpty ||
            r.title.toLowerCase().contains(query) ||
            r.chef.toLowerCase().contains(query) ||
            r.tags.any((t) => t.toLowerCase().contains(query));
        return matchCat && matchQ;
      }).toList();
    });
  }

  void _selectCategory(String cat) {
    setState(() => _selectedCategory = cat);
    _applyFilter();
  }

  void _openDetail(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetailScreen(recipe: recipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Chef',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.brand,
                  letterSpacing: -0.5,
                ),
              ),
              TextSpan(
                text: 'Market',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gold,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.goldSoft,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.gold, width: 0.5),
            ),
            child: const Text(
              '₺ 1.240',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.goldDark,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tarif veya şef ara...',
                prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.textMuted),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18, color: AppColors.textMuted),
                        onPressed: () {
                          _searchController.clear();
                          _applyFilter();
                        },
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: RecipeData.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final cat = RecipeData.categories[i];
                return CategoryChip(
                  label: cat,
                  isSelected: _selectedCategory == cat,
                  onTap: () => _selectCategory(cat),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _filtered.isEmpty
                ? const EmptyState(
                    emoji: '🔍',
                    title: 'Sonuç bulunamadı',
                    subtitle: 'Farklı bir arama terimi veya kategori deneyin.',
                  )
                : _buildGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return CustomScrollView(
      slivers: [
        // Öne çıkan tarif (sadece filtre yoksa)
        if (_selectedCategory == 'Tümü' && _searchController.text.isEmpty && _filtered.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SectionHeader(
                    title: 'Öne Çıkan',
                    actionLabel: 'Tümünü gör',
                    onAction: () {},
                  ),
                  const SizedBox(height: 12),
                  RecipeCard(
                    recipe: _filtered.first,
                    onTap: () => _openDetail(_filtered.first),
                    isFeatured: true,
                  ),
                  const SizedBox(height: 20),
                  SectionHeader(
                    title: 'Tüm Tarifler',
                    actionLabel: '${_filtered.length} tarif',
                    onAction: null,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        // Grid
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                final startIndex = (_selectedCategory == 'Tümü' && _searchController.text.isEmpty) ? 1 : 0;
                if (i + startIndex >= _filtered.length) return null;
                final recipe = _filtered[i + startIndex];
                return RecipeCard(
                  recipe: recipe,
                  onTap: () => _openDetail(recipe),
                );
              },
              childCount: _filtered.length - (_selectedCategory == 'Tümü' && _searchController.text.isEmpty ? 1 : 0),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
          ),
        ),
      ],
    );
  }
}
