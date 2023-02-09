//
//  Score.swift
//  Memorize
//
//  Created by Antonin Aubert (i201852) on 08/03/2022.
//

import Foundation
class EmojiScoresManager: ObservableObject {
    @Published var scores: [EmojiScore]
    static let filename = "Autosaved.scores"
    static var url: URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentDirectory?.appendingPathComponent("Autosaved.scores")
    }
    var lastItemSaved: EmojiScore?
    
    init() {
        self.scores = []
        load()
    }
    
    
    
    func load() {
        do {
            let json =  try Data(contentsOf: EmojiScoresManager.url!)
            self.scores = try JSONDecoder().decode([EmojiScore].self, from: json)
        } catch {
            print("erreur")
        }
    }
    
    private func save (to url: URL) throws {
        let data: Data = try JSONEncoder().encode(self.scores)
        print("json = \(String(data: data, encoding: .utf8) ?? "nil")")
        print(self.scores)
        print(data)
        try data.write(to: url)
        print ("save sucess!")
    }
    
    func addScore(score: Int, time: Int, theme: EmojiTheme, date: Date) {
        let formatter       = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.locale    = Locale(identifier: "FR-fr")
        let emojiscore = EmojiScore(score: score, time: time, theme: theme.name, date: formatter.string(from: date))
        self.scores.append(emojiscore)
        self.lastItemSaved = emojiscore
        self.scores = order()
        do {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            if let url = documentDirectory?.appendingPathComponent("Autosaved.scores"){
                try save(to: url)
            }
        } catch {
            print("error")
        }
    }
    
    func order() -> [EmojiScore] {
        
        return self.scores.sorted(by: {
            if($0.score != $1.score){
                return $0.score > $1.score
            } else {
                return $0.time < $1.time
            }
        })
    }
    
    struct EmojiScore : Codable, Identifiable {
        var id = UUID()
        var score: Int
        var time: Int
        var theme: String
        var date: String
    }
    
    
}

extension EmojiScoresManager.EmojiScore : Comparable {
    static func < (lhs: EmojiScoresManager.EmojiScore, rhs: EmojiScoresManager.EmojiScore) -> Bool {
        if lhs.score != rhs.score {
            return lhs.score > rhs.score
        } else {
            return lhs.time > rhs.time
        }
    }
}
