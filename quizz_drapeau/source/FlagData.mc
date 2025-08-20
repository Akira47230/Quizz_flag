// source/FlagData.mc - Improved version with type safety
import Toybox.Lang;
import Toybox.Math;

class FlagData {
    // Base de données des pays et leurs drapeaux (ids de drawables, sans extension)
    static var countries as Array<Dictionary> = [
        { :name => "France", :flag => "fr" },
        { :name => "Allemagne", :flag => "de" },
        { :name => "Espagne", :flag => "es" },
        { :name => "Italie", :flag => "it" },
        { :name => "Royaume-Uni", :flag => "gb" },
        { :name => "États-Unis", :flag => "us" },
        { :name => "Canada", :flag => "ca" },
        { :name => "Japon", :flag => "jp" },
        { :name => "Chine", :flag => "cn" },
        { :name => "Brésil", :flag => "br" },
        { :name => "Argentine", :flag => "ar" },
        { :name => "Australie", :flag => "au" },
        { :name => "Russie", :flag => "ru" },
        { :name => "Inde", :flag => "in" },
        { :name => "Mexique", :flag => "mx" },
        { :name => "Suède", :flag => "se" },
        { :name => "Norvège", :flag => "no" },
        { :name => "Pays-Bas", :flag => "nl" },
        { :name => "Suisse", :flag => "ch" },
        { :name => "Belgique", :flag => "be" },
        { :name => "Portugal", :flag => "pt" },
        { :name => "Grèce", :flag => "gr" },
        { :name => "Turquie", :flag => "tr" },
        { :name => "Égypte", :flag => "eg" },
        { :name => "Afrique du Sud", :flag => "za" },
        { :name => "Corée du Sud", :flag => "kr" },
        { :name => "Thaïlande", :flag => "th" },
        { :name => "Vietnam", :flag => "vn" },
        { :name => "Singapour", :flag => "sg" },
        { :name => "Nouvelle-Zélande", :flag => "nz" }
    ];

    static function getFlagResource(flagId as String) as ResourceId or Null {
    switch (flagId) {
        case "fr": return Rez.Drawables.fr;
        case "de": return Rez.Drawables.de;
        case "es": return Rez.Drawables.es;
        case "it": return Rez.Drawables.it;
        case "gb": return Rez.Drawables.gb;
        case "us": return Rez.Drawables.us;
        case "ca": return Rez.Drawables.ca;
        case "jp": return Rez.Drawables.jp;
        case "cn": return Rez.Drawables.cn;
        case "br": return Rez.Drawables.br;
        case "ar": return Rez.Drawables.ar;
        case "au": return Rez.Drawables.au;
        case "ru": return Rez.Drawables.ru;
        case "in": return Rez.Drawables.in;
        case "mx": return Rez.Drawables.mx;
        case "se": return Rez.Drawables.se;
        case "no": return Rez.Drawables.no;
        case "nl": return Rez.Drawables.nl;
        case "ch": return Rez.Drawables.ch;
        case "be": return Rez.Drawables.be;
        case "pt": return Rez.Drawables.pt;
        case "gr": return Rez.Drawables.gr;
        case "tr": return Rez.Drawables.tr;
        case "eg": return Rez.Drawables.eg;
        case "za": return Rez.Drawables.za;
        case "kr": return Rez.Drawables.kr;
        case "th": return Rez.Drawables.th;
        case "vn": return Rez.Drawables.vn;
        case "sg": return Rez.Drawables.sg;
        case "nz": return Rez.Drawables.nz;
        default: return null;
    }
}

    static function getRandomCountries(count as Number) as Array<Dictionary> {
        var shuffled = [] as Array<Dictionary>;
        var indices = [] as Array<Number>;
        
        // Créer un tableau d'indices
        for (var i = 0; i < countries.size(); i++) {
            indices.add(i);
        }
        
        // Mélanger les indices (Fisher-Yates shuffle)
        for (var i = indices.size() - 1; i > 0; i--) {
            var j = Math.rand() % (i + 1);
            var temp = indices[i];
            indices[i] = indices[j];
            indices[j] = temp;
        }
        
        // Prendre les premiers 'count' pays
        var maxCount = count < indices.size() ? count : indices.size();
        for (var i = 0; i < maxCount; i++) {
            shuffled.add(countries[indices[i]]);
        }
        
        return shuffled;
    }

    static function generateWrongAnswers(correctCountry as Dictionary, count as Number) as Array<String> {
        var wrongAnswers = [] as Array<String>;
        var availableCountries = [] as Array<String>;
        
        // Créer une liste des pays disponibles (sans le bon pays)
        var correctName = correctCountry[:name] as String;
        for (var i = 0; i < countries.size(); i++) {
            var currentName = countries[i][:name] as String;
            if (!currentName.equals(correctName)) {
                availableCountries.add(currentName);
            }
        }
        
        // Mélanger les pays disponibles (Fisher-Yates shuffle)
        for (var i = availableCountries.size() - 1; i > 0; i--) {
            var j = Math.rand() % (i + 1);
            var temp = availableCountries[i];
            availableCountries[i] = availableCountries[j];
            availableCountries[j] = temp;
        }
        
        // Prendre les premières mauvaises réponses
        var maxCount = count < availableCountries.size() ? count : availableCountries.size();
        for (var i = 0; i < maxCount; i++) {
            wrongAnswers.add(availableCountries[i]);
        }
        
        return wrongAnswers;
        
    }
}