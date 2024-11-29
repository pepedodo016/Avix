//
//  RealmCupsDomainModel.swift
//  HeavenlyShuffle
//
//  Created by muser on 28.11.2024.
//

import Foundation
import RealmSwift

final class RealmCupsDomainModel: Object {
    @Persisted(primaryKey: true)  var id: UUID = .init()
    @Persisted var level: Int = 0
    @Persisted var isResolved: Bool = false
        
    convenience init(
        id: UUID = .init(),
        level: Int,
        isResolved: Bool
    ) {
        self.init()
        self.id = id
        self.level = level
        self.isResolved = isResolved
    }
}
