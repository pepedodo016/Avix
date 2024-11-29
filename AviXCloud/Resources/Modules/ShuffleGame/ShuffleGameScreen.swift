//
//  SecondGame.swift
//  HeavenlyShuffle
//
//  Created by muser on 26.11.2024.
//

import SwiftUI

struct ShuffleGameScreen: View {
    @ObservedObject private var viewModel: ShuffleGameViewModel
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: ShuffleGameViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }
    
    var body: some View {
        ZStack {
            VStack() {
                HStack {
                    Text("Cloud flight")
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
                
                VStack(spacing: 5) {
                    ForEach(0..<5) { row in
                        HStack(spacing: 5) {
                            ForEach(0..<5) { col in
                                CellView(cell: viewModel.cells[row][col])
                                    .onTapGesture {
                                        viewModel.cellTapped(row: row, col: col)
                                    }
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(.gameBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 2)
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
                    viewModel.isGameLose = false
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 24)
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
    ShuffleGameScreen(viewModel: .init(id: "", level: 1), path: .constant(.init()))
}


struct CellView: View {
    let cell: Cell
    
    var body: some View {
        ZStack {
            Image(.cloud)
                .resizable()
                .scaledToFit()
                .customFrame(width: 0.166, height: 0.1)
            
            if cell.hasImage {
                Image(.gamePlane)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}
