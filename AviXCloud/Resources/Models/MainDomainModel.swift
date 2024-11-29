//
//  MainDomainModel.swift
//  HeavenlyShuffle
//
//  Created by muser on 28.11.2024.
//

import Foundation
import RealmSwift

struct MainDomainModel {
    var id: UUID
    var name: String
    var icon: String
    var cups: List<RealmCupsDomainModel>
    var shuffles: List<RealmShuffleDomainModel>
    
    init(
        id: UUID = .init(),
        name: String = "",
        icon: String = "",
        cups: List<RealmCupsDomainModel>,
        shuffles: List<RealmShuffleDomainModel>
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.cups = cups
        self.shuffles = shuffles
    }
}
