// source/FlagData.mc - Version complète avec tous les pays ISO 3166-1 alpha-2
import Toybox.Lang;
import Toybox.Math;

class FlagData {
    // Base de données complète des pays et leurs drapeaux (format ISO 3166-1 alpha-2)
    static var countries as Array<Dictionary> = [
        // A
        { :name => "Andorre", :flag => "ad" },
        { :name => "Émirats arabes unis", :flag => "ae" },
        { :name => "Afghanistan", :flag => "af" },
        { :name => "Antigua-et-Barbuda", :flag => "ag" },
        { :name => "Anguilla", :flag => "ai" },
        { :name => "Albanie", :flag => "al" },
        { :name => "Arménie", :flag => "am" },
        { :name => "Angola", :flag => "ao" },
        { :name => "Antarctique", :flag => "aq" },
        { :name => "Argentine", :flag => "ar" },
        { :name => "Samoa américaines", :flag => "as_samoa" },
        { :name => "Autriche", :flag => "at" },
        { :name => "Australie", :flag => "au" },
        { :name => "Aruba", :flag => "aw" },
        { :name => "Îles Åland", :flag => "ax" },
        { :name => "Azerbaïdjan", :flag => "az" },

        // B
        { :name => "Bosnie-Herzégovine", :flag => "ba" },
        { :name => "Barbade", :flag => "bb" },
        { :name => "Bangladesh", :flag => "bd" },
        { :name => "Belgique", :flag => "be" },
        { :name => "Burkina Faso", :flag => "bf" },
        { :name => "Bulgarie", :flag => "bg" },
        { :name => "Bahreïn", :flag => "bh" },
        { :name => "Burundi", :flag => "bi" },
        { :name => "Bénin", :flag => "bj" },
        { :name => "Saint-Barthélemy", :flag => "bl" },
        { :name => "Bermudes", :flag => "bm" },
        { :name => "Brunei", :flag => "bn" },
        { :name => "Bolivie", :flag => "bo" },
        { :name => "Pays-Bas caribéens", :flag => "bq" },
        { :name => "Brésil", :flag => "br" },
        { :name => "Bahamas", :flag => "bs" },
        { :name => "Bhoutan", :flag => "bt" },
        { :name => "Île Bouvet", :flag => "bv" },
        { :name => "Botswana", :flag => "bw" },
        { :name => "Biélorussie", :flag => "by" },
        { :name => "Belize", :flag => "bz" },

        // C
        { :name => "Canada", :flag => "ca" },
        { :name => "Îles Cocos", :flag => "cc" },
        { :name => "République démocratique du Congo", :flag => "cd" },
        { :name => "République centrafricaine", :flag => "cf" },
        { :name => "République du Congo", :flag => "cg" },
        { :name => "Suisse", :flag => "ch" },
        { :name => "Côte d'Ivoire", :flag => "ci" },
        { :name => "Îles Cook", :flag => "ck" },
        { :name => "Chili", :flag => "cl" },
        { :name => "Cameroun", :flag => "cm" },
        { :name => "Chine", :flag => "cn" },
        { :name => "Colombie", :flag => "co" },
        { :name => "Costa Rica", :flag => "cr" },
        { :name => "Cuba", :flag => "cu" },
        { :name => "Cap-Vert", :flag => "cv" },
        { :name => "Curaçao", :flag => "cw" },
        { :name => "Île Christmas", :flag => "cx" },
        { :name => "Chypre", :flag => "cy" },
        { :name => "République tchèque", :flag => "cz" },

        // D
        { :name => "Allemagne", :flag => "de" },
        { :name => "Djibouti", :flag => "dj" },
        { :name => "Danemark", :flag => "dk" },
        { :name => "Dominique", :flag => "dm" },
        { :name => "République dominicaine", :flag => "do_republic" },
        { :name => "Algérie", :flag => "dz" },

        // E
        { :name => "Équateur", :flag => "ec" },
        { :name => "Estonie", :flag => "ee" },
        { :name => "Égypte", :flag => "eg" },
        { :name => "Sahara occidental", :flag => "eh" },
        { :name => "Érythrée", :flag => "er" },
        { :name => "Espagne", :flag => "es" },
        { :name => "Éthiopie", :flag => "et" },

        // F
        { :name => "Finlande", :flag => "fi" },
        { :name => "Fidji", :flag => "fj" },
        { :name => "Îles Malouines", :flag => "fk" },
        { :name => "Micronésie", :flag => "fm" },
        { :name => "Îles Féroé", :flag => "fo" },
        { :name => "France", :flag => "fr" },

        // G
        { :name => "Gabon", :flag => "ga" },
        { :name => "Angleterre", :flag => "gb_eng" },
        { :name => "Irlande du Nord", :flag => "gb_nir" },
        { :name => "Écosse", :flag => "gb_sct" },
        { :name => "Pays de Galles", :flag => "gb_wls" },
        { :name => "Royaume-Uni", :flag => "gb" },
        { :name => "Grenade", :flag => "gd" },
        { :name => "Géorgie", :flag => "ge" },
        { :name => "Guyane française", :flag => "gf" },
        { :name => "Guernesey", :flag => "gg" },
        { :name => "Ghana", :flag => "gh" },
        { :name => "Gibraltar", :flag => "gi" },
        { :name => "Groenland", :flag => "gl" },
        { :name => "Gambie", :flag => "gm" },
        { :name => "Guinée", :flag => "gn" },
        { :name => "Guadeloupe", :flag => "gp" },
        { :name => "Guinée équatoriale", :flag => "gq" },
        { :name => "Grèce", :flag => "gr" },
        { :name => "Géorgie du Sud", :flag => "gs" },
        { :name => "Guatemala", :flag => "gt" },
        { :name => "Guam", :flag => "gu" },
        { :name => "Guinée-Bissau", :flag => "gw" },
        { :name => "Guyana", :flag => "gy" },

        // H
        { :name => "Hong Kong", :flag => "hk" },
        { :name => "Îles Heard", :flag => "hm" },
        { :name => "Honduras", :flag => "hn" },
        { :name => "Croatie", :flag => "hr" },
        { :name => "Haïti", :flag => "ht" },
        { :name => "Hongrie", :flag => "hu" },

        // I
        { :name => "Indonésie", :flag => "id" },
        { :name => "Irlande", :flag => "ie" },
        { :name => "Israël", :flag => "il" },
        { :name => "Île de Man", :flag => "im" },
        { :name => "Inde", :flag => "in" },
        { :name => "Territoire britannique de l'océan Indien", :flag => "io" },
        { :name => "Irak", :flag => "iq" },
        { :name => "Iran", :flag => "ir" },
        { :name => "Islande", :flag => "is" },
        { :name => "Italie", :flag => "it" },

        // J
        { :name => "Jersey", :flag => "je" },
        { :name => "Jamaïque", :flag => "jm" },
        { :name => "Jordanie", :flag => "jo" },
        { :name => "Japon", :flag => "jp" },

        // K
        { :name => "Kenya", :flag => "ke" },
        { :name => "Kirghizistan", :flag => "kg" },
        { :name => "Cambodge", :flag => "kh" },
        { :name => "Kiribati", :flag => "ki" },
        { :name => "Comores", :flag => "km" },
        { :name => "Saint-Christophe-et-Niévès", :flag => "kn" },
        { :name => "Corée du Nord", :flag => "kp" },
        { :name => "Corée du Sud", :flag => "kr" },
        { :name => "Koweït", :flag => "kw" },
        { :name => "Îles Caïmans", :flag => "ky" },
        { :name => "Kazakhstan", :flag => "kz" },

        // L
        { :name => "Laos", :flag => "la" },
        { :name => "Liban", :flag => "lb" },
        { :name => "Sainte-Lucie", :flag => "lc" },
        { :name => "Liechtenstein", :flag => "li" },
        { :name => "Sri Lanka", :flag => "lk" },
        { :name => "Liberia", :flag => "lr" },
        { :name => "Lesotho", :flag => "ls" },
        { :name => "Lituanie", :flag => "lt" },
        { :name => "Luxembourg", :flag => "lu" },
        { :name => "Lettonie", :flag => "lv" },
        { :name => "Libye", :flag => "ly" },

        // M
        { :name => "Maroc", :flag => "ma" },
        { :name => "Monaco", :flag => "mc" },
        { :name => "Moldavie", :flag => "md" },
        { :name => "Monténégro", :flag => "me_montenegro" },
        { :name => "Saint-Martin", :flag => "mf" },
        { :name => "Madagascar", :flag => "mg" },
        { :name => "Îles Marshall", :flag => "mh" },
        { :name => "Macédoine du Nord", :flag => "mk" },
        { :name => "Mali", :flag => "ml" },
        { :name => "Myanmar", :flag => "mm" },
        { :name => "Mongolie", :flag => "mn" },
        { :name => "Macao", :flag => "mo" },
        { :name => "Îles Mariannes du Nord", :flag => "mp" },
        { :name => "Martinique", :flag => "mq" },
        { :name => "Mauritanie", :flag => "mr" },
        { :name => "Montserrat", :flag => "ms" },
        { :name => "Malte", :flag => "mt" },
        { :name => "Maurice", :flag => "mu" },
        { :name => "Maldives", :flag => "mv" },
        { :name => "Malawi", :flag => "mw" },
        { :name => "Mexique", :flag => "mx" },
        { :name => "Malaisie", :flag => "my" },
        { :name => "Mozambique", :flag => "mz" },

        // N
        { :name => "Namibie", :flag => "na" },
        { :name => "Nouvelle-Calédonie", :flag => "nc" },
        { :name => "Niger", :flag => "ne" },
        { :name => "Île Norfolk", :flag => "nf" },
        { :name => "Nigeria", :flag => "ng" },
        { :name => "Nicaragua", :flag => "ni" },
        { :name => "Pays-Bas", :flag => "nl" },
        { :name => "Norvège", :flag => "no" },
        { :name => "Népal", :flag => "np" },
        { :name => "Nauru", :flag => "nr" },
        { :name => "Niue", :flag => "nu" },
        { :name => "Nouvelle-Zélande", :flag => "nz" },

        // O
        { :name => "Oman", :flag => "om" },

        // P
        { :name => "Panama", :flag => "pa" },
        { :name => "Pérou", :flag => "pe" },
        { :name => "Polynésie française", :flag => "pf" },
        { :name => "Papouasie-Nouvelle-Guinée", :flag => "pg" },
        { :name => "Philippines", :flag => "ph" },
        { :name => "Pakistan", :flag => "pk" },
        { :name => "Pologne", :flag => "pl" },
        { :name => "Saint-Pierre-et-Miquelon", :flag => "pm" },
        { :name => "Îles Pitcairn", :flag => "pn" },
        { :name => "Porto Rico", :flag => "pr" },
        { :name => "Palestine", :flag => "ps" },
        { :name => "Portugal", :flag => "pt" },
        { :name => "Palau", :flag => "pw" },
        { :name => "Paraguay", :flag => "py" },

        // Q
        { :name => "Qatar", :flag => "qa" },

        // R
        { :name => "La Réunion", :flag => "re" },
        { :name => "Roumanie", :flag => "ro" },
        { :name => "Serbie", :flag => "rs" },
        { :name => "Russie", :flag => "ru" },
        { :name => "Rwanda", :flag => "rw" },

        // S
        { :name => "Arabie saoudite", :flag => "sa" },
        { :name => "Îles Salomon", :flag => "sb" },
        { :name => "Seychelles", :flag => "sc" },
        { :name => "Soudan", :flag => "sd" },
        { :name => "Suède", :flag => "se" },
        { :name => "Singapour", :flag => "sg" },
        { :name => "Sainte-Hélène", :flag => "sh" },
        { :name => "Slovénie", :flag => "si" },
        { :name => "Svalbard et Jan Mayen", :flag => "sj" },
        { :name => "Slovaquie", :flag => "sk" },
        { :name => "Sierra Leone", :flag => "sl" },
        { :name => "Saint-Marin", :flag => "sm" },
        { :name => "Sénégal", :flag => "sn" },
        { :name => "Somalie", :flag => "so" },
        { :name => "Suriname", :flag => "sr" },
        { :name => "Soudan du Sud", :flag => "ss" },
        { :name => "Sao Tomé-et-Principe", :flag => "st" },
        { :name => "El Salvador", :flag => "sv" },
        { :name => "Sint Maarten", :flag => "sx" },
        { :name => "Syrie", :flag => "sy" },
        { :name => "Eswatini", :flag => "sz" },

        // T
        { :name => "Îles Turks-et-Caïcos", :flag => "tc" },
        { :name => "Tchad", :flag => "td" },
        { :name => "Terres australes françaises", :flag => "tf" },
        { :name => "Togo", :flag => "tg" },
        { :name => "Thaïlande", :flag => "th" },
        { :name => "Tadjikistan", :flag => "tj" },
        { :name => "Tokelau", :flag => "tk" },
        { :name => "Timor oriental", :flag => "tl" },
        { :name => "Turkménistan", :flag => "tm" },
        { :name => "Tunisie", :flag => "tn" },
        { :name => "Tonga", :flag => "to" },
        { :name => "Turquie", :flag => "tr" },
        { :name => "Trinité-et-Tobago", :flag => "tt" },
        { :name => "Tuvalu", :flag => "tv" },
        { :name => "Taïwan", :flag => "tw" },
        { :name => "Tanzanie", :flag => "tz" },

        // U
        { :name => "Ukraine", :flag => "ua" },
        { :name => "Ouganda", :flag => "ug" },
        { :name => "Îles mineures éloignées des États-Unis", :flag => "um" },
        { :name => "États-Unis", :flag => "us" },
        { :name => "Uruguay", :flag => "uy" },
        { :name => "Ouzbékistan", :flag => "uz" },

        // V
        { :name => "Vatican", :flag => "va" },
        { :name => "Saint-Vincent-et-les-Grenadines", :flag => "vc" },
        { :name => "Venezuela", :flag => "ve" },
        { :name => "Îles Vierges britanniques", :flag => "vg" },
        { :name => "Îles Vierges américaines", :flag => "vi" },
        { :name => "Vietnam", :flag => "vn" },
        { :name => "Vanuatu", :flag => "vu" },

        // W
        { :name => "Wallis-et-Futuna", :flag => "wf" },
        { :name => "Samoa", :flag => "ws" },

        // X
        { :name => "Kosovo", :flag => "xk" },

        // Y
        { :name => "Yémen", :flag => "ye" },
        { :name => "Mayotte", :flag => "yt" },

        // Z
        { :name => "Afrique du Sud", :flag => "za" },
        { :name => "Zambie", :flag => "zm" },
        { :name => "Zimbabwe", :flag => "zw" }
    ];

    static function getFlagResource(flagId as String) as ResourceId or Null {
        switch (flagId) {
            // A
            case "ad": return Rez.Drawables.ad;
            case "ae": return Rez.Drawables.ae;
            case "af": return Rez.Drawables.af;
            case "ag": return Rez.Drawables.ag;
            case "ai": return Rez.Drawables.ai;
            case "al": return Rez.Drawables.al;
            case "am": return Rez.Drawables.am;
            case "ao": return Rez.Drawables.ao;
            case "aq": return Rez.Drawables.aq;
            case "ar": return Rez.Drawables.ar;
            case "as_samoa": return Rez.Drawables.as_samoa;
            case "at": return Rez.Drawables.at;
            case "au": return Rez.Drawables.au;
            case "aw": return Rez.Drawables.aw;
            case "ax": return Rez.Drawables.ax;
            case "az": return Rez.Drawables.az;

            // B
            case "ba": return Rez.Drawables.ba;
            case "bb": return Rez.Drawables.bb;
            case "bd": return Rez.Drawables.bd;
            case "be": return Rez.Drawables.be;
            case "bf": return Rez.Drawables.bf;
            case "bg": return Rez.Drawables.bg;
            case "bh": return Rez.Drawables.bh;
            case "bi": return Rez.Drawables.bi;
            case "bj": return Rez.Drawables.bj;
            case "bl": return Rez.Drawables.bl;
            case "bm": return Rez.Drawables.bm;
            case "bn": return Rez.Drawables.bn;
            case "bo": return Rez.Drawables.bo;
            case "bq": return Rez.Drawables.bq;
            case "br": return Rez.Drawables.br;
            case "bs": return Rez.Drawables.bs;
            case "bt": return Rez.Drawables.bt;
            case "bv": return Rez.Drawables.bv;
            case "bw": return Rez.Drawables.bw;
            case "by": return Rez.Drawables.by;
            case "bz": return Rez.Drawables.bz;

            // C
            case "ca": return Rez.Drawables.ca;
            case "cc": return Rez.Drawables.cc;
            case "cd": return Rez.Drawables.cd;
            case "cf": return Rez.Drawables.cf;
            case "cg": return Rez.Drawables.cg;
            case "ch": return Rez.Drawables.ch;
            case "ci": return Rez.Drawables.ci;
            case "ck": return Rez.Drawables.ck;
            case "cl": return Rez.Drawables.cl;
            case "cm": return Rez.Drawables.cm;
            case "cn": return Rez.Drawables.cn;
            case "co": return Rez.Drawables.co;
            case "cr": return Rez.Drawables.cr;
            case "cu": return Rez.Drawables.cu;
            case "cv": return Rez.Drawables.cv;
            case "cw": return Rez.Drawables.cw;
            case "cx": return Rez.Drawables.cx;
            case "cy": return Rez.Drawables.cy;
            case "cz": return Rez.Drawables.cz;

            // D
            case "de": return Rez.Drawables.de;
            case "dj": return Rez.Drawables.dj;
            case "dk": return Rez.Drawables.dk;
            case "dm": return Rez.Drawables.dm;
            case "do_republic": return Rez.Drawables.do_republic;
            case "dz": return Rez.Drawables.dz;

            // E
            case "ec": return Rez.Drawables.ec;
            case "ee": return Rez.Drawables.ee;
            case "eg": return Rez.Drawables.eg;
            case "eh": return Rez.Drawables.eh;
            case "er": return Rez.Drawables.er;
            case "es": return Rez.Drawables.es;
            case "et": return Rez.Drawables.et;

            // F
            case "fi": return Rez.Drawables.fi;
            case "fj": return Rez.Drawables.fj;
            case "fk": return Rez.Drawables.fk;
            case "fm": return Rez.Drawables.fm;
            case "fo": return Rez.Drawables.fo;
            case "fr": return Rez.Drawables.fr;

            // G
            case "ga": return Rez.Drawables.ga;
            case "gb_eng": return Rez.Drawables.gb_eng;
            case "gb_nir": return Rez.Drawables.gb_nir;
            case "gb_sct": return Rez.Drawables.gb_sct;
            case "gb_wls": return Rez.Drawables.gb_wls;
            case "gb": return Rez.Drawables.gb;
            case "gd": return Rez.Drawables.gd;
            case "ge": return Rez.Drawables.ge;
            case "gf": return Rez.Drawables.gf;
            case "gg": return Rez.Drawables.gg;
            case "gh": return Rez.Drawables.gh;
            case "gi": return Rez.Drawables.gi;
            case "gl": return Rez.Drawables.gl;
            case "gm": return Rez.Drawables.gm;
            case "gn": return Rez.Drawables.gn;
            case "gp": return Rez.Drawables.gp;
            case "gq": return Rez.Drawables.gq;
            case "gr": return Rez.Drawables.gr;
            case "gs": return Rez.Drawables.gs;
            case "gt": return Rez.Drawables.gt;
            case "gu": return Rez.Drawables.gu;
            case "gw": return Rez.Drawables.gw;
            case "gy": return Rez.Drawables.gy;

            // H
            case "hk": return Rez.Drawables.hk;
            case "hm": return Rez.Drawables.hm;
            case "hn": return Rez.Drawables.hn;
            case "hr": return Rez.Drawables.hr;
            case "ht": return Rez.Drawables.ht;
            case "hu": return Rez.Drawables.hu;

            // I
            case "id": return Rez.Drawables.id;
            case "ie": return Rez.Drawables.ie;
            case "il": return Rez.Drawables.il;
            case "im": return Rez.Drawables.im;
            case "in": return Rez.Drawables.in;
            case "io": return Rez.Drawables.io;
            case "iq": return Rez.Drawables.iq;
            case "ir": return Rez.Drawables.ir;
            case "is": return Rez.Drawables.is;
            case "it": return Rez.Drawables.it;

            // J
            case "je": return Rez.Drawables.je;
            case "jm": return Rez.Drawables.jm;
            case "jo": return Rez.Drawables.jo;
            case "jp": return Rez.Drawables.jp;

            // K
            case "ke": return Rez.Drawables.ke;
            case "kg": return Rez.Drawables.kg;
            case "kh": return Rez.Drawables.kh;
            case "ki": return Rez.Drawables.ki;
            case "km": return Rez.Drawables.km;
            case "kn": return Rez.Drawables.kn;
            case "kp": return Rez.Drawables.kp;
            case "kr": return Rez.Drawables.kr;
            case "kw": return Rez.Drawables.kw;
            case "ky": return Rez.Drawables.ky;
            case "kz": return Rez.Drawables.kz;

            // L
            case "la": return Rez.Drawables.la;
            case "lb": return Rez.Drawables.lb;
            case "lc": return Rez.Drawables.lc;
            case "li": return Rez.Drawables.li;
            case "lk": return Rez.Drawables.lk;
            case "lr": return Rez.Drawables.lr;
            case "ls": return Rez.Drawables.ls;
            case "lt": return Rez.Drawables.lt;
            case "lu": return Rez.Drawables.lu;
            case "lv": return Rez.Drawables.lv;
            case "ly": return Rez.Drawables.ly;

            // M
            case "ma": return Rez.Drawables.ma;
            case "mc": return Rez.Drawables.mc;
            case "md": return Rez.Drawables.md;
            case "me_montenegro": return Rez.Drawables.me_montenegro;
            case "mf": return Rez.Drawables.mf;
            case "mg": return Rez.Drawables.mg;
            case "mh": return Rez.Drawables.mh;
            case "mk": return Rez.Drawables.mk;
            case "ml": return Rez.Drawables.ml;
            case "mm": return Rez.Drawables.mm;
            case "mn": return Rez.Drawables.mn;
            case "mo": return Rez.Drawables.mo;
            case "mp": return Rez.Drawables.mp;
            case "mq": return Rez.Drawables.mq;
            case "mr": return Rez.Drawables.mr;
            case "ms": return Rez.Drawables.ms;
            case "mt": return Rez.Drawables.mt;
            case "mu": return Rez.Drawables.mu;
            case "mv": return Rez.Drawables.mv;
            case "mw": return Rez.Drawables.mw;
            case "mx": return Rez.Drawables.mx;
            case "my": return Rez.Drawables.my;
            case "mz": return Rez.Drawables.mz;

            // N
            case "na": return Rez.Drawables.na;
            case "nc": return Rez.Drawables.nc;
            case "ne": return Rez.Drawables.ne;
            case "nf": return Rez.Drawables.nf;
            case "ng": return Rez.Drawables.ng;
            case "ni": return Rez.Drawables.ni;
            case "nl": return Rez.Drawables.nl;
            case "no": return Rez.Drawables.no;
            case "np": return Rez.Drawables.np;
            case "nr": return Rez.Drawables.nr;
            case "nu": return Rez.Drawables.nu;
            case "nz": return Rez.Drawables.nz;

            // O
            case "om": return Rez.Drawables.om;

            // P
            case "pa": return Rez.Drawables.pa;
            case "pe": return Rez.Drawables.pe;
            case "pf": return Rez.Drawables.pf;
            case "pg": return Rez.Drawables.pg;
            case "ph": return Rez.Drawables.ph;
            case "pk": return Rez.Drawables.pk;
            case "pl": return Rez.Drawables.pl;
            case "pm": return Rez.Drawables.pm;
            case "pn": return Rez.Drawables.pn;
            case "pr": return Rez.Drawables.pr;
            case "ps": return Rez.Drawables.ps;
            case "pt": return Rez.Drawables.pt;
            case "pw": return Rez.Drawables.pw;
            case "py": return Rez.Drawables.py;

            // Q
            case "qa": return Rez.Drawables.qa;

            // R
            case "re": return Rez.Drawables.re;
            case "ro": return Rez.Drawables.ro;
            case "rs": return Rez.Drawables.rs;
            case "ru": return Rez.Drawables.ru;
            case "rw": return Rez.Drawables.rw;

            // S
            case "sa": return Rez.Drawables.sa;
            case "sb": return Rez.Drawables.sb;
            case "sc": return Rez.Drawables.sc;
            case "sd": return Rez.Drawables.sd;
            case "se": return Rez.Drawables.se;
            case "sg": return Rez.Drawables.sg;
            case "sh": return Rez.Drawables.sh;
            case "si": return Rez.Drawables.si;
            case "sj": return Rez.Drawables.sj;
            case "sk": return Rez.Drawables.sk;
            case "sl": return Rez.Drawables.sl;
            case "sm": return Rez.Drawables.sm;
            case "sn": return Rez.Drawables.sn;
            case "so": return Rez.Drawables.so;
            case "sr": return Rez.Drawables.sr;
            case "ss": return Rez.Drawables.ss;
            case "st": return Rez.Drawables.st;
            case "sv": return Rez.Drawables.sv;
            case "sx": return Rez.Drawables.sx;
            case "sy": return Rez.Drawables.sy;
            case "sz": return Rez.Drawables.sz;

            // T
            case "tc": return Rez.Drawables.tc;
            case "td": return Rez.Drawables.td;
            case "tf": return Rez.Drawables.tf;
            case "tg": return Rez.Drawables.tg;
            case "th": return Rez.Drawables.th;
            case "tj": return Rez.Drawables.tj;
            case "tk": return Rez.Drawables.tk;
            case "tl": return Rez.Drawables.tl;
            case "tm": return Rez.Drawables.tm;
            case "tn": return Rez.Drawables.tn;
            case "to": return Rez.Drawables.to;
            case "tr": return Rez.Drawables.tr;
            case "tt": return Rez.Drawables.tt;
            case "tv": return Rez.Drawables.tv;
            case "tw": return Rez.Drawables.tw;
            case "tz": return Rez.Drawables.tz;

            // U
            case "ua": return Rez.Drawables.ua;
            case "ug": return Rez.Drawables.ug;
            case "um": return Rez.Drawables.um;
            case "us": return Rez.Drawables.us;
            case "uy": return Rez.Drawables.uy;
            case "uz": return Rez.Drawables.uz;

            // V
            case "va": return Rez.Drawables.va;
            case "vc": return Rez.Drawables.vc;
            case "ve": return Rez.Drawables.ve;
            case "vg": return Rez.Drawables.vg;
            case "vi": return Rez.Drawables.vi;
            case "vn": return Rez.Drawables.vn;
            case "vu": return Rez.Drawables.vu;

            // W
            case "wf": return Rez.Drawables.wf;
            case "ws": return Rez.Drawables.ws;

            // X
            case "xk": return Rez.Drawables.xk;

            // Y
            case "ye": return Rez.Drawables.ye;
            case "yt": return Rez.Drawables.yt;

            // Z
            case "za": return Rez.Drawables.za;
            case "zm": return Rez.Drawables.zm;
            case "zw": return Rez.Drawables.zw;

            default: return null;
        }
    }

    static function getRandomCountries(count as Number) as Array<Dictionary> {
        var shuffled = [] as Array<Dictionary>;
        var totalCountries = countries.size();
        var usedIndices = [] as Array<Number>;
        
        // Générer directement des indices aléatoires au lieu de mélanger tout
        var attempts = 0;
        var maxAttempts = count * 3; // Limite de sécurité
        
        while (shuffled.size() < count && attempts < maxAttempts) {
            var randomIndex = Math.rand() % totalCountries;
            
            // Vérifier qu'on n'a pas déjà utilisé cet index
            if (!containsIndex(usedIndices, randomIndex)) {
                shuffled.add(countries[randomIndex]);
                usedIndices.add(randomIndex);
            }
            
            attempts++;
        }
        
        // Si on n'a pas assez de pays, compléter séquentiellement
        if (shuffled.size() < count) {
            for (var i = 0; i < totalCountries && shuffled.size() < count; i++) {
                if (!containsIndex(usedIndices, i)) {
                    shuffled.add(countries[i]);
                }
            }
        }
        
        return shuffled;
    }

    // Version optimisée pour éviter le timeout du watchdog
    static function generateWrongAnswers(correctCountry as Dictionary, count as Number) as Array<String> {
        var wrongAnswers = [] as Array<String>;
        var correctName = correctCountry[:name] as String;
        var totalCountries = countries.size();
        
        // Générer des indices aléatoires directement au lieu de mélanger tout le tableau
        var usedIndices = [] as Array<Number>;
        var attempts = 0;
        var maxAttempts = count * 5; // Limite pour éviter les boucles infinies
        
        while (wrongAnswers.size() < count && attempts < maxAttempts) {
            var randomIndex = Math.rand() % totalCountries;
            var candidateName = countries[randomIndex][:name] as String;
            
            // Vérifier que ce n'est pas la bonne réponse et qu'on ne l'a pas déjà utilisée
            if (!candidateName.equals(correctName) && !containsIndex(usedIndices, randomIndex)) {
                wrongAnswers.add(candidateName);
                usedIndices.add(randomIndex);
            }
            
            attempts++;
        }
        
        // Si on n'a pas assez de réponses, compléter avec les premières disponibles
        if (wrongAnswers.size() < count) {
            for (var i = 0; i < totalCountries && wrongAnswers.size() < count; i++) {
                var candidateName = countries[i][:name] as String;
                if (!candidateName.equals(correctName) && !containsString(wrongAnswers, candidateName)) {
                    wrongAnswers.add(candidateName);
                }
            }
        }
        
        return wrongAnswers;
    }
    
    // Fonction helper pour vérifier si un tableau contient un index
    private static function containsIndex(array as Array<Number>, value as Number) as Boolean {
        for (var i = 0; i < array.size(); i++) {
            if (array[i] == value) {
                return true;
            }
        }
        return false;
    }
    
    // Fonction helper pour vérifier si un tableau contient une chaîne
    private static function containsString(array as Array<String>, value as String) as Boolean {
        for (var i = 0; i < array.size(); i++) {
            if (array[i].equals(value)) {
                return true;
            }
        }
        return false;
    }
}