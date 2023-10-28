import 'package:bbb/common/navigation/router/routes.dart';
import 'package:bbb/common/utils/colors.dart' as constants;
import 'package:bbb/features/trip/ui/trip_gridview_item/trip_gridview_item_card.dart';
import 'package:bbb/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TripGridViewItem extends StatelessWidget {
  const TripGridViewItem({
    required this.trip,
    required this.isPast,
    super.key,
  });

  final Trip trip;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        context.goNamed(
          isPast ? AppRoute.pasttrip.name : AppRoute.trip.name,
          params: {'id': trip.id},
        );
      },
      child: isPast
          ? ColorFiltered(
              colorFilter: const ColorFilter.matrix(constants.greyoutMatrix),
              child: TripGridViewItemCard(
                trip: trip,
              ))
          : TripGridViewItemCard(
              trip: trip,
            ),
    );
  }
}
