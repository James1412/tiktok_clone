import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/widgets/user_detail.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.gear,
                ),
              ),
            ],
            title: const Text(
              'James',
              style: TextStyle(
                fontSize: Sizes.size18,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  foregroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/73318218?v=4',
                  ),
                  child: Text("James"),
                ),
                Gaps.v14,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "@jameslee",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.h10,
                    FaIcon(
                      FontAwesomeIcons.solidCircleCheck,
                      color: Colors.blue,
                      size: Sizes.size14,
                    ),
                  ],
                ),
                Gaps.v20,
                const SizedBox(
                  height: Sizes.size52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UserDetail(value: "97", title: "Following"),
                      VerticalDivider(
                        indent: Sizes.size14,
                        endIndent: Sizes.size14,
                        thickness: Sizes.size1 / Sizes.size2,
                        width: Sizes.size32,
                      ),
                      UserDetail(value: "10M", title: "Followers"),
                      VerticalDivider(
                        indent: Sizes.size14,
                        endIndent: Sizes.size14,
                        thickness: Sizes.size1 / Sizes.size2,
                        width: Sizes.size32,
                      ),
                      UserDetail(value: "194.5M", title: "Likes"),
                    ],
                  ),
                ),
                Gaps.v14,
                FractionallySizedBox(
                  widthFactor: 0.33,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size12,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(Sizes.size4),
                    ),
                    child: const Text(
                      "Follow",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Gaps.v10,
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.size32,
                  ),
                  child: Text(
                    "All highlights and where to watch live mathces on FIFA+ I wonder how it would look",
                    textAlign: TextAlign.center,
                  ),
                ),
                Gaps.v12,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.link,
                      size: Sizes.size14,
                    ),
                    Gaps.h4,
                    Text(
                      "http://jastory.tistory.com",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                Gaps.v14,
                Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.grey.shade200,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: const TabBar(
                    labelPadding: EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    splashFactory: NoSplash.splashFactory,
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    tabs: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
                        child: Icon(Icons.grid_4x4_rounded),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
                        child: FaIcon(FontAwesomeIcons.heart),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    children: [
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.all(
                          Sizes.size8,
                        ),
                        itemCount: 20,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size5),
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
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 12,
                                      backgroundImage: NetworkImage(
                                          "https://cdn.indiepost.co.kr/uploads/images/2018/11/19/aH4ATq-700x393.jpeg"),
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
                        },
                      ),
                      const Center(
                        child: Text("Page two"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
