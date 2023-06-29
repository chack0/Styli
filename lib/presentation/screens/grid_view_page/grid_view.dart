/// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// NOTE:
///
/// Here for pagination i've used the method loading the items page by page instead of ading automatic loading
/// at the end of the page because I strongly feel this best way to load huge number of data since google search
/// was working in the similar way to the results page by page.
///
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// FLUTTER PACKAGE IMPORTS.
import 'package:flutter/material.dart';

// FLUTTER PLUGIN IMPORTS.
import 'package:photo_view/photo_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// PROJECT IMPORTS.
import 'package:styli_test/application/image_grid/image_grid_cubit.dart';

class GirdView extends StatefulWidget {
  const GirdView({super.key});

  @override
  State<GirdView> createState() => _GirdViewState();
}

class _GirdViewState extends State<GirdView> {
  int itemsPerPage = 6; // Number of items to display per page.
  int startIndex = 0; // Start index of the list.
  int endIndex = 6; // End index of the list.

  @override
  void initState() {
    context
        .read<ImageGridCubit>()
        .fetchImages(); // Calling the even to fetch the using API.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Image Grid"),
      ),
      body: BlocBuilder<ImageGridCubit, ImageGridState>(
        builder: (context, imageGridState) {
          // Intial loading state.
          if (imageGridState is ImageGridInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (imageGridState is ImageGridLoaded) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  ///
                  ///
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            2, // Adjust the number of grid columns as needed
                      ),
                      itemCount: itemsPerPage,
                      itemBuilder: (context, index) {
                        final imageUrl = imageGridState.profileImageUrl
                            .sublist(startIndex, endIndex);
                        final images = imageUrl[index];
                        // Here gesture detector is given to identify the taps on the pictures to show the in a fullscreen page with support for pinch-zoom.
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    PhotoViewPage(image: images),
                              ),
                            );
                          },
                          // Using image.network we are displying images from the list with progress loading.
                          child: Image.network(
                            images,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  ///
                  ///
                  /// Bottom section to load more data and going back to previous page.
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(width: 15.0),
                        TextButton(
                          child: const Text('Previous'),
                          onPressed: () {
                            // Using set state here instead of any state managent tools since this is just to -
                            // demonstrate how I'm dealing with Pagination.

                            // Going back to previous page.
                            setState(() {
                              if (startIndex != 0) {
                                startIndex = startIndex - itemsPerPage;
                                endIndex = endIndex - itemsPerPage;
                              }
                            });
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          child: const Text('Load More'),
                          onPressed: () {
                            // Using set state here instead of any state managent tools since this is just to -
                            // demonstrate how I'm dealing with Pagination.

                            // Loading more items.
                            setState(() {
                              if (endIndex <
                                  imageGridState.profileImageUrl.length -
                                      itemsPerPage) {
                                if (startIndex >
                                    imageGridState.profileImageUrl.length) {
                                  final diff = startIndex -
                                      imageGridState.profileImageUrl.length;
                                  startIndex = startIndex - diff;
                                  endIndex = endIndex + itemsPerPage;
                                } else {
                                  startIndex = startIndex + itemsPerPage;
                                  endIndex = endIndex + itemsPerPage;
                                }
                              }
                            });
                          },
                        ),
                        const SizedBox(width: 15.0),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

// Widget to display images in full-screen with the support of picnh-zoom.
class PhotoViewPage extends StatelessWidget {
  final String image;
  const PhotoViewPage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("View Picture"),
        automaticallyImplyLeading: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: PhotoView(
          imageProvider: NetworkImage(image),
          initialScale: PhotoViewComputedScale.contained,
        ),
      ),
    );
  }
}
