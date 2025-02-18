import 'package:ecom_app/cubit/page_cubit.dart';
import 'package:ecom_app/widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => PageCubit(),
          child: const PageViewScreen(),
        ),
      ),
    );
  }
}

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  late final PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, int>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              PageView.builder(
                controller: controller,
                itemCount: 3,
                onPageChanged: (index) {
                  if (index >= 0 && index < 3) {
                    context.read<PageCubit>().updatePage(index);
                  }
                },
                itemBuilder: (context, i) {
                  return PageWidget(
                    'Page n~ ${i + 1}',
                  );
                },
              ),
              Positioned(
                bottom: 15,
                left: 15,
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: CustomizableEffect(
                    dotDecoration: DotDecoration(
                      width: 20,
                      height: 7,
                      color: const Color.fromARGB(255, 38, 48, 105),
                      borderRadius: BorderRadius.circular(4),
                      rotationAngle: 180,
                      verticalOffset: 0,
                    ),
                    spacing: 10,
                    activeDotDecoration: DotDecoration(
                      width: 35,
                      height: 7,
                      color: const Color.fromARGB(255, 49, 210, 184),
                      borderRadius: BorderRadius.circular(10),
                      dotBorder: DotBorder(
                        padding: 2,
                        width: 0.5,
                        type: DotBorderType.solid,
                        color: const Color.fromARGB(255, 49, 210, 184),
                      ),
                      verticalOffset: -2,
                    ),
                    activeColorOverride: (index) =>
                        const Color.fromARGB(255, 49, 210, 184),
                  ),
                  onDotClicked: (index) {
                    controller.animateToPage(
                      index,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOutCirc,
                    );
                    context.read<PageCubit>().updatePage(index);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
