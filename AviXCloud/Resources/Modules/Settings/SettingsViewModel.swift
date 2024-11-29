//
//  SettingsViewModel.swift
//  HeavenlyShuffle
//
//  Created by muser on 26.11.2024.
//

import Foundation
import RealmSwift

final class SettingsViewModel: ObservableObject {
    @Published var name: String = "ANONYMOUS"
    @Published var icon: String = "accIcon"
    
    private let storage: MainDomainModelStorage = .init()
    
    init() {
        viewDidLoad()
    }
}

extension SettingsViewModel {
    func viewDidLoad() {
        let accounts = storage.read()

        if let firstAccount = accounts.first {
            if !firstAccount.name.isEmpty {
                name = firstAccount.name
            }
            icon = firstAccount.icon.isEmpty ? "userButton" : firstAccount.icon
        }
    }
    
    func updateName(newName: String) {
        self.name = newName

        let accounts = storage.read()
        if var firstAccount = accounts.first {
            firstAccount.name = newName
            storage.store(item: firstAccount)
        }
    }
    
    func deleteAccount() {
        storage.deleteAll()
        
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
        
        if storage.read().isEmpty {
            storage.store(item: .init(name: "anonymous", icon: "accIcon", cups: cups, shuffles: shuffles))
        }
        
        viewDidLoad()
    }
}
