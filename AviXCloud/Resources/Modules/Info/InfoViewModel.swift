//
//  InfoViewModel.swift
//  AviXCloud
//
//  Created by muser on 29.11.2024.
//

import Foundation

final class InfoViewModel: ObservableObject, Hashable {
    @Published var id: String
    @Published var text: String
 
    init(id: String, text: String) {
        self.id = id
        self.text = text
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: InfoViewModel, rhs: InfoViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.text == rhs.text
    }
}
    
