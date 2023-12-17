import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_detail.dart';
import 'package:tiktok_clone/utilities.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  actions: [
                    IconButton(
                      onPressed: _onGearPressed,
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
                      Gaps.v20,
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
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PersistentTabBar(),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                GridView.builder(
                  padding: EdgeInsets.zero,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 9 / 12,
                    crossAxisCount: 3,
                    crossAxisSpacing: Sizes.size2,
                    mainAxisSpacing: Sizes.size2,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 9 / 12,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: "assets/images/bibab.jpg",
                            image:
                                "https://cdn.indiepost.co.kr/uploads/images/2018/11/19/aH4ATq-700x393.jpeg",
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
        ),
      ),
    );
  }
}
