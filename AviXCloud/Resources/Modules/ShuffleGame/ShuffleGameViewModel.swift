//
//  ShuffleGameViewModel.swift
//  HeavenlyShuffle
//
//  Created by muser on 27.11.2024.
//

import Foundation

class ShuffleGameViewModel: ObservableObject {
    @Published var id: String
    @Published var level: Int
    @Published var cells: [[Cell]] = []
    @Published var isGameActive = false
    @Published var isGameOver: Bool = false
    @Published var isGameLose: Bool = false
    @Published var countdown: Int = 3
    
    private var correctPosition: Int = 0
    private var countdownTimer: Timer?
    
    private var timer: Timer?
    private var lastImagePosition: (row: Int, col: Int)?
    
    init(id: String, level: Int) {
        self.id = id
        self.level = level
        resetGame()
    }
    
    func resetGame() {
        cells = Array(repeating: Array(repeating: Cell(hasImage: false, isSelected: false, isCovered: false), count: 5), count: 5)
        isGameActive = false
        lastImagePosition = nil
        isGameOver = false
        isGameLose = false
        countdown = 3
    }
    
    func startGame() {
        startCountdown()
        isGameActive = true
        moveImage()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.showFinalPosition()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.stopGame()
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
    
    private func moveImage() {
        timer?.invalidate()
        
        let interval = max(0.1 - Double(level) * 0.02, 0.1) // Минимум 0.1 секунды
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.updateImagePosition()
        }
    }

    
    private func updateImagePosition() {
        if let last = lastImagePosition {
            cells[last.row][last.col].hasImage = false
        }
        
        // Установить новую случайную позицию
        let row = Int.random(in: 0..<5)
        let col = Int.random(in: 0..<5)
        cells[row][col].hasImage = true
        lastImagePosition = (row, col)
    }
    
    private func showFinalPosition() {
        timer?.invalidate()
        timer = nil
        
        if let last = lastImagePosition {
            cells[last.row][last.col].hasImage = true
        }
    }
    
    private func stopGame() {
        isGameActive = false
        
        if let last = lastImagePosition {
            cells[last.row][last.col].hasImage = false
        }
    }
    
    func cellTapped(row: Int, col: Int) {
        guard !isGameActive else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let last = self.lastImagePosition,
               last.row == row && last.col == col {
                self.isGameOver = true
            } else {
                self.isGameLose = true
            }
        }
        
        cells[row][col].isSelected = true
    }
    
    func levelPassed() {
        let storage: MainDomainModelStorage = .init()
        
        guard let user = storage.read().first else { return }
        
        let levels = user.shuffles
        
        guard let currentIndex = levels.firstIndex(where: { $0.id.uuidString == id }) else { return }
        
        let nextIndex = levels.index(after: currentIndex)

        guard nextIndex < levels.count else { return }
        
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

struct Cell: Identifiable {
    let id = UUID()
    var hasImage: Bool
    var isSelected: Bool
    var isCovered: Bool
}
