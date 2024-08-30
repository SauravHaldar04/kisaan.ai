import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nfc3_overload_oblivion/features/home/widgets/mcrop_card_widget.dart';
import 'crop_card_widget.dart'; // Import the CropCardWidget

class MainCropPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Crops'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('crops')
            .where('userId',
                isEqualTo: user?.uid) // Get crops for the current user
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No crops found.'));
          }

          final cropDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: cropDocs.length,
            itemBuilder: (context, index) {
              final cropData = cropDocs[index].data() as Map<String, dynamic>;

              final cropName = cropData['cropName'] ?? 'Unknown Crop';
              final imageUrl = cropData['reportImage'] ?? '';

              final cropDescription =
                  cropData['reportDescription'] ?? 'No description available';
              final reportDisease =
                  cropData['reportDisease'] ?? 'No disease found';

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CropCardWidget2(
                  cropName: cropName,
                  imageUrl: imageUrl,
                  cropDescription: cropDescription,
                  cropDisease: reportDisease,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
