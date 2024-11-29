//
//  RealmDomainModel.swift
//  HeavenlyShuffle
//
//  Created by muser on 28.11.2024.
//

import Foundation
import RealmSwift

final class RealmDomainModel: Object {
    @Persisted(primaryKey: true)  var id: UUID = .init()
    @Persisted var name: String = ""
    @Persisted var icon: String = ""
    @Persisted var cups: List<RealmCupsDomainModel>
    @Persisted var shuffles: List<RealmShuffleDomainModel>

        
    convenience init(
        id: UUID = .init(),
        name: String,
        icon: String,
        cups: List<RealmCupsDomainModel>,
        shuffles: List<RealmShuffleDomainModel>
    ) {
        self.init()
        self.id = id
        self.name = name
        self.cups = cups
        self.shuffles = shuffles
    }
}
