// source/FlagData.mc
import Toybox.Lang;

class FlagData {
    // Base de données des pays et leurs drapeaux
    static var countries = [
        { :name => "France", :flag => "france.png" },
        { :name => "Allemagne", :flag => "germany.png" },
        { :name => "Espagne", :flag => "spain.png" },
        { :name => "Italie", :flag => "italy.png" },
        { :name => "Royaume-Uni", :flag => "uk.png" },
        { :name => "États-Unis", :flag => "usa.png" },
        { :name => "Canada", :flag => "canada.png" },
        { :name => "Japon", :flag => "japan.png" },
        { :name => "Chine", :flag => "china.png" },
        { :name => "Brésil", :flag => "brazil.png" },
        { :name => "Argentine", :flag => "argentina.png" },
        { :name => "Australie", :flag => "australia.png" },
        { :name => "Russie", :flag => "russia.png" },
        { :name => "Inde", :flag => "india.png" },
        { :name => "Mexique", :flag => "mexico.png" },
        { :name => "Suède", :flag => "sweden.png" },
        { :name => "Norvège", :flag => "norway.png" },
        { :name => "Pays-Bas", :flag => "netherlands.png" },
        { :name => "Suisse", :flag => "switzerland.png" },
        { :name => "Belgique", :flag => "belgium.png" },
        { :name => "Portugal", :flag => "portugal.png" },
        { :name => "Grèce", :flag => "greece.png" },
        { :name => "Turquie", :flag => "turkey.png" },
        { :name => "Égypte", :flag => "egypt.png" },
        { :name => "Afrique du Sud", :flag => "south_africa.png" },
        { :name => "Corée du Sud", :flag => "south_korea.png" },
        { :name => "Thaïlande", :flag => "thailand.png" },
        { :name => "Vietnam", :flag => "vietnam.png" },
        { :name => "Singapour", :flag => "singapore.png" },
        { :name => "Nouvelle-Zélande", :flag => "new_zealand.png" }
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