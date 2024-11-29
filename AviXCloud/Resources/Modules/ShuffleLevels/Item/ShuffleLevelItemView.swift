//
//  ShuffleLevelItemView.swift
//  HeavenlyShuffle
//
//  Created by muser on 27.11.2024.
//

import SwiftUI

struct ShuffleLevelItemView: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: ShuffleLevelItemViewModel
    var onTap: ((ShuffleLevelItemViewModel) -> Void)?
    
    init(viewModel: ShuffleLevelItemViewModel, onTap: ((ShuffleLevelItemViewModel) -> Void)? = nil) {
        self.viewModel = viewModel
        self.onTap = onTap
    }
    
    var body: some View {
        if viewModel.isResolved {
            Text("\(viewModel.level)")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(.white)
                .font(.system(size: 42, weight: .black, design: .rounded))
                .textCase(.uppercase)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 191/255, green: 254/255, blue: 255/255),
                            Color(red: 8/255, green: 148/255, blue: 151/255)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 2)
                .cornerRadius(32)
                .onTapGesture {
                    onTap?(viewModel)
                }
        } else {
            ZStack {
                Text("\(viewModel.level)")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.white)
                    .font(.system(size: 42, weight: .black, design: .rounded))
                    .textCase(.uppercase)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 216/255, green: 24/255, blue: 24/255),
                                Color(red: 173/255, green: 8/255, blue: 12/255)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 2)
                    .cornerRadius(32)
                Image(.lock)
                    .resizable()
                    .scaledToFit()
                    .padding(24)
            }
        }
    }
}

#Preview {
    ShuffleLevelItemView(viewModel: .init(id: "1", level: 1, isResolved: true), onTap: {_ in })
        .padding(52)
}
