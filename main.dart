import 'package:flutter/material.dart';
 
void main() {
  runApp(const MyApp());
}
 
// ===================== MODEL DATA =====================
class Pembangkit {
  final String nama; // String
  final String sumberEnergi; // String
  final String lokasiContoh; // String
  final int kapasitasMw; // int
  final double efisiensiPersen; // double
  final bool terbarukan; // bool
 
  const Pembangkit({
    required this.nama,
    required this.sumberEnergi,
    required this.lokasiContoh,
    required this.kapasitasMw,
    required this.efisiensiPersen,
    required this.terbarukan,
  });
}
 
// ===================== MYAPP (satu-satunya MaterialApp) =====================
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Pembangkit Listrik',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E4D8C), // biru listrik
        ),
        scaffoldBackgroundColor: const Color(0xFFF2F6FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E4D8C),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const HalamanUtama(),
    );
  }
}
 
// ===================== HALAMAN UTAMA (Scaffold) =====================
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});
 
  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}
 
class _HalamanUtamaState extends State<HalamanUtama> {
  final String subjudul = 'Mengenal sumber listrik di Indonesia';
  final String watermark = '202432027_Amanda Damayanti';
 
  final List<Pembangkit> daftarPembangkit = const [
    Pembangkit(
      nama: 'PLTA Cirata',
      sumberEnergi: 'Tenaga air',
      lokasiContoh: 'Purwakarta, Jawa Barat',
      kapasitasMw: 1008,
      efisiensiPersen: 90.0,
      terbarukan: true,
    ),
    Pembangkit(
      nama: 'PLTU Suralaya',
      sumberEnergi: 'Batu bara',
      lokasiContoh: 'Cilegon, Banten',
      kapasitasMw: 3400,
      efisiensiPersen: 38.0,
      terbarukan: false,
    ),
    Pembangkit(
      nama: 'PLTS Terapung Cirata',
      sumberEnergi: 'Tenaga surya',
      lokasiContoh: 'Waduk Cirata, Jawa Barat',
      kapasitasMw: 192,
      efisiensiPersen: 20.0,
      terbarukan: true,
    ),
    Pembangkit(
      nama: 'PLTB Sidrap',
      sumberEnergi: 'Tenaga angin',
      lokasiContoh: 'Sidenreng Rappang, Sulsel',
      kapasitasMw: 75,
      efisiensiPersen: 35.0,
      terbarukan: true,
    ),
    Pembangkit(
      nama: 'PLTP Kamojang',
      sumberEnergi: 'Panas bumi',
      lokasiContoh: 'Garut, Jawa Barat',
      kapasitasMw: 235,
      efisiensiPersen: 15.0,
      terbarukan: true,
    ),
  ];
 
  final Set<String> _favorit = {};
 
  void _toggleFavorit(Pembangkit p) {
  final bool sudahFavorit = _favorit.contains(p.nama);

  debugPrint('=== ${p.nama} ===');
  debugPrint('Sumber energi : ${p.sumberEnergi}');
  debugPrint('Lokasi        : ${p.lokasiContoh}');
  debugPrint('Kapasitas     : ${p.kapasitasMw} MW');
  debugPrint('Efisiensi     : ±${p.efisiensiPersen}%');
  debugPrint('Terbarukan    : ${p.terbarukan ? "Ya" : "Tidak"}');
  debugPrint('Aksi          : ${sudahFavorit ? "Dihapus dari favorit" : "Ditandai favorit"}');
  debugPrint('Total favorit : ${sudahFavorit ? _favorit.length - 1 : _favorit.length + 1}');

  setState(() {
    if (sudahFavorit) {
      _favorit.remove(p.nama);
    } else {
      _favorit.add(p.nama);
    }
  });
}
 
  @override
  Widget build(BuildContext context) {
    final int jumlahTerbarukan =
        daftarPembangkit.where((p) => p.terbarukan).length;
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Pembangkit Listrik'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan Container + BoxDecoration
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E4D8C), Color(0xFF3F7CC4)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.bolt,
                        color: Color(0xFFFFC83D), size: 40),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Jenis Pembangkit Listrik',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            subjudul,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
 
              // Custom widget: kartu ringkasan
              KartuRingkasan(
                totalJenis: daftarPembangkit.length,
                terbarukan: jumlahTerbarukan,
                favorit: _favorit.length,
              ),
              const SizedBox(height: 16),
 
              const Text(
                'Daftar Pembangkit',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
 
              // Custom widget: kartu pembangkit
              for (final p in daftarPembangkit)
                KartuPembangkit(
                  pembangkit: p,
                  isFavorit: _favorit.contains(p.nama),
                  onFavorit: () => _toggleFavorit(p),
                ),
 
              const SizedBox(height: 8),
              Center(
                child: Text(
                  watermark,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
// ===================== CUSTOM WIDGET: KARTU RINGKASAN =====================
class KartuRingkasan extends StatelessWidget {
  final int totalJenis;
  final int terbarukan;
  final int favorit;
 
  const KartuRingkasan({
    super.key,
    required this.totalJenis,
    required this.terbarukan,
    required this.favorit,
  });
 
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: _ItemStatistik(
                ikon: Icons.factory,
                label: 'Total',
                nilai: '$totalJenis',
              ),
            ),
            Expanded(
              child: _ItemStatistik(
                ikon: Icons.eco,
                label: 'Terbarukan',
                nilai: '$terbarukan',
              ),
            ),
            Expanded(
              child: _ItemStatistik(
                ikon: Icons.star,
                label: 'Favorit',
                nilai: '$favorit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 
class _ItemStatistik extends StatelessWidget {
  final IconData ikon;
  final String label;
  final String nilai;
 
  const _ItemStatistik({
    required this.ikon,
    required this.label,
    required this.nilai,
  });
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(ikon, color: const Color(0xFF1E4D8C)),
        const SizedBox(height: 4),
        Text(
          nilai,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.black54, fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
 
// ===================== CUSTOM WIDGET: KARTU PEMBANGKIT =====================
class KartuPembangkit extends StatelessWidget {
  final Pembangkit pembangkit;
  final bool isFavorit;
  final VoidCallback onFavorit;
 
  const KartuPembangkit({
    super.key,
    required this.pembangkit,
    required this.isFavorit,
    required this.onFavorit,
  });
 
  @override
  Widget build(BuildContext context) {
    final Color warnaLabel = pembangkit.terbarukan
        ? const Color(0xFF2E7D32)
        : const Color(0xFF8D4B00);
 
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3CC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFFC83D)),
                  ),
                  child: const Icon(Icons.bolt, color: Color(0xFFE09B00)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pembangkit.nama,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        pembangkit.sumberEnergi,
                        style: const TextStyle(color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Label status terbarukan
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: warnaLabel,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    pembangkit.terbarukan ? 'Terbarukan' : 'Non-terbarukan',
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Wrap supaya tidak overflow di layar sempit
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _InfoKecil(
                  ikon: Icons.power,
                  teks: '${pembangkit.kapasitasMw} MW',
                ),
                _InfoKecil(
                  ikon: Icons.speed,
                  teks: 'Efisiensi ±${pembangkit.efisiensiPersen}%',
                ),
                _InfoKecil(
                  ikon: Icons.location_on,
                  teks: pembangkit.lokasiContoh,
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onFavorit,
                icon: Icon(isFavorit ? Icons.star : Icons.star_border),
                label: Text(isFavorit ? 'Hapus dari Favorit' : 'Tandai Favorit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 
class _InfoKecil extends StatelessWidget {
  final IconData ikon;
  final String teks;
 
  const _InfoKecil({required this.ikon, required this.teks});
 
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(ikon, size: 16, color: Colors.black54),
        const SizedBox(width: 4),
        // Flexible mencegah overflow untuk teks lokasi yang panjang
        Flexible(
          child: Text(teks, style: const TextStyle(fontSize: 13)),
        ),
      ],
    );
  }
}
 