//
//  ShuffleLevelsViewModel.swift
//  HeavenlyShuffle
//
//  Created by muser on 27.11.2024.
//

import Foundation

final class ShuffleLevelsViewModel: ObservableObject {
    @Published var items: [ShuffleLevelItemViewModel]
    
    init(items: [ShuffleLevelItemViewModel]) {
        self.items = items
    }
    
    func loadData() {
        let storage: MainDomainModelStorage = .init()
        
        let levelItems: [ShuffleLevelItemViewModel] = storage.read().first?.shuffles
            .compactMap { makeCellViewModel(for: $0) } ?? []
        
        items = levelItems
    }

    func makeCellViewModel(
        for model: RealmShuffleDomainModel
    ) -> ShuffleLevelItemViewModel? {
        return .init(id: model.id.uuidString, level: model.level, isResolved: model.isResolved)
    }
}

