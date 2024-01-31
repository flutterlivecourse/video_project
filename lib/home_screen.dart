import 'package:flutter/material.dart';
import 'package:video_project/video_list_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late YoutubePlayerController ytController;
 String videoUrl = "https://www.youtube.com/watch?v=M1najUG6IGM";

  @override
  void initState() {
    videoUrl = YoutubePlayer.convertUrlToId(videoUrl)!;
    print(videoUrl);
    super.initState();
    ytController = YoutubePlayerController(
        initialVideoId: videoUrl,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );

  }
  // YoutubePlayerController _controller = YoutubePlayerController(
  //   initialVideoId: 'M1najUG6IGM',
  //   flags: const YoutubePlayerFlags(
  //     autoPlay: false,
  //     mute: false,
  //   ),
  // );

  List<String> urls = [
    "https://www.youtube.com/watch?v=lKddQtTsqfU&t=15s",
    "https://www.youtube.com/watch?v=Cqj7szSOTC0",
    "https://www.youtube.com/watch?v=efdm5IujE5M",
    "https://www.youtube.com/watch?v=WZ_Epffakx8",
    "https://www.youtube.com/watch?v=VdxrrBWCYj4",
    "https://www.youtube.com/watch?v=pbt4apyrGT8",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("video Project"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: YoutubePlayer(
                controller: ytController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(ytController.metadata.title,style: const TextStyle(color: Colors.black),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: urls.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1/0.6
                  ),
                  itemBuilder: (context,index){
                  return InkWell(
                      onTap: (){
                        videoUrl = urls[index];
                        final String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
                        ytController.load(videoId!);
                        setState(() {});
                      },
                      child: VideoListWidget(videoUrl: urls[index],));
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}