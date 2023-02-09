//
//  EmojiScoreView.swift
//  Memorize
//
//  Created by Antonin Aubert (i201852) on 17/03/2022.
//

import SwiftUI

struct EmojiScoreView: View {
    var score: EmojiScoresManager.EmojiScore
    var body: some View {
        VStack{
            Group {
                Spacer()
                Text("\(score.score) pts")
                    .font(Font.custom("ScoreFont", size: 40))
                    .foregroundColor(.blue)
                Spacer()
                    Text("en \(score.time) sec")
                        .font(Font.custom("ScoreFont", size: 40))
                        .foregroundColor(.red)
            }
            Group {
                Spacer()
                Text("sur le thème \(score.theme)")
                    .font(Font.custom("ScoreFont", size: 30))
                    .foregroundColor(.green)
                    .padding(.horizontal, 40)
                Spacer()
                Text("le \(score.date)")
                    .font(Font.custom("ScoreFont", size: 20))
                    .foregroundColor(.yellow)
                    .padding(.horizontal, 40)
                Spacer()
            }
            
        }
    }
}

struct EmojiScoreView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiScoreView(score: EmojiScoresManager.EmojiScore(score: 2, time: 14, theme: "vraiment très long pour tester le texte en fait parce que voilà j'en ai marre", date: "et la date pareil imagine si elle est longue ce serait terrible"))
    }
}
