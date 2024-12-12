import 'package:flutter/material.dart';
import 'package:home_page/widgets/extensions.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Colors.pinkAccent.withOpacity(0.5),
      child: LayoutBuilder(builder: (ctx, c) {
        if (c.maxWidth < 900) {
          return Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'Follow me on social media :',
                style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: networkImage("https://cdn-icons-png.flaticon.com/128/1384/1384014.png"),
                      onPressed: () async =>
                          await "https://www.linkedin.com/in/monika-nb-3bb1b6188/"
                              .toUri()
                              .launch()),
                  IconButton(
                      icon: networkImage("https://cdn-icons-png.flaticon.com/128/1384/1384007.png"),
                      onPressed: () async => await "https://wa.me/919790980539".toUri().launch()),
                  IconButton(
                      icon: networkImage("https://cdn-icons-png.flaticon.com/128/1384/1384015.png"),
                      onPressed: () async =>
                          "https://www.instagram.com/nika_monz/".toUri().launch()),
                ],
              ),
            ],
          );
        }
        return Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Follow me on social media :',
                  style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    icon: networkImage("https://cdn-icons-png.flaticon.com/128/1384/1384014.png"),
                    onPressed: () async =>
                        await "https://www.linkedin.com/in/stefun-s-2a6975228".toUri().launch()),
                IconButton(
                    icon: networkImage("https://cdn-icons-png.flaticon.com/128/1384/1384007.png"),
                    onPressed: () async => await "https://wa.me/919790164675".toUri().launch()),
                IconButton(
                    icon: networkImage("https://cdn-icons-png.flaticon.com/128/1384/1384015.png"),
                    onPressed: () async =>
                        "https://www.instagram.com/s_t_e_f_u_n/".toUri().launch()),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget networkImage(String url) {
    return cricleBorder(Image.network(
      url,
      height: 50,
      fit: BoxFit.cover,
      width: 50,
    ));
  }

  Widget cricleBorder(Widget widget) => Material(
        elevation: 18.0,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: widget,
      );
}
