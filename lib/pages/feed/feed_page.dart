import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locoo/models/category.dart';
import 'package:locoo/models/data_access.dart';
import 'package:locoo/pages/feed/post/post.dart';
import 'package:locoo/models/post.dart' as models;
import 'package:locoo/models/user.dart' as models;


import '../../shared/range_slider/range_slider.dart';
import 'feed_controller.dart';

class FeedPage extends GetView<FeedController> {
  @override
  Widget build(BuildContext context) {
    final dataAccess = Get.find<DataAccess>();
    return Scaffold(
      body: Container(
        child: StreamBuilder<List<models.Post>>(
          stream: dataAccess.getPosts(),
          builder: (context, snapshot) {
            if(snapshot.hasError) {
                return Text('Something went wrong: ${snapshot.error.toString()}',
                    textAlign: TextAlign.center, 
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w300)
                  );

            } else if(snapshot.hasData) {
              final posts = snapshot.data!;
              
              return ListView.separated(
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  final post = posts.elementAt(index);

                  return FutureBuilder<models.User?>(
                    future: dataAccess.getUser(post.user),
                    builder: ((context, snapshot) {

                      if(snapshot.hasData) {
                        final user = snapshot.data!;
                        return Post(
                          post: post,
                          postAuthorName: '${user.firstName} ${user.lastName}',
                          postAuthorImage: user.imageUrl,
                        );
                      } else {
                        return Container();
                      }
                    }),
                  );
                }, 
                separatorBuilder: (BuildContext context, int index)  => const SizedBox(height: 3),
              );

            } else {
              return const Center(child: CircularProgressIndicator());
              // return const Text('There are no posts in the moment',
              //   textAlign: TextAlign.center, 
              //   style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300));
            } 
          },
        )
        
        
        
        /*ListView(
          children: const [
            Slider1(),
            Post(
              postTitle: 'Post ddddddddddddTitle',
              postImage: 'https://i.pravatar.cc/303',
              postCategory: Category.mitteilung,
              postAuthorName: 'John Doe',
              postPublishDate: '2',
              postDistance: '1',
              postDescription: 'Post Dddddescrisssption',
            ),
            SizedBox(height: 3),
            Post(
              postTitle: 'Post Title',
              postImage: 'https://i.pravatar.cc/303',
              postAuthorName: 'John Doe',
              postPublishDate: '2',
              postDistance: '1',
              postDescription:
                  'Post https://pub.dev/packages/expandable_text Dddddescrdfffffffffffffffdfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfffffffffffffffffffffffffffffffffffffffffisf dddddddddddsdffffffffffffsdfffffdddption',
            ),
            SizedBox(height: 3),
            Post(
              postTitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              postImage: 'https://i.pravatar.cc/303',
              postAuthorName: 'John Doe',
              postPublishDate: '2',
              postCategory: Category.warnung,
              postDistance: '1',
              postDescription:
                  'Post https://pub.dev/packages/expandable_text Dddddescrdfffffffffffffffdfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfffffffffffffffffffffffffffffffffffffffffisf dddddddddddsdffffffffffffsdfffffdddption',
            ),
          ],
        ),*/
      ),
    );
  }
}
