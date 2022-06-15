import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:test_news/view/widgets/news_loader.dart';

class Gallery extends StatelessWidget {
  const Gallery({Key? key, required this.urlList}) : super(key: key);

  final List<String> urlList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(urlList[index]),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2.4,
            
          );
        },
        itemCount: urlList.length,
        loadingBuilder: (context, event) =>
            const NewsLoader(maxIconSize: 50, durationMilliseconds: 900),
        allowImplicitScrolling: true,
        backgroundDecoration:
            BoxDecoration(color: Theme.of(context).primaryColor, )    
      ),
    );
  }
}
