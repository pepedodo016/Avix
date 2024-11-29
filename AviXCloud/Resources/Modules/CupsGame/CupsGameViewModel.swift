//
//  CupsGameViewModel.swift
//  HeavenlyShuffle
//
//  Created by muser on 27.11.2024.
//

import Foundation
import SwiftUI

class CupsGameViewModel: ObservableObject {
    @Published var id: String
    @Published var level: Int
    @Published var cups: [Cup] = []
    @Published var isGameActive = false
    @Published var isGameOver: Bool = false
    @Published var isGameLose: Bool = false
    @Published var showResult = false
    @Published var countdown: Int = 3
    
    private var correctPosition: Int = 0
    private var countdownTimer: Timer?
    
    init(id: String, level: Int) {
        self.id = id
        self.level = level
        resetGame()
    }
    
    func resetGame() {
        correctPosition = Int.random(in: 0...2)
        cups = (0...2).map { index in
            Cup(hasItem: index == correctPosition,
                isSelected: false,
                position: CGFloat(index) * 120,
                isCovered: false)
        }
        isGameActive = false
        showResult = false
        isGameOver = false
        isGameLose = false
        countdown = 3
    }
    
    func startGame() {
        startCountdown()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeInOut(duration: 0.5)) {
                for i in 0..<self.cups.count {
                    self.cups[i].isCovered = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.shuffle()
            }
        }
    }
    
    func startCountdown() {
        countdown = 3
        countdownTimer?.invalidate()
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.countdown > 0 {
                self.countdown -= 1
            } else {
                timer.invalidate()
            }
        }
    }
    
    func shuffle() {
        isGameActive = true
        showResult = false
        
        let shuffles = min(5 + level, 20)
        let duration = max(0.3 - Double(level) * 0.02, 0.1)
        
        for i in 0..<shuffles {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration * Double(i)) {
                withAnimation(.easeInOut(duration: duration)) {
                    let positions = self.cups.map { $0.position }
                    let shuffledPositions = positions.shuffled()
                    
                    for j in 0..<self.cups.count {
                        self.cups[j].position = shuffledPositions[j]
                    }
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * Double(shuffles)) {
            self.isGameActive = false
        }
    }
    
    func selectCup(_ selectedIndex: Int) {
        guard !isGameActive && !showResult else { return }
        
        showResult = true
        let selectedCup = cups[selectedIndex]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if selectedCup.hasItem {
                self.isGameOver = true
            } else {
                self.isGameLose = true
            }
        }
        
        cups[selectedIndex].isCovered = false
        cups[selectedIndex].isSelected = true
    }
    
    func levelPassed() {
        let storage: MainDomainModelStorage = .init()
        
        guard let user = storage.read().first else { return }
        
        let levels = user.cups
        
        guard let currentIndex = levels.firstIndex(where: { $0.id.uuidString == id }) else { return }
        
        let nextIndex = levels.index(after: currentIndex)

        guard nextIndex < levels.count else { return }
        
        let currentItem = levels[currentIndex]
        let nextItem = levels[nextIndex]
        
        do {
            try storage.storage.realm?.write {
                print(nextItem)
                nextItem.isResolved = true
            }
            
            storage.store(item: user)
        } catch {
            print("Failed to write to Realm, reason: \(error.localizedDescription)")
        }
    }
}

struct Cup: Identifiable {
    let id = UUID()
    var hasItem: Bool
    var isSelected: Bool
    var position: CGFloat
    var isCovered: Bool
}
