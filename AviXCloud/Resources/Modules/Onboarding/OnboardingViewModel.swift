//
//  OnboardingViewModel.swift
//  HeavenlyShuffle
//
//  Created by muser on 28.11.2024.
//

import Foundation
import RealmSwift

final class OnboardingViewModel: ObservableObject {
    
    func loadData() {
        let storage: MainDomainModelStorage = .init()
        
        guard storage.read().isEmpty else { return }
        
        let cups = List<RealmCupsDomainModel>()
        let shuffles = List<RealmShuffleDomainModel>()
        
        cups.append(.init(level: 1, isResolved: true))
        cups.append(.init(level: 2, isResolved: false))
        cups.append(.init(level: 3, isResolved: false))
        cups.append(.init(level: 4, isResolved: false))
        cups.append(.init(level: 5, isResolved: false))
        cups.append(.init(level: 6, isResolved: false))
        cups.append(.init(level: 7, isResolved: false))
        cups.append(.init(level: 8, isResolved: false))
        cups.append(.init(level: 9, isResolved: false))
        cups.append(.init(level: 10, isResolved: false))
        cups.append(.init(level: 11, isResolved: false))
        cups.append(.init(level: 12, isResolved: false))
        cups.append(.init(level: 13, isResolved: false))
        cups.append(.init(level: 14, isResolved: false))
        cups.append(.init(level: 15, isResolved: false))
        cups.append(.init(level: 16, isResolved: false))
        
        shuffles.append(.init(level: 1, isResolved: true))
        shuffles.append(.init(level: 2, isResolved: false))
        shuffles.append(.init(level: 3, isResolved: false))
        shuffles.append(.init(level: 4, isResolved: false))
        shuffles.append(.init(level: 5, isResolved: false))
        shuffles.append(.init(level: 6, isResolved: false))
        shuffles.append(.init(level: 7, isResolved: false))
        shuffles.append(.init(level: 8, isResolved: false))
        shuffles.append(.init(level: 9, isResolved: false))
        shuffles.append(.init(level: 10, isResolved: false))
        shuffles.append(.init(level: 11, isResolved: false))
        shuffles.append(.init(level: 12, isResolved: false))
        shuffles.append(.init(level: 13, isResolved: false))
        shuffles.append(.init(level: 14, isResolved: false))
        shuffles.append(.init(level: 15, isResolved: false))
        shuffles.append(.init(level: 16, isResolved: false))
        
        storage.store(item: .init(name: "anonymous", icon: "accIcon", cups: cups, shuffles: shuffles))
    }
}
