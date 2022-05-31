Map<String, String>? config;

Map<String, String> configs = {
  "base_url": "https://api.themoviedb.org/3",
  "image_url": "https://image.tmdb.org/t/p/w500"
};

void setEnvironment() {
  config = configs;
}

class Settings {
  static String get baseUrl => config!["base_url"]!;
  static String get imageUrl => config!["image_url"]!;
}
