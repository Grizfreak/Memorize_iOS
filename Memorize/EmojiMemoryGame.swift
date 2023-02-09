//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Antonin Aubert (i201852) on 26/01/2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    static var themeManager = EmojiThemeManager()
    static var scoresManager = EmojiScoresManager()
    
    
    private var min_value = 24;
    
    static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(themeManager: themeManager, scoresManager: scoresManager)
    }
    
    @Published  private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    var color: Color {
        model.currentTheme.card_color
    }
    
    var score: Int {
        model.score
    }
    
    var timer: GameTimer {
        model.timer
    }
    
    var actualTime: Int {
        model.actualTime
    }
    
    var lastTime: Int {
        model.actualTime
    }
    
    // MARK: - Intents
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func resetGame() {
        model.resetGame()
    }
    
    func isWon() -> Bool {
        return model.wonGame
    }
}
