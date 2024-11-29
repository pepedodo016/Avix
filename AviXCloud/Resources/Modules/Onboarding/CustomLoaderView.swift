//
//  CustomLoaderView.swift
//  HeavenlyShuffle
//
//  Created by muser on 26.11.2024.
//

import Foundation
import SwiftUI

struct CustomLoaderView: View {
    @State private var rotationAngle = 0.0
    private let ringSize: CGFloat = 80

    var colors: [Color] = [Color.red, Color.red.opacity(0.3)]

    var body: some View {
            ZStack {
                Circle()
                   .stroke(
                       AngularGradient(
                           gradient: Gradient(colors: colors),
                           center: .center,
                           startAngle: .degrees(0),
                           endAngle: .degrees(360)
                       ),
                       style: StrokeStyle(lineWidth: 16, lineCap: .round)
                       
                   )
                   .frame(width: ringSize, height: ringSize)

                Circle()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color.red)
                    .offset(x: ringSize/2)

            }
            .rotationEffect(.degrees(rotationAngle))
            .padding(.horizontal, 80)
            .padding(.vertical, 50)
            .onAppear {
                withAnimation(.linear(duration: 1.5)
                            .repeatForever(autoreverses: false)) {
                        rotationAngle = 360.0
                    }
            }
            .onDisappear{
                rotationAngle = 0.0
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
