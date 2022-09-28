import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart' show PhotoViewComputedScale;

import 'package:locoo/logic/flutter_chat_types-3.4.5/flutter_chat_types.dart'
    as types;
import 'package:locoo/logic/models/user.dart' as models;

import '../chat_l10n.dart';
import '../chat_theme.dart';
import '../models/bubble_rtl_alignment.dart';
import '../models/date_header.dart';
import '../models/emoji_enlargement_behavior.dart';
import '../models/message_spacer.dart';
import '../models/preview_image.dart';
import '../models/preview_tap_options.dart';
import '../util.dart';
import 'chat_list.dart';
import 'image_gallery.dart';
import 'inherited_chat_theme.dart';
import 'inherited_l10n.dart';
import 'inherited_user.dart';
import 'input.dart';
import 'message.dart';
import 'text_message.dart';

/// Entry widget, represents the complete chat. If you wrap it in [SafeArea] and
/// it should be full screen, set [SafeArea]'s `bottom` to `false`.
class Chat extends StatefulWidget {
  /// Creates a chat widget.
  const Chat({
    super.key,
    this.avatarBuilder,
    this.bubbleBuilder,
    this.bubbleRtlAlignment = BubbleRtlAlignment.right,
    this.customBottomWidget,
    this.customDateHeaderText,
    this.customMessageBuilder,
    this.customStatusBuilder,
    this.dateFormat,
    this.dateHeaderBuilder,
    this.dateHeaderThreshold = 900000,
    this.dateLocale,
    this.disableImageGallery,
    this.emojiEnlargementBehavior = EmojiEnlargementBehavior.multi,
    this.emptyState,
    this.fileMessageBuilder,
    this.groupMessagesThreshold = 60000,
    this.hideBackgroundOnEmojiMessages = true,
    this.imageGalleryOptions = const ImageGalleryOptions(
      maxScale: PhotoViewComputedScale.covered,
      minScale: PhotoViewComputedScale.contained,
    ),
    this.imageMessageBuilder,
    this.inputOptions = const InputOptions(),
    this.isAttachmentUploading,
    this.isLastPage,
    this.isTextMessageTextSelectable = true,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.l10n = const ChatL10nEn(),
    required this.messages,
    this.nameBuilder,
    this.onAttachmentPressed,
    this.onAvatarTap,
    this.onBackgroundTap,
    this.onEndReached,
    this.onEndReachedThreshold,
    this.onMessageDoubleTap,
    this.onMessageLongPress,
    this.onMessageStatusLongPress,
    this.onMessageStatusTap,
    this.onMessageTap,
    this.onMessageVisibilityChanged,
    this.onPreviewDataFetched,
    required this.onSendPressed,
    this.previewTapOptions = const PreviewTapOptions(),
    this.scrollController,
    this.scrollPhysics,
    this.showUserAvatars = false,
    this.showUserNames = false,
    this.textMessageBuilder,
    this.textMessageOptions = const TextMessageOptions(),
    this.theme = const DefaultChatTheme(),
    this.timeFormat,
    this.usePreviewData = true,
    required this.user,
    this.userAgent,
  });

  /// See [Message.avatarBuilder].
  final Widget Function(String userId)? avatarBuilder;

  /// See [Message.bubbleBuilder].
  final Widget Function(
    Widget child, {
    required types.Message message,
    required bool nextMessageInGroup,
  })? bubbleBuilder;

  /// See [Message.bubbleRtlAlignment].
  final BubbleRtlAlignment? bubbleRtlAlignment;

  /// Allows you to replace the default Input widget e.g. if you want to create
  /// a channel view.
  final Widget? customBottomWidget;

  /// If [dateFormat], [dateLocale] and/or [timeFormat] is not enough to
  /// customize date headers in your case, use this to return an arbitrary
  /// string based on a [DateTime] of a particular message. Can be helpful to
  /// return "Today" if [DateTime] is today. IMPORTANT: this will replace
  /// all default date headers, so you must handle all cases yourself, like
  /// for example today, yesterday and before. Or you can just return the same
  /// date header for any message.
  final String Function(DateTime)? customDateHeaderText;

  /// See [Message.customMessageBuilder].
  final Widget Function(types.CustomMessage, {required int messageWidth})?
      customMessageBuilder;

  /// See [Message.customStatusBuilder].
  final Widget Function(types.Message message, {required BuildContext context})?
      customStatusBuilder;

  /// Allows you to customize the date format. IMPORTANT: only for the date,
  /// do not return time here. See [timeFormat] to customize the time format.
  /// [dateLocale] will be ignored if you use this, so if you want a localized date
  /// make sure you initialize your [DateFormat] with a locale. See [customDateHeaderText]
  /// for more customization.
  final DateFormat? dateFormat;

  /// Custom date header builder gives ability to customize date header widget.
  final Widget Function(DateHeader)? dateHeaderBuilder;

  /// Time (in ms) between two messages when we will render a date header.
  /// Default value is 15 minutes, 900000 ms. When time between two messages
  /// is higher than this threshold, date header will be rendered. Also,
  /// not related to this value, date header will be rendered on every new day.
  final int dateHeaderThreshold;

  /// Locale will be passed to the `Intl` package. Make sure you initialized
  /// date formatting in your app before passing any locale here, otherwise
  /// an error will be thrown. Also see [customDateHeaderText], [dateFormat], [timeFormat].
  final String? dateLocale;

  /// Disable automatic image preview on tap.
  final bool? disableImageGallery;

  /// See [Message.emojiEnlargementBehavior].
  final EmojiEnlargementBehavior emojiEnlargementBehavior;

  /// Allows you to change what the user sees when there are no messages.
  /// `emptyChatPlaceholder` and `emptyChatPlaceholderTextStyle` are ignored
  /// in this case.
  final Widget? emptyState;

  /// See [Message.fileMessageBuilder].
  final Widget Function(types.FileMessage, {required int messageWidth})?
      fileMessageBuilder;

  /// Time (in ms) between two messages when we will visually group them.
  /// Default value is 1 minute, 60000 ms. When time between two messages
  /// is lower than this threshold, they will be visually grouped.
  final int groupMessagesThreshold;

  /// See [Message.hideBackgroundOnEmojiMessages].
  final bool hideBackgroundOnEmojiMessages;

  /// See [ImageGallery.options].
  final ImageGalleryOptions imageGalleryOptions;

  /// See [Message.imageMessageBuilder].
  final Widget Function(types.ImageMessage, {required int messageWidth})?
      imageMessageBuilder;

  /// See [Input.options].
  final InputOptions inputOptions;

  /// See [Input.isAttachmentUploading].
  final bool? isAttachmentUploading;

  /// See [ChatList.isLastPage].
  final bool? isLastPage;

  /// See [Message.isTextMessageTextSelectable].
  final bool isTextMessageTextSelectable;

  /// See [ChatList.keyboardDismissBehavior].
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// Localized copy. Extend [ChatL10n] class to create your own copy or use
  /// existing one, like the default [ChatL10nEn]. You can customize only
  /// certain properties, see more here [ChatL10nEn].
  final ChatL10n l10n;

  /// List of [types.Message] to render in the chat widget.
  final List<types.Message> messages;

  /// See [Message.nameBuilder].
  final Widget Function(String userId)? nameBuilder;

  /// See [Input.onAttachmentPressed].
  final VoidCallback? onAttachmentPressed;

  /// See [Message.onAvatarTap].
  final void Function(models.User)? onAvatarTap;

  /// Called when user taps on background.
  final VoidCallback? onBackgroundTap;

  /// See [ChatList.onEndReached].
  final Future<void> Function()? onEndReached;

  /// See [ChatList.onEndReachedThreshold].
  final double? onEndReachedThreshold;

  /// See [Message.onMessageDoubleTap].
  final void Function(BuildContext context, types.Message)? onMessageDoubleTap;

  /// See [Message.onMessageLongPress].
  final void Function(BuildContext context, types.Message)? onMessageLongPress;

  /// See [Message.onMessageStatusLongPress].
  final void Function(BuildContext context, types.Message)?
      onMessageStatusLongPress;

  /// See [Message.onMessageStatusTap].
  final void Function(BuildContext context, types.Message)? onMessageStatusTap;

  /// See [Message.onMessageTap].
  final void Function(BuildContext context, types.Message)? onMessageTap;

  /// See [Message.onMessageVisibilityChanged].
  final void Function(types.Message, bool visible)? onMessageVisibilityChanged;

  /// See [Message.onPreviewDataFetched].
  final void Function(types.TextMessage, types.PreviewData)?
      onPreviewDataFetched;

  /// See [Input.onSendPressed].
  final void Function(types.PartialText) onSendPressed;

  /// See [Message.previewTapOptions].
  final PreviewTapOptions previewTapOptions;

  /// See [ChatList.scrollController].
  final ScrollController? scrollController;

  /// See [ChatList.scrollPhysics].
  final ScrollPhysics? scrollPhysics;

  /// See [Message.showUserAvatars].
  final bool showUserAvatars;

  /// Show user names for received messages. Useful for a group chat. Will be
  /// shown only on text messages.
  final bool showUserNames;

  /// See [Message.textMessageBuilder].
  final Widget Function(
    types.TextMessage, {
    required int messageWidth,
    required bool showName,
  })? textMessageBuilder;

  /// See [Message.textMessageOptions].
  final TextMessageOptions textMessageOptions;

  /// Chat theme. Extend [ChatTheme] class to create your own theme or use
  /// existing one, like the [DefaultChatTheme]. You can customize only certain
  /// properties, see more here [DefaultChatTheme].
  final ChatTheme theme;

  /// Allows you to customize the time format. IMPORTANT: only for the time,
  /// do not return date here. See [dateFormat] to customize the date format.
  /// [dateLocale] will be ignored if you use this, so if you want a localized time
  /// make sure you initialize your [DateFormat] with a locale. See [customDateHeaderText]
  /// for more customization.
  final DateFormat? timeFormat;

  /// See [Message.usePreviewData].
  final bool usePreviewData;

  /// See [InheritedUser.user].
  final models.User user;

  /// See [Message.userAgent].
  final String? userAgent;

  @override
  State<Chat> createState() => _ChatState();
}

/// [Chat] widget state.
class _ChatState extends State<Chat> {
  List<Object> _chatMessages = [];
  List<PreviewImage> _gallery = [];
  PageController? _galleryPageController;
  bool _isImageViewVisible = false;

  @override
  void initState() {
    super.initState();

    didUpdateWidget(widget);
  }

  @override
  void didUpdateWidget(covariant Chat oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.messages.isNotEmpty) {
      final result = calculateChatMessages(
        widget.messages,
        widget.user,
        customDateHeaderText: widget.customDateHeaderText,
        dateFormat: widget.dateFormat,
        dateHeaderThreshold: widget.dateHeaderThreshold,
        dateLocale: widget.dateLocale,
        groupMessagesThreshold: widget.groupMessagesThreshold,
        showUserNames: widget.showUserNames,
        timeFormat: widget.timeFormat,
      );

      _chatMessages = result[0] as List<Object>;
      _gallery = result[1] as List<PreviewImage>;
    }
  }

  @override
  void dispose() {
    _galleryPageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => InheritedUser(
        user: widget.user,
        child: InheritedChatTheme(
          theme: widget.theme,
          child: InheritedL10n(
            l10n: widget.l10n,
            child: Stack(
              children: [
                Container(
                  color: //color f9f8fd
                      Theme.of(context).colorScheme.background,
                  // Color(0xffF9F8FD),
                  // Theme.of(context).backgroundColor,
                  child: Column(
                    children: [
                      Flexible(
                        child: widget.messages.isEmpty
                            ? SizedBox.expand(
                                child: _emptyStateBuilder(),
                              )
                            : GestureDetector(
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  widget.onBackgroundTap?.call();
                                },
                                child: LayoutBuilder(
                                  builder: (
                                    BuildContext context,
                                    BoxConstraints constraints,
                                  ) =>
                                      ChatList(
                                    isLastPage: widget.isLastPage,
                                    itemBuilder: (item, index) =>
                                        _messageBuilder(item, constraints),
                                    items: _chatMessages,
                                    keyboardDismissBehavior:
                                        widget.keyboardDismissBehavior,
                                    onEndReached: widget.onEndReached,
                                    onEndReachedThreshold:
                                        widget.onEndReachedThreshold,
                                    scrollController: widget.scrollController,
                                    scrollPhysics: widget.scrollPhysics,
                                  ),
                                ),
                              ),
                      ),
                      widget.customBottomWidget ??
                          Input(
                            isAttachmentUploading: widget.isAttachmentUploading,
                            onAttachmentPressed: widget.onAttachmentPressed,
                            onSendPressed: widget.onSendPressed,
                            options: widget.inputOptions,
                          ),
                    ],
                  ),
                ),
                if (_isImageViewVisible)
                  ImageGallery(
                    images: _gallery,
                    pageController: _galleryPageController!,
                    onClosePressed: _onCloseGalleryPressed,
                    options: widget.imageGalleryOptions,
                  ),
              ],
            ),
          ),
        ),
      );

  Widget _emptyStateBuilder() =>
      widget.emptyState ??
      Column(
        // show a 180 grad rotation icon

        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Schreibe deine erste Nachricht',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.25),
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          RotationTransition(
            turns: new AlwaysStoppedAnimation(215 / 360),
            child: Icon(
              Icons.straight_outlined,
              size: 40,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
            ),
          ),
          SizedBox(height: 16),
        ],
      );

  Widget _messageBuilder(Object object, BoxConstraints constraints) {
    if (object is DateHeader) {
      if (widget.dateHeaderBuilder != null) {
        return widget.dateHeaderBuilder!(object);
      } else {
        return Container(
          alignment: Alignment.center,
          margin: widget.theme.dateDividerMargin,
          child: Text(
            object.text,
            // Date message send
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
            // style: widget.theme.dateDividerTextStyle,
          ),
        );
      }
    } else if (object is MessageSpacer) {
      return SizedBox(
        height: object.height,
      );
    } else {
      final map = object as Map<String, Object>;
      final message = map['message']! as types.Message;
      final messageWidth =
          widget.showUserAvatars && message.author.id != widget.user.id
              ? min(constraints.maxWidth * 0.72, 440).floor()
              : min(constraints.maxWidth * 0.78, 440).floor();

      return Message(
        key: ValueKey(message.id),
        avatarBuilder: widget.avatarBuilder,
        bubbleBuilder: widget.bubbleBuilder,
        bubbleRtlAlignment: widget.bubbleRtlAlignment,
        customMessageBuilder: widget.customMessageBuilder,
        customStatusBuilder: widget.customStatusBuilder,
        emojiEnlargementBehavior: widget.emojiEnlargementBehavior,
        fileMessageBuilder: widget.fileMessageBuilder,
        hideBackgroundOnEmojiMessages: widget.hideBackgroundOnEmojiMessages,
        imageMessageBuilder: widget.imageMessageBuilder,
        isTextMessageTextSelectable: widget.isTextMessageTextSelectable,
        message: message,
        messageWidth: messageWidth,
        nameBuilder: widget.nameBuilder,
        onAvatarTap: widget.onAvatarTap,
        onMessageDoubleTap: widget.onMessageDoubleTap,
        onMessageLongPress: widget.onMessageLongPress,
        onMessageStatusLongPress: widget.onMessageStatusLongPress,
        onMessageStatusTap: widget.onMessageStatusTap,
        onMessageTap: (context, tappedMessage) {
          if (tappedMessage is types.ImageMessage &&
              widget.disableImageGallery != true) {
            _onImagePressed(tappedMessage);
          }

          widget.onMessageTap?.call(context, tappedMessage);
        },
        onMessageVisibilityChanged: widget.onMessageVisibilityChanged,
        onPreviewDataFetched: _onPreviewDataFetched,
        previewTapOptions: widget.previewTapOptions,
        roundBorder: map['nextMessageInGroup'] == true,
        showAvatar: map['nextMessageInGroup'] == false,
        showName: map['showName'] == true,
        showStatus: map['showStatus'] == true,
        showUserAvatars: widget.showUserAvatars,
        textMessageBuilder: widget.textMessageBuilder,
        textMessageOptions: widget.textMessageOptions,
        usePreviewData: widget.usePreviewData,
        userAgent: widget.userAgent,
      );
    }
  }

  void _onCloseGalleryPressed() {
    setState(() {
      _isImageViewVisible = false;
    });
    _galleryPageController?.dispose();
    _galleryPageController = null;
  }

  void _onImagePressed(types.ImageMessage message) {
    final initialPage = _gallery.indexWhere(
      (element) => element.id == message.id && element.uri == message.uri,
    );
    _galleryPageController = PageController(initialPage: initialPage);
    setState(() {
      _isImageViewVisible = true;
    });
  }

  void _onPreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    widget.onPreviewDataFetched?.call(message, previewData);
  }
}
