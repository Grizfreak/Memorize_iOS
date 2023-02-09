//
//  EmojiMemoryGameScoreView.swift
//  Memorize
//
//  Created by Antonin Aubert (i201852) on 04/03/2022.
//

import SwiftUI


struct EmojiMemoryGameScoresView: View {
    @ObservedObject var scores: EmojiScoresManager
    var body: some View {
            List(scores.scores) {
                score in NavigationLink(destination: EmojiScoreView(score: score)) {
                    ScoreLigne(score: score)
            }.navigationTitle("Scores")
        }
    }

struct ScoreLigne: View {
    let score: EmojiScoresManager.EmojiScore
    var body: some View {
        HStack {
            Text("Score : \(score.score) pts | Temps : \(score.time) sec") 
        }
    }
}

struct EmojiMemoryGameScoresView_Previews: PreviewProvider {
    static var previews: some View {
    let scores = EmojiScoresManager()
        EmojiMemoryGameScoresView(scores: scores)
    }
}
}
