import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/widgets/search_tab.dart';
import 'package:tiktok_clone/utilities.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _controller = TextEditingController();
  void _onSearchChanged(String value) {
    print(value);
  }

  void _onSearchSubmitted(String value) {
    print("Submitted $value");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          leadingWidth: 30,
          leading: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size14,
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.angleLeft,
              ),
            ),
          ),
          actions: const [
            FaIcon(
              FontAwesomeIcons.sliders,
              size: Sizes.size20,
            ),
            Gaps.h16,
          ],
          title: DiscoverSearchTab(
            controller: _controller,
            onChanged: () => _onSearchChanged,
            onSubmitted: () => _onSearchSubmitted,
          ),
          bottom: TabBar(
            onTap: (value) {
              FocusScope.of(context).unfocus();
            },
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            splashFactory: NoSplash.splashFactory,
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(
                  Sizes.size8,
                ),
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 9 / 20,
                  crossAxisCount: 2,
                  crossAxisSpacing: Sizes.size10,
                  mainAxisSpacing: Sizes.size10,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size5),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: "assets/images/bibab.jpg",
                            image:
                                "https://cdn.indiepost.co.kr/uploads/images/2018/11/19/aH4ATq-700x393.jpeg",
                          ),
                        ),
                      ),
                      Gaps.v5,
                      const Text(
                        "This is a very long caption for my tiktok that im uploading just now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.size16,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gaps.v5,
                      DefaultTextStyle(
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(
                                  "https://cdn.indiepost.co.kr/uploads/images/2018/11/19/aH4ATq-700x393.jpeg",),
                            ),
                            Gaps.h4,
                            const Expanded(
                              child: Text(
                                "Very long avatar description",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size16,
                              color: Colors.grey.shade600,
                            ),
                            Gaps.h2,
                            const Text(
                              "2.5M",
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
