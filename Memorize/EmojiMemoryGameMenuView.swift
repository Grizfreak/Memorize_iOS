//
//  EmojiMemoryGameMenu.swift
//  Memorize
//
//  Created by Antonin Aubert (i201852) on 04/03/2022.
//

import SwiftUI

struct EmojiMemoryGameMenuView: View {
    var game: EmojiMemoryGame
    var timer: GameTimer
    var body: some View {
            NavigationView{
                VStack{
                    Text("Jeu du memory").font(.largeTitle).padding()
                    Spacer()
                    NavigationLink(destination:EmojiMemoryGameView(timer: timer, game: game).onAppear(perform: {
                        game.resetGame()
                    })) {
                        Text("Jouer").font(.title)
                    }
                    .navigationTitle("")
                    Spacer()
                    NavigationLink(destination:EmojiMemoryGameScoresView(scores: EmojiMemoryGame.scoresManager)) {
                        Text("Scores").font(.title)
                    }
                    Spacer()
                }
            }
    }
    
    
}



struct EmojiMemoryGameMenu_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        let timer = GameTimer()
        EmojiMemoryGameMenuView(game: game,timer: timer)
    }
}
