// source/quizz_drapeauView.mc - Version optimisée sans carré invisible
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

        // MARGES DE SÉCURITÉ RELATIVES pour éviter tout débordement
        var safeMarginX = (width * 0.05).toNumber();   // 5% de marge horizontale
        var safeMarginY = (height * 0.03).toNumber();  // 3% de marge verticale
        var safeWidth = width - (2 * safeMarginX);     // Largeur sécurisée
        var safeHeight = height - (2 * safeMarginY);   // Hauteur sécurisée

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        
        // Numéro de question et score - DANS LA ZONE SÉCURISÉE
        var questionText = _quizManager.getCurrentQuestionNumber() + "/" + 
                          _quizManager.getTotalQuestions() + 
                          " - Score: " + _quizManager.getScore();
        dc.drawText(screenCenterX, safeMarginY + (safeHeight * 0.02), Graphics.FONT_XTINY, questionText, Graphics.TEXT_JUSTIFY_CENTER);

        // Chargement du drapeau AVANT de définir la zone d'affichage
        var flagId = question[:flag] as String;
        var flagResource = getFlagResource(flagId);
        var flagBitmap = null;
        
        if (flagResource != null) {
            try {
                flagBitmap = WatchUi.loadResource(flagResource);
            } catch (e) {
                flagBitmap = null;
            }
        }
        
        // Calcul de la zone disponible pour le drapeau - DANS LES MARGES DE SÉCURITÉ
        var headerHeight = (safeHeight * 0.08).toNumber();    // 8% du safe height
        var buttonsHeight = (safeHeight * 0.35).toNumber();   // 35% du safe height
        var availableHeight = safeHeight - headerHeight - buttonsHeight;
        
        // Zone pour le drapeau - TAILLE RÉDUITE ET SÉCURISÉE
        var flagDisplayHeight = (availableHeight * 0.65).toNumber(); // 65% de l'espace disponible (plus petit)
        var flagDisplayWidth = (safeWidth * 0.65).toNumber();        // 65% de la largeur sécurisée (plus petit)
        
        // Position de début de la zone drapeau - CENTRAGE PARFAIT DANS LA ZONE SÉCURISÉE
        var flagZoneY = safeMarginY + headerHeight + ((availableHeight - flagDisplayHeight) / 2);
        
        if (flagBitmap != null) {
            // Utiliser les vraies dimensions du drapeau
            var bitmapWidth = flagBitmap.getWidth().toNumber();
            var bitmapHeight = flagBitmap.getHeight().toNumber();
            
            // Calculer le ratio d'échelle pour la taille réduite et sécurisée
            var scaleX = flagDisplayWidth.toFloat() / bitmapWidth.toFloat();
            var scaleY = flagDisplayHeight.toFloat() / bitmapHeight.toFloat();
            var scale = scaleX < scaleY ? scaleX : scaleY; // Garder les proportions
            
            // Nouvelles dimensions sécurisées
            var scaledWidth = (bitmapWidth.toFloat() * scale).toNumber();
            var scaledHeight = (bitmapHeight.toFloat() * scale).toNumber();
            
            // Position PARFAITEMENT CENTRÉE - Dans la zone sécurisée
            var flagX = screenCenterX - (scaledWidth / 2);  // Centrage horizontal
            var flagY = flagZoneY + (flagDisplayHeight - scaledHeight) / 2; // Centrage vertical
            
            // Affichage du drapeau centré et sécurisé
            dc.drawBitmap(flagX, flagY, flagBitmap);
            
        } else {
            // Fallback si le drapeau ne peut pas être chargé
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(screenCenterX, flagZoneY + (flagDisplayHeight / 2), Graphics.FONT_SMALL, 
                       flagId.toUpper(), Graphics.TEXT_JUSTIFY_CENTER);
        }

        // Options de réponse - DANS LA ZONE SÉCURISÉE
        var answers = question[:answers] as Array;
        var buttonsStartY = safeMarginY + safeHeight - buttonsHeight; // Dans la zone sécurisée
        var buttonHeight = (buttonsHeight / 3).toNumber();
        var buttonMargin = safeMarginX + (safeWidth * 0.08).toNumber(); // Marge + 8% de la largeur sécurisée
        var selectedIndex = getSelectedAnswerIndex();
        
        for (var i = 0; i < answers.size(); i++) {
            var y = buttonsStartY + (i * buttonHeight);
            var isSelected = (i == selectedIndex);
            
            // Couleurs personnalisées
            var buttonColor = isSelected ? 0x1E5631 : 0x110323ff;
            var textColor = Graphics.COLOR_WHITE;
            
            // Largeur de bouton sécurisée
            var buttonWidth = safeWidth - (2 * (safeWidth * 0.08).toNumber());
            
            dc.setColor(buttonColor, Graphics.COLOR_TRANSPARENT);
            dc.fillRoundedRectangle(buttonMargin, y + (buttonHeight * 0.05).toNumber(), 
                                  buttonWidth, 
                                  (buttonHeight * 0.85).toNumber(), 2);
            
            dc.setColor(textColor, Graphics.COLOR_TRANSPARENT);
            var answerText = answers[i] as String;
            var buttonText = (i + 1) + ". " + answerText;
            dc.drawText(screenCenterX, y + (buttonHeight * 0.35).toNumber(), 
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