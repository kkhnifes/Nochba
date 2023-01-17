import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nochba/logic/models/LikedPost.dart';
import 'package:nochba/pages/comments/comment_page.dart';
import 'package:nochba/pages/feed/views/action_bar_more/action_bar_more_view.dart';
import 'package:nochba/pages/feed/widgets/post/action_bar_controller.dart';
import 'package:nochba/shared/ui/buttons/locoo_circle_icon_button.dart';

import 'package:nochba/logic/models/bookmark.dart';
import 'package:nochba/logic/models/post.dart';

//create a ActionBar class which have multiple round icon Buttons

class ActionBar extends GetView<ActionBarController> {
  final Post post;
  const ActionBar({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return a row with round icon buttons and a text
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder<List<String>>(
            stream: controller.getLikedPostsOfCurrentUser(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final likedPosts = snapshot.data!;
                if (likedPosts.contains(post.id)) {
                  return LocooCircleIconButton(
                      icon: Icons.thumb_up,
                      isPressed: true,
                      onPressed: () async =>
                          await controller.unlikePost(post.id));
                } else {
                  return LocooCircleIconButton(
                      icon: Icons.thumb_up,
                      isPressed: false,
                      onPressed: () async =>
                          await controller.likePost(post.id));
                }
              } else {
                return LocooCircleIconButton(
                  icon: Icons.thumb_up,
                  // isPressed: true,
                  // color: Colors.grey,
                  onPressed: () {},
                );
              }
            }),
          ),
          StreamBuilder<int?>(
            stream: controller.getLikesOfPost(post.id),
            builder: (context, snapshot) {
              int? data;
              if (snapshot.hasData) {
                data = snapshot.data;
              }

              return Padding(
                padding: EdgeInsets.only(left: 8, right: 18),
                child: Text(
                  data != null ? '${data}' : '-',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),

          // return a round icon button with a icon of Icons.favorite and a color of Colors.red
          LocooCircleIconButton(
            icon: Icons.forum,
            onPressed: () {
              Get.to(CommentPage(postId: post.id));
            },
          ),
          FutureBuilder<int>(
            future: controller.getCommentCountOfPost(post.id),
            builder: (context, snapshot) {
              int? data;
              if (snapshot.hasData) {
                data = snapshot.data;
              }

              return Padding(
                padding: EdgeInsets.only(left: 8, right: 18),
                child: Text(
                  data != null ? '${data}' : '-',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
          // return a round icon button with a icon of Icons.favorite and a color of Colors.red
          StreamBuilder<BookMark?>(
            stream: controller.getBookMarkOfCurrentUser(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final bookMark = snapshot.data!;
                if (bookMark.posts.contains(post.id)) {
                  return LocooCircleIconButton(
                      icon: Icons.bookmark,
                      isPressed: true,
                      // color: Theme.of(context).colorScheme.primary,
                      onPressed: () async =>
                          await controller.unsavePost(bookMark, post.id));
                } else {
                  return LocooCircleIconButton(
                      icon: Icons.bookmark,
                      isPressed: false,
                      onPressed: () async =>
                          await controller.savePost(bookMark, post.id));
                }
              } else {
                return LocooCircleIconButton(
                  icon: Icons.bookmark,
                  // isPressed: true,
                  // color: Colors.grey,
                  onPressed: () {},
                );
              }
            }),
          ),

          Spacer(),
          LocooCircleIconButton(
            icon: Icons.more_horiz,
            onPressed: () {
              showModalBottomSheet<dynamic>(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0))),
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return
                      // height of the modal bottom sheet
                      ActionBarMore(
                    controller: controller,
                    post: post,
                  );
                },
              );
            },
          ),

          // add a row with aliged left with a RoundIconButton

          // return a round icon button with a icon of Icons.favorite and a color of Colors.red
        ],
      ),
    );
  }
}

//create a round container which changes color when pressed and when its pressed again it changes back to its original color

