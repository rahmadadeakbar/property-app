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

final List<Property> sampleFeatured = [
  Property(
    id: 'f0',
    title: 'Rumah Mewah Modern',
    location: 'BSD City, Tangerang',
    price: 'Rp 2.500 jt',
    beds: 4,
    baths: 3,
    area: 150,
    imageUrl:
        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800&q=80',
  ),
  Property(
    id: 'f1',
    title: 'Villa Minimalis',
    location: 'Alam Sutera, Tangerang',
    price: 'Rp 3.200 jt',
    beds: 5,
    baths: 4,
    area: 200,
    imageUrl:
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&q=80',
  ),
  Property(
    id: 'f2',
    title: 'Apartemen Premium',
    location: 'Sudirman, Jakarta Pusat',
    price: 'Rp 4.500 jt',
    beds: 3,
    baths: 2,
    area: 120,
    imageUrl:
        'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800&q=80',
  ),
  Property(
    id: 'f3',
    title: 'Rumah Cluster Elite',
    location: 'Pantai Indah Kapuk, Jakarta',
    price: 'Rp 5.800 jt',
    beds: 5,
    baths: 4,
    area: 250,
    imageUrl:
        'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&q=80',
  ),
  Property(
    id: 'f4',
    title: 'Townhouse Modern',
    location: 'Kemang, Jakarta Selatan',
    price: 'Rp 3.800 jt',
    beds: 4,
    baths: 3,
    area: 180,
    imageUrl:
        'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde?w=800&q=80',
  ),
];

final List<Property> sampleRecent = [
  Property(
    id: 'r0',
    title: 'Rumah Minimalis',
    location: 'Bintaro, Tangerang Selatan',
    price: 'Rp 850 jt',
    beds: 3,
    baths: 2,
    area: 90,
    imageUrl:
        'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=600&q=80',
  ),
  Property(
    id: 'r1',
    title: 'Apartemen Studio',
    location: 'Gading Serpong, Tangerang',
    price: 'Rp 650 jt',
    beds: 1,
    baths: 1,
    area: 45,
    imageUrl:
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=600&q=80',
  ),
  Property(
    id: 'r2',
    title: 'Rumah Siap Huni',
    location: 'Bekasi Timur',
    price: 'Rp 950 jt',
    beds: 3,
    baths: 2,
    area: 110,
    imageUrl:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=600&q=80',
  ),
  Property(
    id: 'r3',
    title: 'Cluster Strategis',
    location: 'Depok, Jawa Barat',
    price: 'Rp 780 jt',
    beds: 2,
    baths: 1,
    area: 70,
    imageUrl:
        'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=600&q=80',
  ),
  Property(
    id: 'r4',
    title: 'Rumah Hook',
    location: 'Cibubur, Jakarta Timur',
    price: 'Rp 1.200 jt',
    beds: 4,
    baths: 2,
    area: 130,
    imageUrl:
        'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=600&q=80',
  ),
  Property(
    id: 'r5',
    title: 'Kondominium View',
    location: 'Senayan, Jakarta Pusat',
    price: 'Rp 2.100 jt',
    beds: 2,
    baths: 2,
    area: 85,
    imageUrl:
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=600&q=80',
  ),
];
