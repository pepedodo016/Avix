//
//  MainScreen.swift
//  HeavenlyShuffle
//
//  Created by muser on 26.11.2024.
//

import SwiftUI

enum Router: Hashable {
    case cupsLevelListing
    case gridLevelListing
    case settings
    case cupsGame(ShuffleLevelItemViewModel)
    case gridGame(ShuffleLevelItemViewModel)
    case info(InfoViewModel)
}

struct MainScreen: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var path: NavigationPath = .init()
    @State private var planeOffset1: CGFloat = 0
    @State private var planeOffset2: CGFloat = 0
    @State private var selectedGame: Int? = nil
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Spacer()
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                HStack(spacing: 40) {
                    Button {
                        path.append(Router.cupsLevelListing)
                    } label: {
                        Text("Cloud Pilot")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(.red)
                            .font(.system(size: 32, weight: .black, design: .rounded))
                            .textCase(.uppercase)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 191/255, green: 254/255, blue: 255/255),
                                        Color(red: 8/255, green: 148/255, blue: 151/255)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                ).opacity(0.7)
                            )
                            .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 2)
                            .cornerRadius(32)
                    }
                    
                    Button {
                        path.append(Router.gridLevelListing)
                    } label: {
                        Text("Cloud flight")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(.red)
                            .font(.system(size: 32, weight: .black, design: .rounded))
                            .textCase(.uppercase)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 191/255, green: 254/255, blue: 255/255),
                                        Color(red: 8/255, green: 148/255, blue: 151/255)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                ).opacity(0.7)
                            )
                            .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 2)
                            .cornerRadius(32)
                    }
                }
                .padding(.vertical, 40)
                .padding(.horizontal, 30)
                
                Button {
                    path.append(Router.settings)
                } label: {
                    Text("settings")
                        .textCase(.uppercase)
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .black, design: .rounded))
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                }
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
                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                .padding(.horizontal, 52)
                .padding(.vertical, 32)
            }
            .navigationDestination(for: Router.self) { router in
                switch router {
                case .cupsLevelListing:
                    CupsLevelsScreen(viewModel: .init(items: []), path: $path)
                        .navigationBarBackButtonHidden(true)
                case .gridLevelListing:
                    ShuffleLevelsScreen(viewModel: .init(items: []), path: $path)
                        .navigationBarBackButtonHidden(true)
                case .settings:
                    SettingsScreen(viewModel: .init(), path: $path)
                        .navigationBarBackButtonHidden(true)
                case .cupsGame(let item):
                    CupsGameScreen(viewModel: .init(id: item.id, level: item.level), path: $path)
                        .navigationBarBackButtonHidden(true)
                case .gridGame(let item):
                    ShuffleGameScreen(viewModel: .init(id: item.id, level: item.level), path: $path)
                        .navigationBarBackButtonHidden(true)
                case .info(let item):
                    InfoScreen(viewModel: item)
                        .navigationBarBackButtonHidden(true)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(.mainBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 3)
            )
        }
        .onAppear {
            viewModel.loadData()
        }
    }
    
    
    @ViewBuilder
    private func gameButton(
        offset: Binding<CGFloat>,
        title: String,
        color: Color,
        action: @escaping () -> Void
    ) -> some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(color)
                .padding(.bottom, 20)

            Image("plane")
                .resizable()
                .customFrame(width: 0.3, height: 0.2)
                .offset(y: offset.wrappedValue)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let newOffset = min(0, value.translation.height)
                            offset.wrappedValue = max(-151, min(0, newOffset))
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                if offset.wrappedValue < -150 {
                                    action()
                                    offset.wrappedValue = 0
                                } else {
                                    offset.wrappedValue = 0
                                }
                            }
                        }
                )
        }
    }
}

//#Preview {
//    MainScreen()
//}
