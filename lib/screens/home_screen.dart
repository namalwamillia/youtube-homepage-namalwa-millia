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

              /*  
               SingleChildScrollView(
                child: Column(
                  children: videos1.map(
                    (e) {
                      return SingleVideoCard(
                        model: e,
                      );
                    },
                  ).toList(),
                ),
              ), */
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
                  : Colors.grey
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
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2024/08/02/16/44/rose-8940207_1280.jpg",
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
    videoThumbnailPic: "assets/thumbnails/classical_study.jpg",
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
    videoThumbnailPic: "assets/thumbnails/rock_history.jpg",
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
    videoThumbnailPic: "assets/thumbnails/guitar_guide.jpg",
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
    videoThumbnailPic: "assets/thumbnails/ai_revolution.jpg",
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
    videoThumbnailPic: "assets/thumbnails/ml_beginners.jpg",
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
    videoThumbnailPic: "assets/thumbnails/ai_ethics.jpg",
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
    videoThumbnailPic: "assets/thumbnails/ai_healthcare.jpg",
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
    videoThumbnailPic: "assets/thumbnails/top_games_2023.jpg",
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
    videoThumbnailPic: "assets/thumbnails/minecraft_city.jpg",
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
    videoThumbnailPic: "assets/thumbnails/mario64_speedrun.jpg",
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
    videoThumbnailPic: "assets/thumbnails/fortnite_tips.jpg",
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
    videoThumbnailPic: "assets/thumbnails/marvel_vs_dc.jpg",
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
    videoThumbnailPic: "assets/thumbnails/top_graphic_novels.jpg",
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
    videoThumbnailPic: "assets/thumbnails/superman_history.jpg",
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
    videoThumbnailPic: "assets/thumbnails/create_comic.jpg",
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
    videoThumbnailPic: "assets/thumbnails/ai_evolution.jpg",
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
    videoThumbnailPic: "assets/thumbnails/minecraft_guide.jpg",
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
    videoThumbnailPic: "assets/thumbnails/home_workout.jpg",
    minuteCount: "15:10",
    category: "Fitness & Health",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: true,
  ),
  YoutubeVideoModel(
    title: "Breaking: Major Climate Agreement Signed",
    channelName: "GlobalNews",
    views: 500000,
    timeAgo: "2 hours ago",
    channelProfilePic: "assets/channel_pics/global_news.jpg",
    videoThumbnailPic: "assets/thumbnails/climate_agreement.jpg",
    minuteCount: "4:55",
    category: "News & Politics",
    hasPromotion: false,
    muted: true,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "10 Must-Visit Hidden Gems in Europe",
    channelName: "TravelBug",
    views: 1200000,
    timeAgo: "2 weeks ago",
    channelProfilePic: "assets/channel_pics/travel_bug.jpg",
    videoThumbnailPic: "assets/thumbnails/europe_gems.jpg",
    minuteCount: "25:20",
    category: "Travel & Adventure",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "The Science Behind Black Holes",
    channelName: "CosmosExplorer",
    views: 750000,
    timeAgo: "4 days ago",
    channelProfilePic: "assets/channel_pics/cosmos_explorer.jpg",
    videoThumbnailPic: "assets/thumbnails/black_holes.jpg",
    minuteCount: "20:15",
    category: "Science & Technology",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
];


//For these ones (The videos), update both video thumbnail and channel pic
final List<YoutubeVideoModel> videos1 = [
  YoutubeVideoModel(
    title: "Top 10 Pop Hits of 2023",
    channelName: "MusicTrends",
    views: 1500000,
    timeAgo: "2 days ago",
    channelProfilePic: "https://cdn.pixabay.com/photo/2013/09/25/01/52/rose-185961_1280.jpg",
    videoThumbnailPic: "https://cdn.pixabay.com/photo/2024/06/25/21/08/train-8853636_1280.jpg",
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
    channelProfilePic: "assets/channel_pics/tech_insights.jpg",
    videoThumbnailPic: "assets/thumbnails/chatgpt_future.jpg",
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
    channelProfilePic: "assets/channel_pics/game_masters.jpg",
    videoThumbnailPic: "assets/thumbnails/elden_ring_speedrun.jpg",
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
    channelProfilePic: "assets/channel_pics/comic_verse.jpg",
    videoThumbnailPic: "assets/thumbnails/marvel_vs_dc.jpg",
    minuteCount: "18:20",
    category: "Comic Books",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Understanding Quantum Physics",
    channelName: "ScienceExplained",
    views: 1200000,
    timeAgo: "2 weeks ago",
    channelProfilePic: "assets/channel_pics/science_explained.jpg",
    videoThumbnailPic: "assets/thumbnails/quantum_physics.jpg",
    minuteCount: "25:15",
    category: "Education",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "5G Technology Explained",
    channelName: "TechTalk",
    views: 900000,
    timeAgo: "4 days ago",
    channelProfilePic: "assets/channel_pics/tech_talk.jpg",
    videoThumbnailPic: "assets/thumbnails/5g_explained.jpg",
    minuteCount: "12:30",
    category: "Science & Technology",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Perfect Homemade Pizza Recipe",
    channelName: "CookingMaster",
    views: 2500000,
    timeAgo: "1 month ago",
    channelProfilePic: "assets/channel_pics/cooking_master.jpg",
    videoThumbnailPic: "assets/thumbnails/homemade_pizza.jpg",
    minuteCount: "10:45",
    category: "Cooking & Food",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Hidden Gems of Southeast Asia",
    channelName: "Wanderlust",
    views: 800000,
    timeAgo: "3 weeks ago",
    channelProfilePic: "assets/channel_pics/wanderlust.jpg",
    videoThumbnailPic: "assets/thumbnails/southeast_asia.jpg",
    minuteCount: "20:18",
    category: "Travel & Adventure",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "30-Day HIIT Challenge",
    channelName: "FitLife",
    views: 1800000,
    timeAgo: "2 months ago",
    channelProfilePic: "assets/channel_pics/fit_life.jpg",
    videoThumbnailPic: "assets/thumbnails/hiit_challenge.jpg",
    minuteCount: "15:00",
    category: "Fitness & Health",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: true,
  ),
  YoutubeVideoModel(
    title: "Easy DIY Home Decor Ideas",
    channelName: "CraftyCreations",
    views: 650000,
    timeAgo: "1 week ago",
    channelProfilePic: "assets/channel_pics/crafty_creations.jpg",
    videoThumbnailPic: "assets/thumbnails/diy_decor.jpg",
    minuteCount: "8:55",
    category: "DIY & Crafts",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: true,
  ),
  YoutubeVideoModel(
    title: "Breaking News: Global Summit 2023",
    channelName: "WorldNews",
    views: 500000,
    timeAgo: "5 hours ago",
    channelProfilePic: "assets/channel_pics/world_news.jpg",
    videoThumbnailPic: "assets/thumbnails/global_summit.jpg",
    minuteCount: "3:20",
    category: "News & Politics",
    hasPromotion: false,
    muted: true,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Top 10 Movies of 2023",
    channelName: "CinemaSpotlight",
    views: 1300000,
    timeAgo: "2 days ago",
    channelProfilePic: "assets/channel_pics/cinema_spotlight.jpg",
    videoThumbnailPic: "assets/thumbnails/top_movies_2023.jpg",
    minuteCount: "17:40",
    category: "Movies & Shows",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "The Art of 2D Animation",
    channelName: "AnimationStation",
    views: 450000,
    timeAgo: "1 month ago",
    channelProfilePic: "assets/channel_pics/animation_station.jpg",
    videoThumbnailPic: "assets/thumbnails/2d_animation.jpg",
    minuteCount: "14:30",
    category: "Animation",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "10-Minute Natural Makeup Tutorial",
    channelName: "BeautyGuru",
    views: 2200000,
    timeAgo: "3 days ago",
    channelProfilePic: "assets/channel_pics/beauty_guru.jpg",
    videoThumbnailPic: "assets/thumbnails/natural_makeup.jpg",
    minuteCount: "10:05",
    category: "Beauty & Makeup",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "iPhone 15 Pro Max Review",
    channelName: "TechReviewer",
    views: 3000000,
    timeAgo: "1 week ago",
    channelProfilePic: "assets/channel_pics/tech_reviewer.jpg",
    videoThumbnailPic: "assets/thumbnails/iphone_15_review.jpg",
    minuteCount: "21:15",
    category: "Tech Reviews",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Stand-up Comedy Special: Laugh Out Loud",
    channelName: "ComedyCentral",
    views: 1700000,
    timeAgo: "2 weeks ago",
    channelProfilePic: "assets/channel_pics/comedy_central.jpg",
    videoThumbnailPic: "assets/thumbnails/standup_special.jpg",
    minuteCount: "45:30",
    category: "Comedy",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "UEFA Champions League Highlights",
    channelName: "SportsCenter",
    views: 4000000,
    timeAgo: "1 day ago",
    channelProfilePic: "assets/channel_pics/sports_center.jpg",
    videoThumbnailPic: "assets/thumbnails/champions_league.jpg",
    minuteCount: "10:00",
    category: "Sports",
    hasPromotion: false,
    muted: true,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "The Rise of K-Pop: Global Phenomenon",
    channelName: "MusicInsider",
    views: 1900000,
    timeAgo: "6 days ago",
    channelProfilePic: "assets/channel_pics/music_insider.jpg",
    videoThumbnailPic: "assets/thumbnails/kpop_rise.jpg",
    minuteCount: "18:50",
    category: "Music",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Machine Learning for Beginners",
    channelName: "CodeMaster",
    views: 750000,
    timeAgo: "3 weeks ago",
    channelProfilePic: "assets/channel_pics/code_master.jpg",
    videoThumbnailPic: "assets/thumbnails/machine_learning.jpg",
    minuteCount: "30:20",
    category: "Education",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Exploring Mars: Latest Discoveries",
    channelName: "SpaceExplorer",
    views: 1100000,
    timeAgo: "4 days ago",
    channelProfilePic: "assets/channel_pics/space_explorer.jpg",
    videoThumbnailPic: "assets/thumbnails/mars_exploration.jpg",
    minuteCount: "25:45",
    category: "Science & Technology",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
];

final List<YoutubeVideoModel> videos2 = [
  YoutubeVideoModel(
    title: "The Rise of Indie Game Developers",
    channelName: "GameDevInsider",
    views: 1200000,
    timeAgo: "3 days ago",
    channelProfilePic: "assets/channel_pics/gamedev_insider.jpg",
    videoThumbnailPic: "assets/thumbnails/indie_games.jpg",
    minuteCount: "18:30",
    category: "Gaming",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "5 Easy Vegan Recipes for Beginners",
    channelName: "VeganDelights",
    views: 800000,
    timeAgo: "1 week ago",
    channelProfilePic: "assets/channel_pics/vegan_delights.jpg",
    videoThumbnailPic: "assets/thumbnails/vegan_recipes.jpg",
    minuteCount: "12:45",
    category: "Cooking & Food",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Understanding Blockchain Technology",
    channelName: "TechExplained",
    views: 2000000,
    timeAgo: "5 days ago",
    channelProfilePic: "assets/channel_pics/tech_explained.jpg",
    videoThumbnailPic: "assets/thumbnails/blockchain.jpg",
    minuteCount: "22:15",
    category: "Science & Technology",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "10-Minute Ab Workout Challenge",
    channelName: "FitnessPro",
    views: 3500000,
    timeAgo: "2 weeks ago",
    channelProfilePic: "assets/channel_pics/fitness_pro.jpg",
    videoThumbnailPic: "assets/thumbnails/ab_workout.jpg",
    minuteCount: "10:05",
    category: "Fitness & Health",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: true,
  ),
  YoutubeVideoModel(
    title: "The History of Marvel Comics",
    channelName: "ComicBookLore",
    views: 950000,
    timeAgo: "4 days ago",
    channelProfilePic: "assets/channel_pics/comic_book_lore.jpg",
    videoThumbnailPic: "assets/thumbnails/marvel_history.jpg",
    minuteCount: "25:30",
    category: "Comic Books",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Top 10 Classical Music Pieces",
    channelName: "ClassicalMaestro",
    views: 600000,
    timeAgo: "1 month ago",
    channelProfilePic: "assets/channel_pics/classical_maestro.jpg",
    videoThumbnailPic: "assets/thumbnails/classical_music.jpg",
    minuteCount: "15:20",
    category: "Music",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "DIY: Build Your Own PC",
    channelName: "TechDIY",
    views: 1800000,
    timeAgo: "2 weeks ago",
    channelProfilePic: "assets/channel_pics/tech_diy.jpg",
    videoThumbnailPic: "assets/thumbnails/build_pc.jpg",
    minuteCount: "30:45",
    category: "Tech Reviews",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Exploring the Amazon Rainforest",
    channelName: "NatureExplorers",
    views: 750000,
    timeAgo: "3 days ago",
    channelProfilePic: "assets/channel_pics/nature_explorers.jpg",
    videoThumbnailPic: "assets/thumbnails/amazon_rainforest.jpg",
    minuteCount: "28:10",
    category: "Travel & Adventure",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "How to Start a Successful YouTube Channel",
    channelName: "CreatorAcademy",
    views: 2200000,
    timeAgo: "1 week ago",
    channelProfilePic: "assets/channel_pics/creator_academy.jpg",
    videoThumbnailPic: "assets/thumbnails/youtube_success.jpg",
    minuteCount: "20:30",
    category: "Education",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Breaking: Major Economic Policy Shift",
    channelName: "GlobalNewsNetwork",
    views: 500000,
    timeAgo: "5 hours ago",
    channelProfilePic: "assets/channel_pics/global_news_network.jpg",
    videoThumbnailPic: "assets/thumbnails/economic_policy.jpg",
    minuteCount: "3:45",
    category: "News & Politics",
    hasPromotion: false,
    muted: true,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "The Art of Stop-Motion Animation",
    channelName: "AnimationStation",
    views: 1100000,
    timeAgo: "6 days ago",
    channelProfilePic: "assets/channel_pics/animation_station.jpg",
    videoThumbnailPic: "assets/thumbnails/stop_motion.jpg",
    minuteCount: "17:25",
    category: "Animation",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "5-Minute Natural Makeup Tutorial",
    channelName: "BeautyGuru101",
    views: 3000000,
    timeAgo: "2 days ago",
    channelProfilePic: "assets/channel_pics/beauty_guru_101.jpg",
    videoThumbnailPic: "assets/thumbnails/natural_makeup.jpg",
    minuteCount: "5:15",
    category: "Beauty & Makeup",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: true,
  ),
  YoutubeVideoModel(
    title: "Stand-up Comedy: Laugh Factory Special",
    channelName: "ComedyClub",
    views: 1500000,
    timeAgo: "1 week ago",
    channelProfilePic: "assets/channel_pics/comedy_club.jpg",
    videoThumbnailPic: "assets/thumbnails/standup_comedy.jpg",
    minuteCount: "45:00",
    category: "Comedy",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "NBA Finals Highlights 2023",
    channelName: "SportsCenter",
    views: 5000000,
    timeAgo: "1 day ago",
    channelProfilePic: "assets/channel_pics/sports_center.jpg",
    videoThumbnailPic: "assets/thumbnails/nba_finals.jpg",
    minuteCount: "10:30",
    category: "Sports",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "The Future of Renewable Energy",
    channelName: "ScienceToday",
    views: 900000,
    timeAgo: "4 days ago",
    channelProfilePic: "assets/channel_pics/science_today.jpg",
    videoThumbnailPic: "assets/thumbnails/renewable_energy.jpg",
    minuteCount: "23:50",
    category: "Science & Technology",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Easy Origami for Beginners",
    channelName: "CraftyCreations",
    views: 700000,
    timeAgo: "2 weeks ago",
    channelProfilePic: "assets/channel_pics/crafty_creations.jpg",
    videoThumbnailPic: "assets/thumbnails/origami.jpg",
    minuteCount: "8:15",
    category: "DIY & Crafts",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: true,
  ),
  YoutubeVideoModel(
    title: "Top 10 Movies of All Time",
    channelName: "CinematicWonders",
    views: 2500000,
    timeAgo: "3 weeks ago",
    channelProfilePic: "assets/channel_pics/cinematic_wonders.jpg",
    videoThumbnailPic: "assets/thumbnails/top_movies.jpg",
    minuteCount: "20:00",
    category: "Movies & Shows",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Introduction to Machine Learning",
    channelName: "AIAcademy",
    views: 1300000,
    timeAgo: "5 days ago",
    channelProfilePic: "assets/channel_pics/ai_academy.jpg",
    videoThumbnailPic: "assets/thumbnails/machine_learning.jpg",
    minuteCount: "27:30",
    category: "AI",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "Guitar Basics: Learn Your First Chords",
    channelName: "MusicMastery",
    views: 850000,
    timeAgo: "1 week ago",
    channelProfilePic: "assets/channel_pics/music_mastery.jpg",
    videoThumbnailPic: "assets/thumbnails/guitar_basics.jpg",
    minuteCount: "15:45",
    category: "Music",
    hasPromotion: true,
    muted: false,
    hasCC: true,
    isShort: false,
  ),
  YoutubeVideoModel(
    title: "10 Life Hacks to Simplify Your Day",
    channelName: "LifeHacker",
    views: 4000000,
    timeAgo: "3 days ago",
    channelProfilePic: "assets/channel_pics/life_hacker.jpg",
    videoThumbnailPic: "assets/thumbnails/life_hacks.jpg",
    minuteCount: "11:20",
    category: "Education",
    hasPromotion: false,
    muted: false,
    hasCC: true,
    isShort: true,
  ),
];
