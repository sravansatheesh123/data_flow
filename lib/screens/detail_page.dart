import 'package:flutter/material.dart';
import '../models/listing.dart';
import '../widgets/image_gallery.dart';

class DetailPage extends StatelessWidget {
  final Listing listing;

  const DetailPage({Key? key, required this.listing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: height * 0.40,
                  width: double.infinity,
                  child: ImageGallery(images: listing.pictures),
                ),
                Positioned(
                  top: height * 0.05,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.blue),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                Positioned(
                  top: height * 0.05,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.share, color: Colors.blue,),
                      onPressed: () => _shareListing(context),
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.05,
                  left: width * 0.25,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03,
                      vertical: height * 0.004,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Text(
                      "MLS# ${listing.idcmlsNumber}",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        listing.formattedPrice,
                        style: TextStyle(
                          fontSize: width * 0.065,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        listing.idcPropertyType,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: width * 0.045,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03,
                          vertical: height * 0.006,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          listing.idcStatus,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.015),

                  Text(
                    listing.idcFullAddress,
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  Row(
                    children: [
                      _iconText(Icons.bed, "${listing.beds}"),
                      SizedBox(width: 12),
                      _iconText(Icons.bathtub, "${listing.bathsTotal}"),
                      SizedBox(width: 12),
                      _iconText(Icons.square_foot, "${listing.sqft} Sqft"),
                    ],
                  ),

                  SizedBox(height: height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: const [
                          Icon(Icons.message, color: Colors.blue, size: 20),
                          SizedBox(height: 6),
                          Text(
                            "Contact Agent",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 45,
                        color: Color(0xFFE5E5E5),
                      ),

                      Column(
                        children: const [
                          Icon(Icons.location_on, color: Colors.blue, size: 20),
                          SizedBox(height: 6),
                          Text(
                            "Directions",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.03),
                  Text(
                    "Description",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: height * 0.01),

                  Text(
                    listing.idcRemarks,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: height * 0.03),

                  _agentInfo(width),

                  SizedBox(height: height * 0.04),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
  Widget _agentInfo(double width) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Row(
          children: [
            CircleAvatar(
              radius: width * 0.08,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.person, size: 28, color: Colors.white),
            ),
            SizedBox(width: width * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listing.listAgentName ?? "",
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  listing.listAgentOffice ?? "",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _shareListing(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Share feature not implemented")),
    );
  }
}
