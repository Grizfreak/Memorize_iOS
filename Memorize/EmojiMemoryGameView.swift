//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Antonin Aubert (i201852) on 20/01/2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var timer: GameTimer
    @ObservedObject var game: EmojiMemoryGame
    @State private var showedPopover = false
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3, game: game, timer: timer) { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture{
                        game.choose(card)
                        if game.isWon() {
                            showedPopover = true
                        }
                    }
            }
        }.popover(isPresented: $showedPopover){
            FinishedGame(showedPopover: $showedPopover, scoresManager: EmojiMemoryGame.scoresManager)
                .onDisappear(perform: game.resetGame)
        }
        .foregroundColor(game.color)
            .padding(.horizontal)
        
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                        game.resetGame()
                        self.presentationMode.wrappedValue.dismiss()
                }, label: {Text("<")
                    .font(.title)
                    .padding()})
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation(.easeInOut){
                    game.resetGame()
                    }
                }, label: {Text("Abandonner ?")})
                Spacer()
            }
        })
        .navigationBarBackButtonHidden(true)
    }
    
}

struct CardView: View{
    let card: EmojiMemoryGame.Card
    
    var body : some View {
        GeometryReader(content: { geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
                
            }
        })
        
    }
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width , size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
}






































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        let timer = GameTimer()
        EmojiMemoryGameView(timer: timer, game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(timer: timer, game: game)
            .preferredColorScheme(.light)
    }
}
                                                                                                                                                                                                                                                                                                                                                                                                             
