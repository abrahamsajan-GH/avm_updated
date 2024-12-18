final Map<String, String> availableLanguages = {
  'Bulgarian': 'bg',
  'Catalan': 'ca',
  'Chinese': 'zh',
  'Czech': 'cs',
  'Danish': 'da',
  'Dutch': 'nl',
  'English': 'en',
  'Finnish': 'fi',
  'French': 'fr',
  'German': 'de',
  'Greek': 'el',
  'Hindi': 'hi',
  'Hungarian': 'hu',
  'Indonesian': 'id',
  'Italian': 'it',
  'Japanese': 'ja',
  'Korean': 'ko',
  'Latvian': 'lv',
  'Lithuanian': 'lt',
  'Malay': 'ms',
  'Norwegian': 'no',
  'Polish': 'pl',
  'Portuguese': 'pt',
  'Russian': 'ru',
  'Spanish': 'es',
  'Swedish': 'sv',
  'Thai': 'th',
  'Turkish': 'tr',
  'Ukrainian': 'uk',
  'Vietnamese': 'vi',
};

getLanguageName(String code) {
  return availableLanguages.entries
      .firstWhere((element) => element.value == code)
      .key;
}
