// source/quizz_drapeauDelegate.mc - Version corrigée
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class quizz_drapeauDelegate extends WatchUi.BehaviorDelegate {
    private var _view as quizz_drapeauView;
    private var _selectedAnswerIndex as Number;

    function initialize(view as quizz_drapeauView) {
        BehaviorDelegate.initialize();
        _view = view;
        _selectedAnswerIndex = 0;
        // Lier le delegate à la vue pour la sélection visuelle
        _view.setDelegate(self);
    }

    function onSelect() as Boolean {
        var gameState = _view.getGameState();
        var quizManager = _view.getQuizManager();
        
        switch (gameState) {
            case :menu:
                // Commencer un nouveau jeu
                quizManager.startNewGame();
                _view.setGameState(:playing);
                _selectedAnswerIndex = 0;
                return true;
                
            case :playing:
                // Répondre à la question
                var isCorrect = quizManager.answerQuestion(_selectedAnswerIndex);
                
                // Afficher SEULEMENT le résultat - SIMPLIFIÉ
                if (isCorrect) {
                    _view.setResultTitle("✓ CORRECT");
                } else {
                    _view.setResultTitle("✗ INCORRECT");
                }
                
                // Transition automatique vers l'écran de résultat
                _view.setGameState(:result);
                return true;
                
            case :result:
                // Plus de gestion manuelle, le timer automatique s'en charge
                return false;
                
            case :finalScore:
                // Commencer un nouveau jeu
                quizManager.startNewGame();
                _view.setGameState(:playing);
                _selectedAnswerIndex = 0;
                return true;
        }
        
        return false;
    }

    function onBack() as Boolean {
        var gameState = _view.getGameState();
        
        if (gameState == :finalScore) {
            _view.setGameState(:menu);
            return true;
        } else if (gameState == :playing || gameState == :result) {
            // Retour au menu principal (abandon du jeu)
            _view.setGameState(:menu);
            return true;
        }
        
        return false;
    }

    function onNextPage() as Boolean {
        return navigateAnswers(1);
    }

    function onPreviousPage() as Boolean {
        return navigateAnswers(-1);
    }

    private function navigateAnswers(direction as Number) as Boolean {
        var gameState = _view.getGameState();
        
        if (gameState == :playing) {
            var quizManager = _view.getQuizManager();
            var question = quizManager.getCurrentQuestion();
            
            if (question != null) {
                var answers = question[:answers] as Array;
                var newIndex = _selectedAnswerIndex + direction;
                
                // Gestion circulaire des réponses (3 réponses)
                if (newIndex >= answers.size()) {
                    newIndex = 0;
                } else if (newIndex < 0) {
                    newIndex = answers.size() - 1;
                }
                
                _selectedAnswerIndex = newIndex;
                WatchUi.requestUpdate();
                return true;
            }
        }
        
        return false;
    }

    function onMenu() as Boolean {
        var gameState = _view.getGameState();
        
        if (gameState == :menu) {
            // Quitter l'application
            System.exit();
        } else {
            // Retour au menu principal
            _view.setGameState(:menu);
        }
        
        return true;
    }

    // Getter pour l'index de réponse sélectionnée
    function getSelectedAnswerIndex() as Number {
        return _selectedAnswerIndex;
    }

    // Réinitialiser la sélection pour la question suivante
    function resetSelectedAnswerIndex() as Void {
        _selectedAnswerIndex = 0;
    }
}