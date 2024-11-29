//
//  View.swift
//  HeavenlyShuffle
//
//  Created by muser on 28.11.2024.
//

import Foundation
import SwiftUI

extension View {
    func customFrame(width: CGFloat, height: CGFloat) -> some View {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return self.frame(width: screenWidth * width, height: screenHeight * height)
    }
}
