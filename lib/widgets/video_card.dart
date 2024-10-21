import 'package:flutter/material.dart';
import 'package:youtube_home_page/screens/home_screen.dart';

class SingleVideoCard extends StatefulWidget {
  final YoutubeVideoModel model;
  final bool isShort;
  const SingleVideoCard({
    super.key,
    required this.model,
    this.isShort = false,
  });

  @override
  State<SingleVideoCard> createState() => _SingleVideoCardState();
}

class _SingleVideoCardState extends State<SingleVideoCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.isShort
        ? Container(
            margin: const EdgeInsets.all(5),
            height: double.infinity,
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.model.videoThumbnailPic,
                ),
              ),
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    widget.model.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ))
        : Column(
            children: [
              Stack(
                children: [
                  Image(
                    height: 300,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.model.videoThumbnailPic,
                    ),
                  ),
                  if (widget.model.hasPromotion)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Has paid promotion",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  const Positioned(
                    top: 20,
                    right: 20,
                    child: Column(
                      children: [
                        Icon(
                          Icons.volume_off,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.closed_caption,
                          size: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget.model.channelProfilePic,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.model.title,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${widget.model.channelName} . ${widget.model.views.toString()} views . ${widget.model.timeAgo}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
  }

  @override
  bool get wantKeepAlive => true;
}
