//
//  GameTimer.swift
//  Memorize
//
//  Created by Antonin Aubert (i201852) on 08/03/2022.
//

import Foundation
class GameTimer: ObservableObject {
    var timer: Timer
    @Published var count: Int
    
    init(){
        self.timer = Timer()
        self.count = 0
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(eventWith), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        self.timer.invalidate()
        
    }
    
    func resetTimer() {
        self.count = 0
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(eventWith), userInfo: nil, repeats: true)
    }
    
    func getTime() -> Int{
        return count
    }
    
    //Each function
    @objc func eventWith() {
        self.count+=1
        print(self.count)
    }
}
