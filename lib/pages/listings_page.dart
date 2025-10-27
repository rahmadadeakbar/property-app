import 'package:flutter/material.dart';
import '../models/property.dart';
import 'property_detail_page.dart';

class ListingsPage extends StatelessWidget {
  final List<Property> listings;

  const ListingsPage({Key? key, required this.listings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Listings')),
      body: ListView.separated(
        padding: EdgeInsets.all(12),
        itemCount: listings.length,
        separatorBuilder: (_, __) => SizedBox(height: 10),
        itemBuilder: (context, index) {
          final p = listings[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PropertyDetailPage(property: p))),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                    child: Image.network(p.imageUrl, width: 120, height: 90, fit: BoxFit.cover),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.title, style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 6),
                          Text(p.location, style: TextStyle(color: Colors.black54, fontSize: 12)),
                          SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(p.price, style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                              Text('${p.beds}bd • ${p.baths}ba • ${p.area}m²', style: TextStyle(color: Colors.black45, fontSize: 12)),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
