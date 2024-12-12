import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_page/blocs/appbar_part/appbar_bloc.dart';
import 'package:home_page/blocs/appbar_part/appbar_events.dart';
import 'package:home_page/blocs/appbar_part/appbar_state.dart';
import 'package:home_page/constants.dart';
import 'package:home_page/main.dart';
import 'package:home_page/widgets/AppBarWidgets.dart';
import 'package:home_page/widgets/animatedBacground.dart';
import 'package:home_page/widgets/extensions.dart';
import 'package:home_page/widgets/project_card.dart';

import '../widgets/common_widgets.dart';
import '../widgets/footer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with GlobalKeys {
  PageController pgCont = PageController(initialPage: 0, viewportFraction: 0.3);
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pgCont.position.atEdge) {
        pgCont.animateTo(1, duration: const Duration(seconds: 3), curve: Curves.easeInOutExpo);
      } else {
        pgCont.nextPage(duration: const Duration(seconds: 3), curve: Curves.easeInOutExpo);
      }
    });
    super.initState();
  }

  // static List<String> navBarContents = ["Home", "Projects", "Contact"];
  String selectedTile = "Home";
  @override
  Widget build(BuildContext context) {
    final AppBarBloc appBarBloc = BlocProvider.of(context);
    final List<Map<String, String>> menuItems = [
      {
        'title': 'Grilled Ribeye Steak',
        'description': 'Juicy ribeye steak with garlic mashed potatoes.',
        'image': 'https://hillstreetgrocer.com/application/files/1915/8148/5396/The_ultimate_Rib-Eye_steak.jpg',
      },
      {
        'title': 'Linguine al Pesto',
        'description': 'Pasta tossed in creamy basil pesto sauce.',
        'image': 'https://images.themodernproper.com/billowy-turkey/production/posts/2022/Linguine-witih-Lemon-Garlic-Sauce-6.jpeg?w=600&q=82&auto=format&fit=crop&dm=1648430386&s=293620ecab29d27206dec16f524b22dc',
      },
      {
        'title': 'Molten Lava Cake',
        'description': 'Warm chocolate cake with a gooey center.',
        'image': 'https://www.foodandwine.com/thmb/JzCnKoNjLkG2nRwVSdFZoR2pEAs=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/molten-chocolate-cake-FT-RECIPE0220-0a33d7d0ab0c45588f7bfe742d33a9bc.jpg',
      },
    ];
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueAccent.withOpacity(0.5),
            automaticallyImplyLeading: false,
            title: const Text('FOOD COURT',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            actions: [
              BlocBuilder<AppBarBloc, AppBarState>(builder: (ctx, state) {
                if (state is SeletedTile) {
                  return Row(
                      children: keyForFrames.keys.map((e) {
                    return GestureDetector(
                        onTap: () async {
                          RenderObject? renderObject =
                              keyForFrames[e]!.currentContext!.findRenderObject();
                          if (renderObject != null) {
                            renderObject.showOnScreen(
                                duration: const Duration(seconds: 2), curve: Curves.fastOutSlowIn);
                          }
                          appBarBloc.add(ChangeSeletcion(selectedTile: e));
                        },
                        child: AppBarActions(title: e, notSelected: e != state.tile));
                  }).toList());
                }
                return Container();
              })
            ]),
        body: AnimatedBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Hy Foodies!!! ',
                          key: keyForFrames["Home"],
                          style: TextStyle(fontSize: 22.adjust(), fontWeight: FontWeight.bold)),
                      SizedBox(height: Sizes.width * 0.01),
                      Text(
                          '   Welcome to Food Court Step into a world of culinary delight at Food court, where tradition meets innovation. Nestled in the heart of Tambaram, our restaurant is a haven for food lovers who appreciate exceptional flavors, cozy ambiance, and impeccable service.Indulge in our thoughtfully crafted menu, featuring a perfect blend of classic recipes and contemporary creations. From farm-fresh ingredients to expertly prepared dishes, every plate tells a story of passion and quality.Whether you’re joining us for a casual lunch, a romantic dinner, or a celebration with friends, [Restaurant Name] promises an unforgettable dining experience. Explore our signature dishes, sip on our handcrafted cocktails, and let us transport your senses to new heights.',
                          style: TextStyle(fontSize: 18.adjust())),
                      SizedBox(key: keyForFrames["About"], height: Sizes.width * 0.02),
                      Text('Professional Summary : ',
                          style: TextStyle(fontSize: 22.adjust(), fontWeight: FontWeight.bold)),
                      SizedBox(height: Sizes.width * 0.01),
           SizedBox(height:400,

             child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(item['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title']!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              item['description']!,
                              style: TextStyle(color: Colors.purpleAccent[700]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),),
                      SizedBox(height: Sizes.width * 0.02),
                      Text('Menu Highlights : ',
                          style: TextStyle(fontSize: 22.adjust(), fontWeight: FontWeight.bold)),
                      SizedBox(height:MediaQuery.sizeOf(context).height * 0.01),
                      LayoutBuilder(builder: (ctx, c) {
                        if (c.maxWidth < 900) {
                          return Container(
                            alignment: Alignment.topLeft,
                            width:MediaQuery.sizeOf(context).width*0.95,
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.35,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: Constants.menuHighlights.length, // Number of menu items
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                      height: MediaQuery.sizeOf(context).height * 0.45,
                                      width: MediaQuery.sizeOf(context).width * 0.9,
                                      child:Card(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                    Padding(
                                    padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width * 0.005, // 5% of the screen width
                                    vertical: MediaQuery.of(context).size.height * 0.005, // 2% of the screen height
                                  ),child: Image.network('${Constants.menuHighlights[index]['image']}',
                                          width: MediaQuery.sizeOf(context).width * 0.35,
                                          height: MediaQuery.sizeOf(context).height * 0.2,
                                          fit: BoxFit.cover,
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                          '${Constants.menuHighlights[index]['name']}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,color: Colors.black38
                                                ),
                                              ),
                                              Text('${Constants.menuHighlights[index]['data']}', style: TextStyle(
                                                  fontWeight: FontWeight.bold,color: Colors.purpleAccent[700]
                                              ),),
                                              Text('\$${Constants.menuHighlights[index]['price']}'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                                },
                              ),
                            ),  );
                        }
                        return Container(
                          alignment: Alignment.center,
                          width:MediaQuery.sizeOf(context).width*0.95,
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.3,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Constants.menuHighlights.length, // Number of menu items
                              itemBuilder: (context, index) {
                                return SizedBox(
                                    height: MediaQuery.sizeOf(context).height * 0.45,
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child:Card(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: [
                                      Image.network('${Constants.menuHighlights[index]['image']}',
                                        width: MediaQuery.sizeOf(context).width * 0.2,
                                        height: MediaQuery.sizeOf(context).height * 0.1,
                                        fit: BoxFit.cover,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${Constants.menuHighlights[index]['name']}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text('${Constants.menuHighlights[index]['data']}'),
                                            Text('\$${Constants.menuHighlights[index]['price']}'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ) );
                              },
                            ),
                          ),  );

                      }),
                      SizedBox(height:MediaQuery.sizeOf(context).height * 0.02),
                      Text('Why Choose?? ',
                          style: TextStyle(fontSize: 22.adjust(), fontWeight: FontWeight.bold)),
                      SizedBox(height:MediaQuery.sizeOf(context).height * 0.01),
                      LayoutBuilder(builder: (context, c) {
                        if (c.maxWidth < 900) {
                          return Container(
                            width: MediaQuery.sizeOf(context).width,
                            alignment: Alignment.center,
                            child: Column(
                              children: Constants.Whychoose
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: SizedBox(
                                                width: MediaQuery.sizeOf(context).width / 1.5,
                                                child: Column(children: [
                                                  SizedBox(height: MediaQuery.sizeOf(context).width * 0.01),
                                                  Text('${e["category"]} : ',
                                                      style: TextStyle(
                                                          fontSize: 22.adjust(),
                                                          fontWeight: FontWeight.bold)),
                                                  SizedBox(height: MediaQuery.sizeOf(context).width * 0.01),
                                                  ...e["skills"]
                                                      .map((ee) => ListTile(
                                                            leading: const MyBullet(),
                                                            titleAlignment:
                                                                ListTileTitleAlignment.center,
                                                            title: Text(
                                                              ee,
                                                              style: TextStyle(
                                                                  fontSize: 18.adjust(),
                                                                  color: Colors.white
                                                                      .withOpacity(0.8)),
                                                            ),
                                                          ))
                                                      .toList(),
                                                  SizedBox(height: MediaQuery.sizeOf(context).width * 0.01)
                                                ]),
                                              )),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        }
                        return SizedBox(
                          height: MediaQuery.sizeOf(context).height/ 2.3,
                          child: PageView.builder(
                              controller: pgCont,
                              scrollDirection: Axis.horizontal,
                              itemCount: Constants.Whychoose.length,
                              // allowImplicitScrolling: true,
                              itemBuilder: (ctx, ind) {
                                Map<String, dynamic> e = Constants.Whychoose[ind];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: SizedBox(
                                            width: MediaQuery.sizeOf(context).width / 3.5,

                                            // height: Sizes.width / 5,
                                            child: Column(children: [
                                              SizedBox(height: MediaQuery.sizeOf(context).width * 0.01),
                                              Text('${e["category"]} : ',
                                                  style: TextStyle(
                                                      fontSize: 22.adjust(),
                                                      fontWeight: FontWeight.bold)),
                                              SizedBox(height: MediaQuery.sizeOf(context).width * 0.01),
                                              ...e["skills"]
                                                  .map((ee) => ListTile(
                                                        leading: const MyBullet(),
                                                        titleAlignment:
                                                            ListTileTitleAlignment.center,
                                                        title: Text(
                                                          ee,
                                                          style: TextStyle(
                                                              fontSize: 18.adjust(),
                                                              color: Colors.white.withOpacity(0.8)),
                                                        ),
                                                      ))
                                                  .toList(),
                                              SizedBox(height: MediaQuery.sizeOf(context).width * 0.01)
                                            ]),
                                          )),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }),
                      SizedBox(height: MediaQuery.sizeOf(context).width * 0.02),
                      Column(
                        key: keyForFrames["Foods"],
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Foods : ',
                              style: TextStyle(fontSize: 22.adjust(), fontWeight: FontWeight.bold)),
                          SizedBox(height: Sizes.width * 0.01),
                          const ProjectCard()
                        ],
                      ),
                    ])),
                const SizedBox(width: 20),
                SizedBox(
                  key: keyForFrames["Contact"],
                  child: Footer(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

mixin GlobalKeys {
  Map<String, GlobalKey> keyForFrames = {
    "Home": GlobalKey(),
    "Foods": GlobalKey(),
    "Contact": GlobalKey()
  };
}
