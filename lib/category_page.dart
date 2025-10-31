import 'package:flutter/material.dart';
import 'restaurant.dart';
import 'json_service.dart';

//menampilkan daftar restoran berdasarkan
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _jsonService = JsonService();
  List<Restaurant> _restaurants = [];
  late String _category; // kategori dikirim dari halaman sebelumnya

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ambil nama kategori dari argument navigasi
    _category = ModalRoute.of(context)!.settings.arguments as String;
    _loadData();
  }

  //memuat data dan menyaring berdasarkan kategori
  Future<void> _loadData() async {
    final data = await _jsonService.loadRestaurants();
    final filtered = data.where((r) {
      // cocokkan kategori (case-insensitive)
      return r.cuisines.toLowerCase().contains(_category.toLowerCase());
    }).toList();

    setState(() {
      _restaurants = filtered;
    });
  }

  //navigasi ke halaman detail restoran
  void _openDetail(Restaurant restaurant) {
    Navigator.pushNamed(context, '/detail', arguments: restaurant);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("Kategori: $_category"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),

      body:
          //Jika kategori kosong
          _restaurants.isEmpty
          ? const Center(child: Text("Tidak ada restoran dalam kategori ini"))
          //Tampilkan daftar restoran
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _restaurants.length,
              itemBuilder: (context, i) {
                final r = _restaurants[i];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        r.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      r.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      "${r.city} - ${r.cuisines}",
                      style: const TextStyle(color: Colors.black54),
                    ),

                    // Rating restoran di kanan
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          r.rating.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => _openDetail(r),
                  ),
                );
              },
            ),
    );
  }
}
