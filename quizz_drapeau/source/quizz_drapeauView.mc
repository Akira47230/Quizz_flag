// source/quizz_drapeauView.mc - Version avec chargement correct des drapeaux
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class quizz_drapeauView extends WatchUi.View {
    private var _quizManager as QuizManager;
    private var _gameState as Symbol; // :menu, :playing, :result, :finalScore
    private var _delegate as Object or Null;
    private var _lastResultTitle as String;

    function initialize() {
        View.initialize();
        _quizManager = new QuizManager();
        _gameState = :menu;
        _delegate = null;
        _lastResultTitle = "";
    }

    function setDelegate(delegate as Object) as Void {
        _delegate = delegate;
    }

    function onLayout(dc as Dc) as Void {
        // Pas de layout fixe, on dessine tout manuellement
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        switch (_gameState) {
            case :menu:
                drawMenu(dc);
                break;
            case :playing:
                drawQuestion(dc);
                break;
            case :result:
                drawResult(dc);
                break;
            case :finalScore:
                drawFinalScore(dc);
                break;
        }
    }

    function drawMenu(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, centerY - 40, Graphics.FONT_MEDIUM, 
                   "Quiz Drapeaux", Graphics.TEXT_JUSTIFY_CENTER);
        
        dc.drawText(centerX, centerY - 10, Graphics.FONT_SMALL, 
                   "20 questions", Graphics.TEXT_JUSTIFY_CENTER);
                   
        dc.drawText(centerX, centerY + 20, Graphics.FONT_TINY, 
                   "SELECT pour commencer", Graphics.TEXT_JUSTIFY_CENTER);
                   
        dc.drawText(centerX, centerY + 35, Graphics.FONT_TINY, 
                   "MENU pour quitter", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function drawQuestion(dc as Dc) as Void {
        var question = _quizManager.getCurrentQuestion();
        if (question == null) {
            return;
        }

        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        
        // Numéro de question et score
        var questionText = _quizManager.getCurrentQuestionNumber() + "/" + 
                          _quizManager.getTotalQuestions() + 
                          " - Score: " + _quizManager.getScore();
        dc.drawText(centerX, 10, Graphics.FONT_TINY, questionText, Graphics.TEXT_JUSTIFY_CENTER);

        // Zone pour le drapeau
        var flagX = centerX - 40;
        var flagY = 30;
        var flagWidth = 80;
        var flagHeight = 50;
        
        // Arrière-plan pour le drapeau
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(flagX, flagY, flagWidth, flagHeight);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawRectangle(flagX, flagY, flagWidth, flagHeight);
        
        // Chargement et affichage du drapeau
        var flagLoaded = false;
        var flagId = question[:flag] as String;
        
        try {
            var flagResource = getFlagResource(flagId);
            if (flagResource != null) {
                var flagBitmap = WatchUi.loadResource(flagResource);
                if (flagBitmap != null) {
                    // Calculer la position pour centrer l'image dans la zone
                    var imgX = flagX + (flagWidth - flagBitmap.getWidth()) / 2;
                    var imgY = flagY + (flagHeight - flagBitmap.getHeight()) / 2;
                    dc.drawBitmap(imgX, imgY, flagBitmap);
                    flagLoaded = true;
                }
            }
        } catch (e) {
            // Erreur de chargement
        }
        
        // Si le chargement a échoué, afficher un placeholder
        if (!flagLoaded) {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(centerX, flagY + 15, Graphics.FONT_XTINY, 
                       "Drapeau:", Graphics.TEXT_JUSTIFY_CENTER);
            dc.drawText(centerX, flagY + 30, Graphics.FONT_SMALL, 
                       flagId.toUpper(), Graphics.TEXT_JUSTIFY_CENTER);
        }

        // Options de réponse avec sélection
        var answers = question[:answers] as Array;
        var startY = flagY + flagHeight + 15;
        var buttonHeight = 22;
        var selectedIndex = getSelectedAnswerIndex();
        
        for (var i = 0; i < answers.size(); i++) {
            var y = startY + (i * buttonHeight);
            var isSelected = (i == selectedIndex);
            
            // Couleur du bouton selon la sélection
            var buttonColor = isSelected ? Graphics.COLOR_BLUE : Graphics.COLOR_DK_GRAY;
            var textColor = isSelected ? Graphics.COLOR_WHITE : Graphics.COLOR_LT_GRAY;
            
            dc.setColor(buttonColor, Graphics.COLOR_TRANSPARENT);
            dc.fillRoundedRectangle(10, y, width - 20, buttonHeight - 2, 3);
            
            dc.setColor(textColor, Graphics.COLOR_TRANSPARENT);
            var answerText = answers[i] as String;
            var buttonText = (i + 1) + ". " + answerText;
            dc.drawText(centerX, y + 4, Graphics.FONT_XTINY, buttonText, Graphics.TEXT_JUSTIFY_CENTER);
        }
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, height - 15, Graphics.FONT_XTINY, 
                   "UP/DOWN: naviguer, SELECT: répondre", Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Fonction pour mapper les IDs de drapeaux aux ressources
    private function getFlagResource(flagId as String) as ResourceId or Null {
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

    function drawResult(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        
        // Titre de résultat
        dc.drawText(centerX, centerY - 30, Graphics.FONT_MEDIUM, 
                   _lastResultTitle, Graphics.TEXT_JUSTIFY_CENTER);

        // Score actuel
        var scoreText = "Score: " + _quizManager.getScore() + "/" + 
                       _quizManager.getCurrentQuestionNumber();
        dc.drawText(centerX, centerY, Graphics.FONT_SMALL, scoreText, Graphics.TEXT_JUSTIFY_CENTER);

        if (_quizManager.isGameFinished()) {
            dc.drawText(centerX, centerY + 25, Graphics.FONT_TINY, 
                       "SELECT pour le score final", Graphics.TEXT_JUSTIFY_CENTER);
        } else {
            dc.drawText(centerX, centerY + 25, Graphics.FONT_TINY, 
                       "SELECT pour continuer", Graphics.TEXT_JUSTIFY_CENTER);
        }
    }

    function drawFinalScore(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        
        dc.drawText(centerX, centerY - 50, Graphics.FONT_MEDIUM, 
                   "Quiz Terminé!", Graphics.TEXT_JUSTIFY_CENTER);

        var finalScore = "Score Final: " + _quizManager.getScore() + "/" + 
                        _quizManager.getTotalQuestions();
        dc.drawText(centerX, centerY - 20, Graphics.FONT_SMALL, 
                   finalScore, Graphics.TEXT_JUSTIFY_CENTER);

        var percentage = _quizManager.getScorePercentage() + "%";
        dc.drawText(centerX, centerY, Graphics.FONT_SMALL, 
                   percentage, Graphics.TEXT_JUSTIFY_CENTER);

        // Message selon le score
        var message = "";
        var percent = _quizManager.getScorePercentage();
        if (percent >= 90) {
            message = "Excellent!";
        } else if (percent >= 75) {
            message = "Très bien!";
        } else if (percent >= 50) {
            message = "Pas mal!";
        } else {
            message = "Entraînez-vous!";
        }
        
        dc.drawText(centerX, centerY + 20, Graphics.FONT_SMALL, 
                   message, Graphics.TEXT_JUSTIFY_CENTER);

        dc.drawText(centerX, centerY + 40, Graphics.FONT_TINY, 
                   "SELECT: Nouveau jeu", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(centerX, centerY + 55, Graphics.FONT_TINY, 
                   "BACK: Menu principal", Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Méthodes publiques pour le delegate
    function getQuizManager() as QuizManager {
        return _quizManager;
    }

    function getGameState() as Symbol {
        return _gameState;
    }

    function setGameState(state as Symbol) as Void {
        _gameState = state;
        WatchUi.requestUpdate();
    }

    function setResultTitle(title as String) as Void {
        _lastResultTitle = title;
    }

    function getSelectedAnswerIndex() as Number {
        // Appel sécurisé au delegate
        if (_delegate != null && _delegate has :getSelectedAnswerIndex) {
            return _delegate.getSelectedAnswerIndex();
        }
        return 0;
    }

    function onHide() as Void {
    }
}