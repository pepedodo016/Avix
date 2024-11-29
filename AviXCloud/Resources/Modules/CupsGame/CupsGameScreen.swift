//
//  CupsGameView.swift
//  HeavenlyShuffle
//
//  Created by muser on 25.11.2024.
//

import SwiftUI

struct CupsGameScreen: View {
    @ObservedObject private var viewModel: CupsGameViewModel
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: CupsGameViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Cloud Pilot")
                        .foregroundColor(.white)
                        .font(.system(size: 32, weight: .black, design: .rounded))
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
                
                Text("\(viewModel.countdown)")
                    .foregroundStyle(.white)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .shadow(color: Color.black, radius: 0.3, x: 0, y: 0)
                    .textCase(.uppercase)
                    .padding(.horizontal, 44)
                    .padding(.vertical, 12)
                    .background(.red.opacity(0.5))
                    .cornerRadius(32)
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    .padding(.top, 32)
                Spacer()
                ZStack {
                    ForEach(viewModel.cups) { cup in
                        CupView(cup: cup, showResult: viewModel.showResult)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    if let index = viewModel.cups.firstIndex(where: { $0.id == cup.id }) {
                                        viewModel.selectCup(index)
                                    }
                                }
                            }
                    }
                }
                .frame(height: 160)
                .clipped()
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(.gameBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 5)
            )
            
            if viewModel.isGameOver {
                VStack {
                    VStack {
                        Text("level\ncompleted")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        Color(red: 145/255, green: 250/255, blue: 251/255),
                                        Color(red: 64/255, green: 199/255, blue: 201/255)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .font(.system(size: 42, weight: .black, design: .rounded))
                            .textCase(.uppercase)
                            .frame(maxWidth: .infinity)
                            .padding(24)
                    }
                    .background(Color(red: 225/255, green: 254/255, blue: 255/255, opacity: 0.8))
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    .cornerRadius(32)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 24)
                .background(Color.black.opacity(0.5))
                .transition(.opacity)
                .onTapGesture {
                    viewModel.levelPassed()
                    dismiss()
                }
            }
            
            if viewModel.isGameLose {
                VStack {
                    VStack {
                        Text("try\nagain")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        Color(red: 145/255, green: 250/255, blue: 251/255),
                                        Color(red: 64/255, green: 199/255, blue: 201/255)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .font(.system(size: 42, weight: .black, design: .rounded))
                            .textCase(.uppercase)
                            .frame(maxWidth: .infinity)
                            .padding(24)
                    }
                    .background(Color(red: 225/255, green: 254/255, blue: 255/255, opacity: 0.8))
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    .cornerRadius(32)
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.5))
                .transition(.opacity)
                .onTapGesture {
                    viewModel.isGameLose = false
                    viewModel.resetGame()
                    viewModel.startGame()
                }
            }
        }
        .animation(.easeInOut, value: viewModel.isGameLose)
        .animation(.easeInOut, value: viewModel.isGameOver)
        .onAppear {
            viewModel.resetGame()
            viewModel.startGame()
        }
    }
}

#Preview {
    CupsGameScreen(viewModel: .init(id: "1", level: 1), path: .constant(.init()))
}


struct CupView: View {
    let cup: Cup
    let showResult: Bool
    
    var body: some View {
        ZStack {
            if cup.isCovered {
                Image(.cloud)
                    .resizable()
                    .foregroundColor(.blue)
            } else {
                if cup.hasItem {
                    Image(.gamePlane)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image("")
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .customFrame(width: 0.3, height: 0.13)
        .position(x: cup.position + 60, y: 50)
    }
}
