import "package:connect_stem/models/news_data.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NewsData>().fetchData;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<NewsData>().initialValue();
                  context.read<NewsData>().fetchData;
                })
          ],
          title: const Text("Top Stories - News 24"),
        ),
        body: RefreshIndicator(
          child: Center(
            child: Consumer<NewsData>(
              builder: (context, value, child) {
                return value.map.length == 0 && !value.error
                    ? const CircularProgressIndicator()
                    : value.error
                        ? Text(
                            "OOPS! something went wrong. ${value.errorMessage}",
                            textAlign: TextAlign.center,
                          )
                        : ListView.builder(
                            itemCount: value.map['articles'].length,
                            itemBuilder: (context, index) {
                              return NewsCard(
                                  map: value.map["articles"][index]);
                            });
              },
            ),
          ),
          onRefresh: () async {
            context.read<NewsData>().fetchData;
          },
        ));
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.map});
  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "${map['urlToImage'] == null ? "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAK4AAACCCAMAAADovAORAAAAeFBMVEX///////3///v///n8//4Aj/IOkvIMlPYdl/eQxPcflvHl8/gglvPT5/h8uPIwnfRGpvtmtPn2+vzS4/FXq/h3ufjv9vsAjvfH4flfrPC62fZmsflUqvEumO2fyfE5oO+Xzffa7Piw1PeDwfiTxfHC5fiJvehjq+j1NOIqAAACfklEQVR4nO3Y3W7iMBAF4MzE4wTjBBpofiglTejuvv8b7oSuqi2KK1YrESOd7w7CxZEZz9hJEgAAAAAAAAAAAAAAAAAAAFgeLR3g3zCbpSPcSBeW6ooeIy4ZQ2nbHR4kbmLYrJy8VA9SvWyOjXNyWDrHLchQ/SLOvp7qB1hdMmlVZl76gnjpLDcgw2+6tvuBKNB5o1pz4qFxvl/TbCo2WiscU2DuxEuhqeYeGl39Yf7RIigpvJcypfmmy2bX7dfR1IOWQGnzzRDKQ63NZEzmK+XuiGjYOjmbUFNI6721TxVFktekbeZ8m4bGr+H3zPs6lsMPpSfJ+yG494kK65tdJC1ZDzelzfTPDsVhqlwuYyStjEz15LNzElw87WF9bleRFIPG3efZ6tvf7LPsOdCV7+32uHcK9D2N+2I1bjCOFrUWwzmNYnGnvKVkz99uNa9bLZa2yzQ1snU4LhcSTyNLeBoTrg3u/MuYcHVwjNzX5xAOxeG4hvCfI846lIYPzkdTusnlAJl7eU5pph4MUX20fjvEciKbpJ2eCtq5QaDfTfeiUzxZp3IYGp/PXn6I9XzjX6tI2sLF5Wrp3fH6ajnd0VqnlfsjkvPNB41bldbL9urirsU8Ou+zUxpsG0vQWJfXIrI51V++H0pvnV3pVTimuBM2R3HO9mPFrNd0TpmHnxvrfPMeVSV8oMsrPevzRrr3Q1u04+rYNN7ZzRjLfPib7irdVkcNmFsRK17E5c7KuUgjOehemdawPvQieo+c5Jk0XVElMc2Ha0zDqus3zrnN/tdYx9RtZ5BuM0rqodjt1tX0Kco6+ERf3zVSzIUAAAAAAAAAAAAAAAAAAADwH34DSZAZch7AwskAAAAASUVORK5CYII=" : '${map['urlToImage']}'}",
                width: double.infinity,
                height: 300,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                      child: Text("loading.....",
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500)));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text('${map['title']}',
                  style: const TextStyle(
                      fontFamily: "Roboto", fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              Text('${map['description']}'),
            ],
          ),
        ),
      ),
    );
  }
}
