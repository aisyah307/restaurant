import 'package:flutter/material.dart';
import 'restaurant.dart';
import 'json_service.dart';

/// Halaman untuk menampilkan daftar semua restoran.
/// Data diambil dari file JSON lokal melalui JsonService.
class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _jsonService = JsonService(); // service untuk baca file JSON// indikator loading
  List<Restaurant> _restaurants = []; // daftar restoran yang diambil
  int _index = 1; // posisi bottom nav saat ini (List)

  @override
  void initState() {
    super.initState();
    _loadData(); // muat data saat halaman dibuka
  }

  /// Fungsi untuk memuat data dari file JSON
  Future<void> _loadData() async {
    final data = await _jsonService.loadRestaurants();
    setState(() {
      _restaurants = data;
    });
  }

  /// Fungsi untuk navigasi bottom navigation
  void _onNavTap(int i) {
    if (i == _index) return; // jika halaman sama, tidak berpindah
    setState(() => _index = i);

    if (i == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (i == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Halaman profil belum tersedia')),
      );
    }
  }

  /// Fungsi untuk membuka halaman detail restoran
  void _openDetail(Restaurant restaurant) {
    Navigator.pushNamed(
      context,
      '/detail',
      arguments: restaurant,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Daftar Restoran Lengkap"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body:ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = _restaurants[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),

                    // Gambar restoran
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        restaurant.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Nama & kategori restoran
                    title: Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      "${restaurant.city} - ${restaurant.cuisines}",
                      style: const TextStyle(color: Colors.black54),
                    ),

                    // Rating restoran di kanan
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.rating.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    // Klik untuk membuka detail restoran
                    onTap: () => _openDetail(restaurant),
                  ),
                );
              },
            ),

      //Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.orange,
        onTap: _onNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
