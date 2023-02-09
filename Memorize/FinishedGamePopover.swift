//
//  ViewController.swift
//  Memorize
//
//  Created by Antonin Aubert (i201852) on 25/02/2022.
//

import SwiftUI
struct FinishedGame: View{
    @Binding var showedPopover: Bool
    var scoresManager: EmojiScoresManager
    var body: some View {
        VStack{
            Spacer()
            HStack {
                Text("🎉 Bien joué tu as gagné ! 🎊\n Tu peux maintenant rejouer pour t'améliorer !")
                    .font(.title)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(.cyan)
                    .cornerRadius(10)
                    .shadow(radius: 15.0)
            }
            Text("Score : \(scoresManager.lastItemSaved!.score)")
            Text("Time : \(scoresManager.lastItemSaved!.time) sec")
            
            
            Spacer()
                Button(action: {
                    showedPopover = false
                }) {
                    HStack {
                        Text("Rejouer ?")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                    }
                    
                }
                .tint(.blue)
                .buttonStyle(.bordered)
                .controlSize(.large)
            
            
        }
    }
}






struct FinishedGame_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        let timer = GameTimer()
        EmojiMemoryGameView(timer: timer, game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(timer: timer, game: game)
            .preferredColorScheme(.light)
    }
}


