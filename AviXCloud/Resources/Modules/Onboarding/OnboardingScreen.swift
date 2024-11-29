//
//  OnboardingScreen.swift
//  HeavenlyShuffle
//
//  Created by muser on 26.11.2024.
//

import SwiftUI

struct OnboardingScreen: View {
    @ObservedObject private var viewModel: OnboardingViewModel
    @State private var isActive: Bool = false

    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if isActive {
          //  MainScreen()
        } else {
            VStack {
                CustomLoaderView()
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(.onboardingBackground)
                    .resizable()
                    .ignoresSafeArea()
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        viewModel.loadData()
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingScreen(viewModel: .init())
}



