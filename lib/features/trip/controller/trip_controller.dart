import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bbb/common/services/storage_service.dart';
import 'package:bbb/features/trip/data/trips_repository.dart';
import 'package:bbb/models/Trip.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tripControllerProvider = Provider<TripController>((ref) {
  return TripController(ref);
});

class TripController {
  TripController(this.ref);
  final Ref ref;

  Future<void> uploadFile(File file, Trip trip) async {
    final fileKey = await ref.read(storageServiceProvider).uploadFile(file);
    if (fileKey != null) {
      final imageUrl = await ref.read(storageServiceProvider).getImageUrl(fileKey);
      final updatedTrip = trip.copyWith(tripImageKey: fileKey, tripImageUrl: imageUrl);
      await ref.read(tripsRepositoryProvider).update(updatedTrip);
      ref.read(storageServiceProvider).resetUploadProgress();
    }
  }

  Future<void> getImageUrl(Trip trip) async {
    final fileKey = trip.tripImageKey;
    safePrint(fileKey);
    if (fileKey != null) {
      final imageUrl = await ref.read(storageServiceProvider).getImageUrl(fileKey);
      safePrint("***** $imageUrl");
      // final updatedTrip = trip.copyWith(tripImageKey: fileKey, tripImageUrl: imageUrl);
      // await ref.read(tripsRepositoryProvider).update(updatedTrip);
      // ref.read(storageServiceProvider).resetUploadProgress();
    }
  }

  ValueNotifier<double> uploadProgress() {
    return ref.read(storageServiceProvider).getUploadProgress();
  }

  Future<void> edit(Trip updatedTrip) async {
    final tripsRepository = ref.read(tripsRepositoryProvider);
    await tripsRepository.update(updatedTrip);
  }

  Future<void> delete(Trip deletedTrip) async {
    final tripsRepository = ref.read(tripsRepositoryProvider);
    await tripsRepository.delete(deletedTrip);
  }
}
