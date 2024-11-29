//
//  InfoScreen.swift
//  HeavenlyShuffle
//
//  Created by muser on 26.11.2024.
//

import SwiftUI

struct InfoScreen: View {
    @ObservedObject var viewModel: InfoViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: InfoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("info")
                    .foregroundStyle(.white)
                    .font(.system(size: 42, weight: .black, design: .rounded))
                    .textCase(.uppercase)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 0)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(.closeButton)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                }
            }
            Spacer()
            
            ScrollView {
                Text(viewModel.text)
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .shadow(color: Color.black, radius: 0.3, x: 0, y: 0)
                    .textCase(.uppercase)
            }
            .padding(24)
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity)
            .background(.red.opacity(0.5))
            .cornerRadius(32)
            .padding(.vertical, 52)
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.gameBackground)
                .resizable()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

#Preview {
    InfoScreen(viewModel: .init(id: "", text: "salkdmsa"))
}
