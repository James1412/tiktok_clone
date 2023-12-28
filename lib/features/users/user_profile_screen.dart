import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/widgets/avatar.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_detail.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static String routeName = "/user-profile";
  const UserProfileScreen({
    super.key,
  });

  @override
  ConsumerState<UserProfileScreen> createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          data: (data) => Scaffold(
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
                        title: Text(
                          data.name,
                          style: const TextStyle(
                            fontSize: Sizes.size18,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Gaps.v20,
                            Avatar(name: data.name),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "@${data.name}",
                                  style: const TextStyle(
                                    fontSize: Sizes.size16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Gaps.h10,
                                const FaIcon(
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
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size4),
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
                                ),
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
  }
}
