import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newwave_mobile_test/common/app_styles.dart';
import 'package:newwave_mobile_test/controllers/highlight_text_controller.dart';
import 'package:newwave_mobile_test/controllers/providers.dart';
import 'package:newwave_mobile_test/models/location.dart';

import 'package:newwave_mobile_test/views/components/custom_text_field.dart';

class AddressSearchScreen extends ConsumerStatefulWidget {
  const AddressSearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddressSearchScreenState();
}

class _AddressSearchScreenState extends ConsumerState<AddressSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Location> locations = [];
  bool isLoading = false;
  String searchQuery = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) async {
    setState(() {
      searchQuery = value;
      isLoading = value.isNotEmpty;
    });

    if (value.isNotEmpty) {
      final results = await ref
          .read(locationServiceProvider)
          .searchLocations(value);

      if (mounted) {
        setState(() {
          locations = results;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        locations = [];
        isLoading = false;
      });
    }
  }

  Future<void> _openLocation(Location location) async {
    await ref.read(mapServiceProvider).openInGoogleMaps(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.colorPrimary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0).copyWith(bottom: 10),
              child: CustomTextField(
                controller: _controller,
                onSearchChanged: _onSearchChanged,
                isLoading: isLoading,
              ),
            ),
            if (searchQuery.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    final location = locations[index];
                    final locationName = location.display_name ?? '';
                    return _buildLocationTile(
                      locationName,
                      searchQuery,
                      () => _openLocation(location),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationTile(
    String locationName,
    String searchQuery,
    VoidCallback onTap,
  ) {
    // Build rich text with highlighted search term
    final TextSpan textSpan = HighlightTextController.buildHighlightedText(
      locationName,
      searchQuery,
    );

    return ListTile(
      leading: const Icon(Icons.location_on),
      title: RichText(text: textSpan),
      trailing: IconButton(
        icon: const Icon(Icons.arrow_forward_ios),
        onPressed: onTap,
      ),
    );
  }
}
