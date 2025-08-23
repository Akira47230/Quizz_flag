// source/quizz_drapeauView.mc - Version propre sans mosaïque
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Timer;

class quizz_drapeauView extends WatchUi.View {
    private var _quizManager as QuizManager;
    private var _gameState as Symbol; // :menu, :playing, :result, :finalScore
    private var _delegate as Object or Null;
    private var _lastResultTitle as String;
    private var _resultTimer as Timer.Timer or Null;

    function initialize() {
        View.initialize();
        _quizManager = new QuizManager();
        _gameState = :menu;
        _delegate = null;
        _lastResultTitle = "";
        _resultTimer = null;
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
        var screenCenterX = width / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        
        // Numéro de question et score
        var questionText = _quizManager.getCurrentQuestionNumber() + "/" + 
                          _quizManager.getTotalQuestions() + 
                          " - Score: " + _quizManager.getScore();
        dc.drawText(screenCenterX, height * 0.05, Graphics.FONT_TINY, questionText, Graphics.TEXT_JUSTIFY_CENTER);

        // Zone pour le drapeau - DIMENSIONS RELATIVES AUGMENTÉES DE 15%
        var flagWidth = (width * 0.805).toNumber();   // 70% * 1.15 = 80.5% de la largeur d'écran
        var flagHeight = (height * 0.4025).toNumber(); // 35% * 1.15 = 40.25% de la hauteur d'écran
        var flagX = screenCenterX - (flagWidth / 2);
        var flagY = (height * 0.15).toNumber();      // Commence à 15% du haut
        
        // SUPPRIMÉ: Plus de rectangle gris de fond
        // dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        // dc.fillRectangle(flagX, flagY, flagWidth, flagHeight);
        // dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        // dc.drawRectangle(flagX, flagY, flagWidth, flagHeight);
        
        // Chargement et affichage du drapeau - SANS FOND
        var flagId = question[:flag] as String;
        var flagResource = getFlagResource(flagId);
        
        if (flagResource != null) {
            try {
                var flagBitmap = WatchUi.loadResource(flagResource);
                if (flagBitmap != null) {
                    // Centrer l'image dans la zone définie
                    var bitmapWidth = flagBitmap.getWidth().toNumber();
                    var bitmapHeight = flagBitmap.getHeight().toNumber();
                    
                    var imgX = flagX + (flagWidth - bitmapWidth) / 2;
                    var imgY = flagY + (flagHeight - bitmapHeight) / 2;
                    
                    // Dessiner le drapeau directement sur le fond noir
                    dc.drawBitmap(imgX, imgY, flagBitmap);
                } else {
                    // Fallback si le bitmap ne peut pas être chargé
                    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
                    dc.drawText(screenCenterX, flagY + flagHeight/2, Graphics.FONT_SMALL, 
                               flagId.toUpper(), Graphics.TEXT_JUSTIFY_CENTER);
                }
            } catch (e) {
                // Fallback en cas d'erreur
                dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
                dc.drawText(screenCenterX, flagY + flagHeight/2, Graphics.FONT_SMALL, 
                           flagId.toUpper(), Graphics.TEXT_JUSTIFY_CENTER);
            }
        } else {
            // Fallback si la ressource n'existe pas
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(screenCenterX, flagY + flagHeight/2, Graphics.FONT_SMALL, 
                       flagId.toUpper(), Graphics.TEXT_JUSTIFY_CENTER);
        }

        // Options de réponse - LARGEUR RÉDUITE ET NOUVELLES COULEURS
        var answers = question[:answers] as Array;
        var buttonsStartY = (height * 0.6).toNumber();   // Ajusté à 60% pour compenser drapeau plus grand
        var buttonHeight = (height * 0.12).toNumber();   // 12% de hauteur d'écran par bouton
        var buttonMargin = (width * 0.15).toNumber();    // AUGMENTÉ: 15% de marge (au lieu de 5%)
        var selectedIndex = getSelectedAnswerIndex();
        
        for (var i = 0; i < answers.size(); i++) {
            var y = buttonsStartY + (i * buttonHeight);
            var isSelected = (i == selectedIndex);
            
            // NOUVELLES COULEURS PERSONNALISÉES
            var buttonColor = isSelected ? 0x1E5631 : 0x9F7E69;  // Vert foncé si sélectionné, beige sinon
            var textColor = Graphics.COLOR_WHITE;  // Texte blanc pour contraste sur les deux couleurs
            
            dc.setColor(buttonColor, Graphics.COLOR_TRANSPARENT);
            dc.fillRoundedRectangle(buttonMargin, y, width - (2 * buttonMargin), 
                                  (buttonHeight * 0.8).toNumber(), 3);
            
            dc.setColor(textColor, Graphics.COLOR_TRANSPARENT);
            var answerText = answers[i] as String;
            var buttonText = (i + 1) + ". " + answerText;
            dc.drawText(screenCenterX, y + (buttonHeight * 0.2).toNumber(), 
                       Graphics.FONT_XTINY, buttonText, Graphics.TEXT_JUSTIFY_CENTER);
        }
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
        
        // Afficher seulement si c'est correct ou incorrect - SIMPLIFIÉ
        dc.drawText(centerX, centerY, Graphics.FONT_LARGE, 
                   _lastResultTitle, Graphics.TEXT_JUSTIFY_CENTER);
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
        
        if (state == :result) {
            startResultTimer();
        } else {
            stopResultTimer();
        }
        
        WatchUi.requestUpdate();
    }

    function setResultTitle(title as String) as Void {
        _lastResultTitle = title;
    }

    function getSelectedAnswerIndex() as Number {
        if (_delegate != null && _delegate has :getSelectedAnswerIndex) {
            return _delegate.getSelectedAnswerIndex();
        }
        return 0;
    }

    private function startResultTimer() as Void {
        stopResultTimer();
        
        _resultTimer = new Timer.Timer();
        _resultTimer.start(method(:onResultTimerCallback), 2000, false);
    }

    private function stopResultTimer() as Void {
        if (_resultTimer != null) {
            _resultTimer.stop();
            _resultTimer = null;
        }
    }

    function onResultTimerCallback() as Void {
        if (_gameState == :result) {
            if (_quizManager.isGameFinished()) {
                setGameState(:finalScore);
            } else {
                setGameState(:playing);
                if (_delegate != null && _delegate has :resetSelectedAnswerIndex) {
                    _delegate.resetSelectedAnswerIndex();
                }
            }
        }
    }

    function onHide() as Void {
        stopResultTimer();
    }
}