import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';
import 'product_form_screen.dart';
import 'product_detail_screen.dart';

// AI-ASSISTED: Search + Filter + Badge + Progress + Dismissible + Reorder
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String search = '';
  Category? filter;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    final products = provider.products.where((p) {
      return p.name.toLowerCase().contains(search.toLowerCase()) &&
          (filter == null || p.category == filter);
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search product...",
            ),
            onChanged: (v) => setState(() => search = v),
          ),
        ),

        // Filter
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              filterChip("All", null),
              ...Category.values.map((c) => filterChip(c.name, c)),
            ],
          ),
        ),

        Expanded(
          child: ReorderableListView.builder(
            itemCount: products.length,
            onReorder: provider.reorder,
            itemBuilder: (context, i) {
              final p = products[i];
              final daysLeft =
                  p.expiryDate.difference(DateTime.now()).inDays;

              return Dismissible(
                key: ValueKey(p.id),
                background: swipeBg(
                    Colors.green, Icons.edit, Alignment.centerLeft),
                secondaryBackground: swipeBg(
                    Colors.red, Icons.delete, Alignment.centerRight),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    final edited = await Navigator.push<Product?>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductFormScreen(edit: p),
                      ),
                    );
                    if (edited != null) provider.update(edited);
                    return false;
                  } else {
                    provider.remove(p.id);
                    return true;
                  }
                },
                child: ListTile(
                  leading: Image.network(
                    p.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(p.name),
                  subtitle: LinearProgressIndicator(
                    value: (daysLeft / 30).clamp(0.0, 1.0),
                  ),
                  trailing: daysLeft <= 3
                      ? const Icon(Icons.warning, color: Colors.red)
                      : null,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductDetailScreen(product: p),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8),
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              final p = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ProductFormScreen()),
              );
              if (p != null) provider.add(p);
            },
          ),
        ),
      ],
    );
  }

  Widget filterChip(String label, Category? c) {
    final selected = filter == c;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => setState(() => filter = c),
      ),
    );
  }

  Widget swipeBg(Color c, IconData i, Alignment a) {
    return Container(
      alignment: a,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: c,
      child: Icon(i, color: Colors.white),
    );
  }
}
