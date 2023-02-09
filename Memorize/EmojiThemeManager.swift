//
//  ThemeManager.swift
//  Memorize
//
//  Created by Antonin Aubert (i201852) on 04/03/2022.
//

import Foundation
import SwiftUI
class EmojiThemeManager{
    private static let themes = [
        EmojiTheme(name: "Vehicles",
                   card_contents:["🚂","🚀","🚁","⛵️","✈️","🛰","🛸","🚕","🚑","🚜","🏎","🛻","🚢","🛶","💺","🛴","🛵","🏍","🛺","🚒","🚚","🚎","🚄","🛩"],
              card_color: .red),
        EmojiTheme(name: "Pets",
                   card_contents:["🐶","🐱","🐭","🐹","🐰","🐯","🐸","🙊","🐧","🐽","🐙","🐛","🐞","🐌","🦋","🦄","🐝","🐗","🦆","🐢","🐠","🐳","🐏","🦜"],
              card_color: .yellow),
        EmojiTheme(name: "Weather", card_contents:["🌞","🌚","🌙","⭐️","☄️","💥","🌈","❄️","💧","☃️","💨","🌧","🌩","⚡️","✨","💫","🌟","🪐","🍄","🍁","🍀","🌺","🌻","🐲"],
              card_color: .green),
        EmojiTheme(name: "Food", card_contents:["🍆","🥑","🍅","🥭","🍒","🍍","🥐","🥖","🍳","🍠","🫒","🍉","🍇","🍓","🍋","🍌","🍕","🍔","🍟","🍖","🍗","🍣","🍿","🍩"],
              card_color: .purple),
        EmojiTheme(name: "objectivement le plus facile", card_contents: ["🍆","🥑"], card_color: .pink)
    ]
    
    func getRandomTheme()->EmojiTheme{
        return EmojiThemeManager.themes.randomElement()!
    }
}

struct EmojiTheme {
    //Create properly constructor
    let name: String
    let card_contents: [String]
    let card_color: Color
}

