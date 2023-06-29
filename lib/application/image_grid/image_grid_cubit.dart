import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'image_grid_state.dart';

class ImageGridCubit extends Cubit<ImageGridState> {
  ImageGridCubit() : super(ImageGridInitial());
  Future<void> fetchImages() async {
    // Loading state.
    emit(ImageGridInitial());
    try {
      final response =
          await http.get(Uri.parse('https://picsum.photos/v2/list'));
      // Directly fetching the data and storing it to list.
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        final imageUrls = jsonData
            .map((data) => data['download_url'])
            .toList()
            .cast<String>();
        // Data loaded successfully and the state is emitted with the fetched value.
        emit(ImageGridLoaded(profileImageUrl: imageUrls));
      }
    } catch (e) {
      emit(ImageGridError());
    }
  }
}
