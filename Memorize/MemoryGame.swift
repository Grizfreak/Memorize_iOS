//
//  MemoryGame.swift
//  Memorize
//
//  Created by Antonin Aubert (i201852) on 26/01/2022.
//

import Foundation
import SwiftUI


struct MemoryGame<CardContent> where CardContent: Equatable{
    typealias EmojiScore = EmojiScoresManager.EmojiScore
    private(set) var cards : Array<Card>
    private(set) var themeManager: EmojiThemeManager
    private(set) var scoresManager: EmojiScoresManager
    private(set) var currentTheme: EmojiTheme
    private(set) var score: Int
    private(set) var actualTime: Int
    private(set) var lastTime: Int
    private(set) var false_turns: Int
    private(set) var wonGame: Bool
    private(set) var timer: GameTimer
    
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly }
        set { cards.indices.forEach({cards[$0].isFaceUp = ($0 == newValue) }) }
    }
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }
                cards[chosenIndex].isFaceUp = true;
                if cards.indices.filter({cards[$0].isMatched}).count == cards.count {
                    //Function used in case of winning the game
                    self.createNewScore()
                }
                if !cards[chosenIndex].hasBeenAlreadyRevealed{
                    cards[chosenIndex].hasBeenAlreadyRevealed = true
                    return
                }
                if(cards[chosenIndex].hasBeenAlreadyRevealed || cards[potentialMatchIndex].hasBeenAlreadyRevealed){
                    score -= 1
                }
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                
            }
        }
    }
    
   mutating func resetGame() {
       self.lastTime = self.timer.getTime()
       self.timer.stopTimer()
       self.score = 0
       self.wonGame = false
       cards.indices.forEach({cards[$0].isFaceUp = false ; cards[$0].isMatched = false})
       currentTheme = themeManager.getRandomTheme()
       let cards_tab = currentTheme.card_contents
       changeTheme(numberOfPairsOfCards: cards_tab.count) {pairIndex in cards_tab[pairIndex] as! CardContent}
       self.timer.resetTimer()
       cards.shuffle()
    }
    
    mutating func changeTheme(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards.removeAll()
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id:pairIndex*2+1))
        }
    }
    
    mutating func createNewScore() {
        self.lastTime = self.timer.getTime()
        self.timer.stopTimer()
        self.scoresManager.addScore(score: self.score, time: self.lastTime, theme: self.currentTheme, date: Date())
        self.wonGame = true
    }
    
    init (themeManager: EmojiThemeManager, scoresManager: EmojiScoresManager){
        self.score = 0
        self.false_turns = 0
        self.wonGame = false
        self.lastTime = 0
        self.scoresManager = scoresManager
        self.themeManager = themeManager
        self.actualTime = 0
        currentTheme = themeManager.getRandomTheme()
        let cards_tab = currentTheme.card_contents
        self.cards = []
        self.timer = GameTimer()
        //ADD numberOfPairsOfCards x 2 cards to cards array
        changeTheme(numberOfPairsOfCards: cards_tab.count) {pairIndex in cards_tab[pairIndex] as! CardContent}
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        //Content of my card
        var isFaceUp = false
        var isMatched = false
        var hasBeenAlreadyRevealed = false
        let content: CardContent
        //TODO Verify first time matching
        //Identifier in hash
        let id: Int
    }
    
}

extension Array {
    var oneAndOnly : Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
