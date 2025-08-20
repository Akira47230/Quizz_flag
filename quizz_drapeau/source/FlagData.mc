// source/FlagData.mc
import Toybox.Lang;
import Toybox.Math;

class FlagData {
    // Base de données des pays et leurs drapeaux (ids de drawables, sans extension)
    static var countries = [
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

    static function getRandomCountries(count as Number) as Array<Dictionary> {
        var shuffled = [];
        var indices = [];
        
        // Créer un tableau d'indices
        for (var i = 0; i < countries.size(); i++) {
            indices.add(i);
        }
        
        // Mélanger les indices
        for (var i = indices.size() - 1; i > 0; i--) {
            var j = Math.rand() % (i + 1);
            var temp = indices[i];
            indices[i] = indices[j];
            indices[j] = temp;
        }
        
        // Prendre les premiers 'count' pays
        for (var i = 0; i < count && i < indices.size(); i++) {
            shuffled.add(countries[indices[i]]);
        }
        
        return shuffled;
    }

    static function generateWrongAnswers(correctCountry as Dictionary, count as Number) as Array<String> {
        var wrongAnswers = [];
        var availableCountries = [];
        
        // Créer une liste des pays disponibles (sans le bon pays)
        for (var i = 0; i < countries.size(); i++) {
            if (!countries[i][:name].equals(correctCountry[:name])) {
                availableCountries.add(countries[i][:name]);
            }
        }
        
        // Mélanger et prendre les premières réponses
        for (var i = availableCountries.size() - 1; i > 0; i--) {
            var j = Math.rand() % (i + 1);
            var temp = availableCountries[i];
            availableCountries[i] = availableCountries[j];
            availableCountries[j] = temp;
        }
        
        for (var i = 0; i < count && i < availableCountries.size(); i++) {
            wrongAnswers.add(availableCountries[i]);
        }
        
        return wrongAnswers;
    }
}