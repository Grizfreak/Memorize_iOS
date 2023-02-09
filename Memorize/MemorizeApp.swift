//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Antonin Aubert (i201852) on 20/01/2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameMenuView(game: game, timer: game.timer)
        }
    }
}
