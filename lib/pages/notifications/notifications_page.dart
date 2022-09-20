import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:locoo/logic/data_access.dart';
import 'package:locoo/logic/flutter_chat_types-3.4.5/src/user.dart' as types;
import 'package:locoo/logic/flutter_firebase_chat_core-1.6.3/src/firebase_chat_core.dart';
import 'package:locoo/pages/chats/chat.dart';
import 'package:locoo/pages/notifications/notifications_controller.dart';
import 'package:locoo/shared/ui/buttons/locoo_circular_icon_button.dart';
import 'package:locoo/shared/ui/buttons/locoo_text_button.dart';
import 'package:locoo/shared/ui/locoo_text_field.dart';
import 'package:locoo/shared/ui/pretty_textfield.dart';
import 'package:locoo/logic/models/user.dart' as models;
import 'package:locoo/logic/models/Notification.dart' as models;
import 'package:get/get.dart' as getx;
import 'package:locoo/shared/views/app_bar_big_view.dart';

class NotificationsPage extends GetView<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    final dataAccess = Get.find<DataAccess>();
    return AppBarBigView(
      title: 'Benachrichtigungen',
      showBackButton: false,
      actions: [
        IconButton(
          splashRadius: 0.01,
          icon: Icon(
            FlutterRemix.pencil_line,
            size: 24,
            color: Theme.of(context).buttonTheme.colorScheme?.primary,
          ),
          onPressed: () {
            Get.snackbar('dd', 'message');
          },
          padding: EdgeInsets.only(right: 3, left: 0, top: 3, bottom: 0),
          alignment: Alignment.centerRight,
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            StreamBuilder<List<models.Notification>>(
              stream: dataAccess.getNotifications(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                      'Something went wrong: ${snapshot.error.toString()}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w300));
                } else if (snapshot.hasData) {
                  final notifications = snapshot.data!;

                  if (notifications.isEmpty) {
                    return Center(
                      child: Column(
                        //center
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          // add a forum icon
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),

                          Icon(
                            FlutterRemix.notification_2_line,
                            size: 100,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.1),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Du hast aktuell keine Benachrichtigungen',
                            //align center
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.15),
                                ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: notifications.length,
                    itemBuilder: (BuildContext context, int index) {
                      final notification = notifications.elementAt(index);

                      return NotificationElement(notification: notification);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 3),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                  // return const Text('There are no posts in the moment',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300));
                }
              },
            ),
          ],
        ),
      ],
    );
//     return CupertinoPageScaffold(
//       backgroundColor: Theme.of(context).backgroundColor,
//       // A ScrollView that creates custom scroll effects using slivers.
//       child: CupertinoTheme(
//         data: CupertinoThemeData(
//           textTheme: CupertinoTextThemeData(
//             navTitleTextStyle:
//                 Theme.of(context).textTheme.headlineSmall?.copyWith(
//                       // fontFamily: 'Inter',
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       // letterSpacing: -0.5,
//                       color: Theme.of(context).colorScheme.onSecondaryContainer,
//                     ),
//             navLargeTitleTextStyle:
//                 Theme.of(context).textTheme.headlineMedium?.copyWith(
//                       // fontFamily: 'Inter',
//                       fontSize: 30,
//                       fontWeight: FontWeight.w800,
//                       letterSpacing: -0.5,
//                       color: Theme.of(context).colorScheme.onSecondaryContainer,
//                     ),
//           ),
//           // barBackgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//           barBackgroundColor: Theme.of(context).backgroundColor,
//         ),
//         child: CustomScrollView(
//           // A list of sliver widgets.
//           slivers: <Widget>[
//             CupertinoSliverNavigationBar(
//               // padding: EdgeInsetsDirectional.only(
//               //   start: 7,
//               //   end: 23,
//               // ),

//               // leading: Icon(CupertinoIcons.person_2),
//               // This title is visible in both collapsed and expanded states.
//               // When the "middle" parameter is omitted, the widget provided
//               // in the "largeTitle" parameter is used instead in the collapsed state.
//               largeTitle: Text(
//                 'Benachrichtigungen',
//               ),

//               trailing: Container(
//                   transform: Matrix4.translationValues(14, 0, 0),
//                   child: IconButton(
//                     // alignment: Alignment.topRight,
//                     icon: Icon(
//                       FlutterRemix.menu_line,
//                       size: 24,
//                       color: Theme.of(context).colorScheme.onSecondaryContainer,
//                     ),
//                     onPressed: () {
//                       Get.snackbar('title', 'message');
//                     },
//                   )),
//               border: //make the border transparent
//                   const Border(bottom: BorderSide(color: Colors.transparent)),
//             ),
//             // This widget fills the remaining space in the viewport.
//             // Drag the scrollable area to collapse the CupertinoSliverNavigationBar.
//             SliverFillRemaining(
//               child:
//             ),
//           ],
//         ),
//       ),
//     );
  }
}

class NotificationElement extends StatelessWidget {
  const NotificationElement({Key? key, required this.notification})
      : super(key: key);
  final models.Notification notification;

  @override
  Widget build(BuildContext context) {
    final dataAccess = Get.find<DataAccess>();
    return FutureBuilder<types.User?>(
      future: FirebaseChatCore.instance.user(notification.fromUser),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          final otherUser = snapshot.data!;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            child: Column(
              children: [
                Text(
                    '${otherUser.firstName} ${otherUser.lastName} would like to get in touch with you.'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.thumb_up),
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        final room = await FirebaseChatCore.instance
                            .createRoom(otherUser);

                        /*await navigator.push(
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    room: room,
                                  ),
                                ),
                              );*/
                        await getx.Get.to(() => ChatPage(room: room));

                        await dataAccess.deleteNotification(notification.id);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.thumb_down),
                      onPressed: () async {
                        await dataAccess.deleteNotification(notification.id);
                      },
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
