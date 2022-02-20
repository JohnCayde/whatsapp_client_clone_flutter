import 'package:flutter/material.dart';

enum OptionValues { share, edit, addressBook, securitycode }

class RoomDetails extends StatefulWidget {
  const RoomDetails({Key? key}) : super(key: key);

  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TransitionAppBar(
            extent: 300,
            avatar: ClipOval(
              child: Image.asset(
                'assets/images/avatar.png',
                height: 200,
              ),
            ),
            title: "",
          ),
          // SliverAppBar(
          //   expandedHeight: 330.0,
          //   pinned: true,
          //   flexibleSpace: FlexibleSpaceBar(
          //     centerTitle: true,
          //     title: Column(
          //       children: [
          //         ClipOval(
          //           child: Image.asset(
          //             'assets/images/avatar.png',
          //             height: 200,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   actions: [
          //     PopupMenuButton<OptionValues>(
          //       onSelected: (OptionValues option) {
          //         switch (option) {
          //           case OptionValues.share:
          //             break;
          //           default:
          //             Navigator.of(context).pushNamed("/error");
          //           // print(option);
          //         }
          //       },
          //       itemBuilder: (BuildContext context) =>
          //           const <PopupMenuEntry<OptionValues>>[
          //         PopupMenuItem<OptionValues>(
          //           value: OptionValues.share,
          //           child: Text("Share"),
          //         ),
          //         PopupMenuItem<OptionValues>(
          //           value: OptionValues.edit,
          //           child: Text("Edit"),
          //         ),
          //         PopupMenuItem<OptionValues>(
          //           value: OptionValues.addressBook,
          //           child: Text("View in address book"),
          //         ),
          //         PopupMenuItem<OptionValues>(
          //           value: OptionValues.securitycode,
          //           child: Text("Verify security code"),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Column(
                children: [
                  Column(
                    children: [
                      const Text(
                        'Soo Guan',
                        textScaleFactor: 2,
                      ),
                      const Text(
                        '0123456789',
                        textScaleFactor: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Column(
                              children: const [
                                Icon(Icons.phone),
                                Text("Audio")
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Column(
                              children: const [
                                Icon(Icons.videocam),
                                Text("Video")
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        'Hey there! I am using WhatsApp.',
                        textScaleFactor: 1,
                      ),
                    ],
                  ),
                ],
              );
            }, childCount: 10),
          ),
        ],
      ),
    );
  }
}

class TransitionAppBar extends StatelessWidget {
  final Widget avatar;
  final String title;
  final double extent;

  const TransitionAppBar(
      {required this.avatar, required this.title, this.extent = 250, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
          avatar: avatar, title: title, extent: extent > 200 ? extent : 200),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _avatarMarginTween = EdgeInsetsTween(
    end: const EdgeInsets.only(left: 14.0, top: 36.0),
  );

  final _titleMarginTween = EdgeInsetsTween(
    begin: const EdgeInsets.only(bottom: 20),
    end: const EdgeInsets.only(left: 64.0, top: 45.0),
  );

  final _avatarAlignTween =
      AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.topLeft);
  final _iconAlignTween =
      AlignmentTween(begin: Alignment.bottomRight, end: Alignment.topRight);

  final Widget? avatar;
  final String? title;
  final double? extent;

  _TransitionAppBarDelegate({this.avatar, this.title, this.extent = 250})
      : assert(avatar != null),
        assert(extent == null || extent >= 200),
        assert(title != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 72 * maxExtent / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;
    final avatarMargin = _avatarMarginTween.lerp(progress);
    final titleMargin = _titleMarginTween.lerp(progress);

    final avatarAlign = _avatarAlignTween.lerp(progress);
    final iconAlign = _iconAlignTween.lerp(progress);

    final avatarSize = (1 - progress) * 200 + 32;

    return Stack(
      children: <Widget>[
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: 80,
          constraints: BoxConstraints(maxHeight: minExtent),
          color: Colors.white,
        ),
        Padding(
          padding: avatarMargin,
          child: Align(
            alignment: avatarAlign,
            child: SizedBox(
              height: avatarSize,
              width: avatarSize,
              child: avatar,
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment.bottomRight,
        //   child: Container(
        //     height: progress < 0.4 ? 100 * (1 - progress) * 1.5 : 0,
        //     decoration: BoxDecoration(
        //         gradient: LinearGradient(
        //             begin: Alignment.topCenter,
        //             end: Alignment.bottomCenter,
        //             colors: [
        //           Colors.pink.shade200.withOpacity(0.05),
        //           Colors.pink.shade400.withOpacity(0.8),
        //         ])),
        //   ),
        // ),
        Padding(
          padding: titleMargin,
          child: Align(
            alignment: avatarAlign,
            child: Text(
              title!,
              style: TextStyle(
                color: progress < 0.4 ? Colors.white : Colors.black,
                fontSize: 18 + (5 * (1 - progress)),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Padding(
          padding: titleMargin,
          child: Align(
            alignment: iconAlign,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: progress < 0.4 ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => extent!;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }
}
