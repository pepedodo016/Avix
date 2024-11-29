//
//  CupsLevelsScreen.swift
//  HeavenlyShuffle
//
//  Created by muser on 27.11.2024.
//

import SwiftUI

struct CupsLevelsScreen: View {
    // MARK: - Setup
    @ObservedObject var viewModel: CupsLevelsViewModel
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: CupsLevelsViewModel, path: Binding<NavigationPath>) {
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
                            path.append(Router.info(.init(id: "98", text: "‘Cloud Pilot’ is an exciting game for quick reaction and attentiveness. There is an aircraft hiding under three fluffy clouds. You need to carefully follow the movements of the clouds to find under which one the plane is hiding.\n\nGame Features:\n\nInteractive gameplay: The clouds start to shuffle on the screen, gradually increasing in speed with each new level.\n\nDifficulty Levels: The further you go, the faster and harder the clouds move.\n\nColourful design: Light clouds and brightly coloured aircraft make the game visually appealing and relaxing.\n\nIntuitive controls: Simply tap the screen to select the cloud under which you think the aircraft is hidden.")))
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
                                    path.append(Router.cupsGame(item))
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
    CupsLevelsScreen(viewModel: .init(items: [
        .init(id: "1", level: 1, isResolved: true),
        .init(id: "2", level: 1, isResolved: false),
        .init(id: "3", level: 1, isResolved: false),
        .init(id: "4", level: 1, isResolved: false)
    ]), path: .constant(.init()))
}
