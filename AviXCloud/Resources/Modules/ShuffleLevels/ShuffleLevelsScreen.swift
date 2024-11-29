//
//  ShuffleLevelsScreen.swift
//  HeavenlyShuffle
//
//  Created by muser on 27.11.2024.
//

import SwiftUI

struct ShuffleLevelsScreen: View {
    // MARK: - Setup
    @ObservedObject var viewModel: ShuffleLevelsViewModel
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: ShuffleLevelsViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                let itemWidth = (geometry.size.width - 80) / 2
                VStack {
                    HStack {
                        Button {
                            path.append(Router.info(.init(id: "jh", text: "In the game ‘Cloud Flight’ you will have to demonstrate your attention and reaction! On the screen appears a grid of fluffy clouds, among which randomly moves the plane. Your task is to remember where he last appeared, and click on this cell.\n\n Game Features:\n\nDynamic gameplay: The plane appears in new places faster and faster with each level, challenging your attention.\n\nDifficulty Progression: Increasing the speed at which the plane appears makes the game tense and addictive.\n\nSimple controls: Just tap the cloud cell where you last saw the plane.\n\nBright design: The light clouds and brightly coloured aircraft create the atmosphere of an aerial adventure.\n\nThe game is perfect for those who like fast and exciting challenges. Will you be able to cope with an aeroplane that is getting faster and faster? Test your reflexes and become a master of Cloud Flight!")))
                        } label: {
                            Image(.infoButton)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                        }
                        Spacer()
                        Text("levels")
                            .foregroundColor(.white)
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
                    ScrollView(.vertical) {
                        LazyVGrid(columns: Array(repeating: GridItem(.fixed(itemWidth)), count: 2), spacing: 22) {
                            ForEach(viewModel.items, id: \.self) { item in
                                ShuffleLevelItemView(viewModel: item, onTap: { _ in
                                    path.append(Router.gridGame(item))
                                })
                                .customFrame(width: 0.38, height: 0.17)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .padding(.vertical, 24)
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    .cornerRadius(32)
                    .padding(.top, 32)
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image(.listingBackground)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                )
                .onAppear {
                    viewModel.loadData()
                }
            }
        }
    }
}

#Preview {
    ShuffleLevelsScreen(viewModel: .init(items: [
        .init(id: "1", level: 1, isResolved: true),
        .init(id: "2", level: 1, isResolved: false),
        .init(id: "3", level: 1, isResolved: false),
        .init(id: "4", level: 1, isResolved: false)
    ]), path: .constant(.init()))
}
