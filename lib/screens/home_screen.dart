import 'package:flutter/material.dart';
import 'package:youtube_home_page/widgets/app_bar.dart';
import 'package:youtube_home_page/widgets/video_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentlyselectedCategory = "All";

  List<YoutubeVideoModel> sortedList1 = [];
  List<YoutubeVideoModel> sortedList2 = [];
  List<YoutubeVideoModel> sortedShorts = [];

  @override
  Widget build(BuildContext context) {
    sortedList2 = [];
    sortedList1 = [];
    sortedShorts = [];

    for (var video in videos1) {
      if (currentlyselectedCategory == "All") {
        sortedList1.add(video);
      } else {
        if (video.category == currentlyselectedCategory) {
          sortedList1.add(video);
        }
      }
    }

    for (var video in filterableShorts) {
      if (currentlyselectedCategory == "All") {
        sortedShorts.add(video);
      } else {
        if (video.category == currentlyselectedCategory) {
          sortedShorts.add(video);
        }
      }
    }

    for (var video in videos2) {
      if (currentlyselectedCategory == "All") {
        sortedList2.add(video);
      } else {
        if (video.category == currentlyselectedCategory) {
          sortedList2.add(video);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Image(
          height: 25,
          image: AssetImage(
            "assets/${Theme.of(context).brightness == Brightness.dark ? "logo_dark" : "logo_light"}.png",
          ),
        ),
        actions: const [
          HomePageAppBarIcon(
            icon: Icons.cast,
          ),
          HomePageAppBarIcon(
            icon: Icons.notifications,
            number: 4,
          ),
          HomePageAppBarIcon(
            icon: Icons.search,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            color: Theme.of(context).canvasColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  singleCategory("All"),
                  singleCategory("Music"),
                  singleCategory("AI"),
                  singleCategory("Gaming"),
                  singleCategory("Comic Books"),
                  singleCategory("Education"),
                  singleCategory("Science & Technology"),
                  singleCategory("Cooking & Food"),
                  singleCategory("Travel & Adventure"),
                  singleCategory("Fitness & Health"),
                  singleCategory("DIY & Crafts"),
                  singleCategory("News & Politics"),
                  singleCategory("Movies & Shows"),
                  singleCategory("Animation"),
                  singleCategory("Beauty & Makeup"),
                  singleCategory("Tech Reviews"),
                  singleCategory("Comedy"),
                  singleCategory("Sports"),
                  singleCategory("Pets & Animals"),
                  singleCategory("Automotive"),
                  singleCategory("Art & Design"),
                  singleCategory("Lifestyle"),
                  singleCategory("Motivation & Self-help"),
                  singleCategory("Gardening"),
                ],
              ),
            ),
          ),
          Expanded(
              child: CustomScrollView(
            slivers: [
              SliverGrid(
                delegate: SliverChildListDelegate(
                  sortedShorts.map((e) {
                    return SingleVideoCard(
                      model: e,
                      isShort: true,
                    );
                  }).toList(),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      1 / (300 / (MediaQuery.of(context).size.width / 2)),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return SingleVideoCard(
                      model: sortedList1[index],
                    );
                  },
                  childCount: sortedList1.length,
                ),
              ),
              SliverGrid(
                delegate: SliverChildListDelegate(
                  shorts.map((e) {
                    return SingleVideoCard(
                      model: e,
                      isShort: true,
                    );
                  }).toList(),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      1 / (300 / (MediaQuery.of(context).size.width / 2)),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return SingleVideoCard(
                      model: sortedList2[index],
                    );
                  },
                  childCount: sortedList2.length,
                ),
              ),
            ],
          )
              ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: "Shorts",
            icon: Icon(
              Icons.short_text,
            ),
          ),
          BottomNavigationBarItem(
            label: "Add",
            icon: Icon(
              Icons.add_circle_outline,
            ),
          ),
          BottomNavigationBarItem(
            label: "Subscriptions",
            icon: Icon(
              Icons.subscriptions,
            ),
          ),
          BottomNavigationBarItem(
            label: "You",
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
    );
  }

  singleCategory(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentlyselectedCategory = category;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 15,
          bottom: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).brightness == Brightness.dark
              ? currentlyselectedCategory == category
                  ? Colors.white
                  : const Color.fromARGB(255, 37, 36, 36)
              : currentlyselectedCategory == category
                  ? Colors.black
                  : Colors.grey.withOpacity(0.3),
        ),
        child: Text(
          category,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).brightness == Brightness.dark
                ? currentlyselectedCategory == category
                    ? Colors.black
                    : Colors.white
                : currentlyselectedCategory == category
                    ? Colors.white
                    : Colors.black,
          ),
        ),
      ),
    );
  }
}

class YoutubeVideoModel {
  String title;
  String channelName;
  int views;
  String timeAgo;
  String channelProfilePic;
  String videoThumbnailPic;
  String minuteCount;
  bool hasPromotion;
  String category;
  bool muted;
  bool hasCC;
  bool isShort;

  YoutubeVideoModel({
    required this.title,
    required this.channelName,
    required this.views,
    required this.timeAgo,
    required this.channelProfilePic,
    required this.videoThumbnailPic,
    required this.minuteCount,
    required this.category,
    required this.hasPromotion,
    required this.muted,
    required this.hasCC,
    required this.isShort,
  });
}

//For these ones (the sorts), only update the video thumbnail pic
final List<YoutubeVideoModel> filterableShorts = [
  // Music
  YoutubeVideoModel(
    title: "Top 10 Pop Hits of 2023",
    channelName: "MusicCharts",
    views: 2500000,
    timeAgo: "2 days ago",
    channelProfilePic: "assets/channel_pics/music_charts.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2024/02/27/02/06/ai-generated-8599226_1280.jpg",
    minuteCount: "15:30",
    category: "Music",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Classical Music for Studying",
    channelName: "StudyTunes",
    views: 1800000,
    timeAgo: "1 week ago",
    channelProfilePic: "assets/channel_pics/study_tunes.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2017/08/06/00/27/yoga-2587066_640.jpg",
    minuteCount: "3:00:00",
    category: "Music",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "History of Rock Music in 20 Minutes",
    channelName: "RockLegends",
    views: 950000,
    timeAgo: "3 days ago",
    channelProfilePic: "assets/channel_pics/rock_legends.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2024/03/06/01/31/pop-art-8615565_1280.jpg",
    minuteCount: "20:15",
    category: "Music",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Learn Guitar: Beginner's Guide",
    channelName: "GuitarMaster",
    views: 750000,
    timeAgo: "2 weeks ago",
    channelProfilePic: "assets/channel_pics/guitar_master.jpg",
    videoThumbnailPic: "https://media.istockphoto.com/id/1432024186/photo/pretty-girl-playing-guitar-sitting-on-floor.jpg?s=612x612&w=0&k=20&c=cz_vGevyB_4IVbkjVJrGM57sZuU0JS4cirkB4HcfPG4=",
    minuteCount: "25:45",
    category: "Music",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),

  // AI
  YoutubeVideoModel(
    title: "AI Revolution: What You Need to Know",
    channelName: "TechInsider",
    views: 3000000,
    timeAgo: "4 days ago",
    channelProfilePic: "assets/channel_pics/tech_insider.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2024/06/01/14/00/ai-8802304_1280.jpg",
    minuteCount: "18:20",
    category: "AI",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Machine Learning for Beginners",
    channelName: "AIAcademy",
    views: 1200000,
    timeAgo: "1 week ago",
    channelProfilePic: "assets/channel_pics/ai_academy.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2015/12/03/02/21/child-1073638_1280.jpg",
    minuteCount: "30:00",
    category: "AI",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Ethics in Artificial Intelligence",
    channelName: "AIEthics",
    views: 800000,
    timeAgo: "5 days ago",
    channelProfilePic: "assets/channel_pics/ai_ethics.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2024/06/18/15/26/ai-generated-8838283_1280.jpg",
    minuteCount: "22:30",
    category: "AI",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "AI in Healthcare: Revolutionizing Medicine",
    channelName: "MedTech",
    views: 1500000,
    timeAgo: "2 weeks ago",
    channelProfilePic: "assets/channel_pics/med_tech.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2014/12/10/20/48/laboratory-563423_1280.jpg",
    minuteCount: "25:15",
    category: "AI",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),

  // Gaming
  YoutubeVideoModel(
    title: "Top 10 Games of 2023",
    channelName: "GameReviewer",
    views: 2800000,
    timeAgo: "3 days ago",
    channelProfilePic: "assets/channel_pics/game_reviewer.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2016/03/27/20/57/people-1284253_1280.jpg",
    minuteCount: "20:45",
    category: "Gaming",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Minecraft: Building a Mega City",
    channelName: "MinecraftMaster",
    views: 1600000,
    timeAgo: "1 week ago",
    channelProfilePic: "assets/channel_pics/minecraft_master.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2016/08/24/21/42/minecraft-1618142_1280.jpg",
    minuteCount: "45:00",
    category: "Gaming",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Speedrun World Record: Super Mario 64",
    channelName: "SpeedrunnerPro",
    views: 900000,
    timeAgo: "2 days ago",
    channelProfilePic: "assets/channel_pics/speedrunner_pro.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2016/07/30/14/25/mario-1557240_1280.jpg",
    minuteCount: "1:39:20",
    category: "Gaming",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Fortnite: Pro Tips and Tricks",
    channelName: "FortniteGuru",
    views: 2000000,
    timeAgo: "5 days ago",
    channelProfilePic: "assets/channel_pics/fortnite_guru.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2023/10/30/15/02/ai-generated-8353081_1280.jpg",
    minuteCount: "15:30",
    category: "Gaming",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),

  // Comic Books
  YoutubeVideoModel(
    title: "Marvel vs DC: The Ultimate Showdown",
    channelName: "ComicBookDebate",
    views: 1800000,
    timeAgo: "1 week ago",
    channelProfilePic: "assets/channel_pics/comic_book_debate.jpg",
    videoThumbnailPic: "https://media.istockphoto.com/id/2167466349/photo/shocked-young-professional-getting-amazing-news-working-on-laptop-at-home-office.jpg?s=612x612&w=0&k=20&c=OeVjOEqw_KPgB_COmD62AYcKovRbExstYJHLRse2iNM=",
    minuteCount: "25:00",
    category: "Comic Books",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Top 10 Graphic Novels of All Time",
    channelName: "GraphicNovelGuru",
    views: 750000,
    timeAgo: "3 days ago",
    channelProfilePic: "assets/channel_pics/graphic_novel_guru.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2018/09/21/08/54/book-3692572_1280.jpg",
    minuteCount: "18:45",
    category: "Comic Books",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "The History of Superman",
    channelName: "ComicLore",
    views: 1200000,
    timeAgo: "2 weeks ago",
    channelProfilePic: "assets/channel_pics/comic_lore.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2022/06/18/06/54/superman-7269293_1280.jpg",
    minuteCount: "30:15",
    category: "Comic Books",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Creating Your Own Comic Book: A Guide",
    channelName: "ComicArtist101",
    views: 500000,
    timeAgo: "4 days ago",
    channelProfilePic: "assets/channel_pics/comic_artist_101.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2020/04/08/08/08/spring-5016266_1280.jpg",
    minuteCount: "22:30",
    category: "Comic Books",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),

  // ... Continue with 4 items for each of the remaining categories ...
];

final List<YoutubeVideoModel> shorts = [
  YoutubeVideoModel(
    title: "The Evolution of Artificial Intelligence",
    channelName: "FutureTech",
    views: 2300000,
    timeAgo: "3 days ago",
    channelProfilePic: "assets/channel_pics/future_tech.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2017/02/11/14/45/taipei-taiwan-2057818_1280.jpg",
    minuteCount: "18:45",
    category: "AI",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Beginner's Guide to Minecraft",
    channelName: "GameOn",
    views: 1800000,
    timeAgo: "1 week ago",
    channelProfilePic: "assets/channel_pics/game_on.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2016/07/05/18/26/frog-1499162_1280.jpgg",
    minuteCount: "22:30",
    category: "Gaming",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Easy 15-Minute Workout at Home",
    channelName: "FitnessFun",
    views: 950000,
    timeAgo: "5 days ago",
    channelProfilePic: "assets/channel_pics/fitness_fun.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2024/05/30/05/54/nature-8797824_1280.png",
    minuteCount: "15:10",
    category: "Fitness & Health",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: true,
  )

 
];


//For these ones (The videos), update both video thumbnail and channel pic
final List<YoutubeVideoModel> videos1 = [
  YoutubeVideoModel(
    title: "Top 10 Pop Hits of 2023",
    channelName: "MusicTrends",
    views: 1500000,
    timeAgo: "2 days ago",
    channelProfilePic: "https://cdn.pixabay.com/photo/2016/07/17/18/28/switzerland-1524425_1280.png",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2017/10/30/15/51/violin-2902804_1280.jpg",
    minuteCount: "15:23",
    category: "Music",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "ChatGPT: The Future of AI",
    channelName: "TechInsights",
    views: 2000000,
    timeAgo: "1 week ago",
    channelProfilePic: "https://cdn.pixabay.com/photo/2016/07/17/18/28/switzerland-1524425_1280.png",
    videoThumbnailPic: "https://media.istockphoto.com/id/533032493/photo/woman-playing-the-violin.jpg?s=612x612&w=0&k=20&c=EX54B2wITrziPDKeARO38nWXDTx1UJF55nXRrKECdvA=",
    minuteCount: "22:45",
    category: "AI",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Elden Ring Speedrun World Record",
    channelName: "GameMasters",
    views: 3500000,
    timeAgo: "3 days ago",
    channelProfilePic: "https://cdn.pixabay.com/photo/2016/07/17/18/28/switzerland-1524425_1280.png",
    videoThumbnailPic: "https://media.istockphoto.com/id/1188401065/photo/violinist-woman-holding-violin-behind.jpg?s=612x612&w=0&k=20&c=i2Sw0gVRXnuV-dXvwmsBcIAl8EDZYd4RPpLOqwxtZD8=",
    minuteCount: "1:45:30",
    category: "Gaming",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Marvel vs DC: Comic Book Showdown",
    channelName: "ComicVerse",
    views: 750000,
    timeAgo: "5 days ago",
    channelProfilePic: "https://cdn.pixabay.com/photo/2016/07/17/18/28/switzerland-1524425_1280.png",
    videoThumbnailPic: "https://media.istockphoto.com/id/185065790/photo/girl-with-violin.jpg?s=612x612&w=0&k=20&c=IpKwREd8CHMbjUke3VVd_7pacJOnPwMvwJTko6h2qr0=",
    minuteCount: "18:20",
    category: "Comic Books",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
 
 
  
  
];

final List<YoutubeVideoModel> videos2 = [


 
];
