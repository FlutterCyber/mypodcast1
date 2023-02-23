import 'dart:io';
import 'dart:ui';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:ebook_app/pages/book_info_page/book_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import '../../controllers/music_payer/music_payer_controller.dart';
import '../../controllers/music_payer/music_position_data.dart';

class AudioWithPdfPage extends StatefulWidget {
  static const String id = "pdf_viewer_page";
  final File file;

  const AudioWithPdfPage({Key? key, required this.file}) : super(key: key);

  @override
  State<AudioWithPdfPage> createState() => _AudioWithPdfPageState();
}

class _AudioWithPdfPageState extends State<AudioWithPdfPage> {
  late PDFViewController controller;
  late AudioPlayer _audioPlayer;

  int pages = 0;
  int indexPage = 0;

  Stream<MusicPositionData> get _positionDataStream => rxdart.Rx.combineLatest3(
        _audioPlayer.positionStream,
        _audioPlayer.durationStream,
        _audioPlayer.bufferedPositionStream,
        (position, duration, bufferedPosition) => MusicPositionData(
          position: position,
          duration: duration,
          bufferedPosition: bufferedPosition ?? Duration.zero,
        ),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer = AudioPlayer()..setAsset("assets/audios/zivert.mp3");
    ///..setUrl("")
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = "${indexPage + 1} of $pages";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2F2F2F),
        leading: IconButton(
          onPressed: () {
            Get.offAll(BookInfoPage());
          },
          icon: Icon(IconlyBroken.arrow_left,color: Color(0xffBFA054),),
        ),
        actions: [
          Center(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Color(0xffBFA054)),
            ),
          ),
          IconButton(
            onPressed: () {
              final page = indexPage == 0 ? pages : indexPage - 1;
              controller.setPage(page);
            },
            icon: const Icon(
              IconlyBroken.arrow_left,color: Color(0xffBFA054),
            ),
          ),
          IconButton(
            onPressed: () {
              final page = indexPage == pages - 1 ? 0 : indexPage + 1;
              controller.setPage(page);
            },
            icon: Icon(
              IconlyBroken.arrow_right,color: Color(0xffBFA054)
            ),
          ),
        ],
        title: Text(name,style: TextStyle(color: Color(0xffBFA054)),),
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.file.path,
            //swipeHorizontal: true,
            pageSnap: false,
            pageFling: false,
            autoSpacing: false,
            //nightMode: true,
            onRender: (pages) {
              setState(() {
                this.pages = pages!;
              });
            },
            onViewCreated: (controller) {
              setState(() {
                this.controller = controller;
              });
            },
            onPageChanged: (indexPage, _) {
              setState(
                () {
                  this.indexPage = indexPage!;
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: _audioPlayerWidget1(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Widget _audioPlayerWidget1() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 10,
          sigmaX: 10,
        ),
        child: Container(
          height: Get.height * 0.2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xff2F2F2F).withOpacity(0.2),
                const Color(0xff2F2F2F).withOpacity(0.2),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<MusicPositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(right: 15,left: 15),
                    child: ProgressBar(
                      barHeight: 8,
                      baseBarColor: Colors.grey[600],
                      bufferedBarColor: Colors.grey,
                      progressBarColor: Color(0xffFBF8F2),
                      thumbColor: Color(0xffBFA054),
                      timeLabelTextStyle: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                      progress: positionData?.position ?? Duration.zero,
                      buffered: positionData?.bufferedPosition ?? Duration.zero,
                      total: positionData?.duration ?? Duration.zero,
                      onSeek: _audioPlayer.seek,
                    ),
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            IconlyBroken.arrow_left_circle,
                            size: 40,
                          ),
                        ),
                        Text("10 sec"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MusicPlayerController(
                          audioplayer: _audioPlayer,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            IconlyBroken.arrow_right_circle,
                            size: 40,
                          ),
                        ),
                        Text("10 sec"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
