class Property {
  final String id;
  final String title;
  final String location;
  final String price;
  final int beds;
  final int baths;
  final int area;
  final String imageUrl;

  Property({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.beds,
    required this.baths,
    required this.area,
    required this.imageUrl,
  });
}

final List<Property> sampleFeatured = List.generate(
  5,
  (i) => Property(
    id: 'f$i',
    title: 'Rumah Mewah ${i + 1}',
    location: 'Kawasan Elite ${i + 1}',
    price: 'Rp ${(1_000 + i * 250).toString()} jt',
    beds: 3 + i,
    baths: 2 + (i % 2),
    area: 120 + i * 30,
    imageUrl: 'https://picsum.photos/seed/property$i/800/600',
  ),
);

final List<Property> sampleRecent = List.generate(
  6,
  (i) => Property(
    id: 'r$i',
    title: 'Cluster Cozy ${i + 1}',
    location: 'Kota ${i + 1}',
    price: 'Rp ${(300 + i * 50).toString()} jt',
    beds: 2 + (i % 3),
    baths: 1 + (i % 2),
    area: 60 + i * 20,
    imageUrl: 'https://picsum.photos/seed/recent$i/600/400',
  ),
);
