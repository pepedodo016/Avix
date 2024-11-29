//
//  SettingsScreen.swift
//  HeavenlyShuffle
//
//  Created by muser on 26.11.2024.
//

import SwiftUI
import WebKit

struct SettingsScreen: View {
    @ObservedObject private var viewModel: SettingsViewModel
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    @State private var isPresentWebView = false
    @State private var isPresentAlert = false
    @State private var name = ""
    
    init(viewModel: SettingsViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("settings")
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
//            Button {
//
//            } label: {
                Image(.accIcon)
                    .resizable()
                    .scaledToFit()
//            }
            .padding(.horizontal, 82)
            
            Button {
                isPresentAlert = true
            } label: {
                Text(viewModel.name)
                    .foregroundColor(Color.init(red: 118/255, green: 118/255, blue: 118/255, opacity: 0.6))
                    .font(.system(size: 18, weight: .black, design: .rounded))
                    .textCase(.uppercase)
                    .padding(24)
                    .frame(maxWidth: .infinity)
            }
            .background(Color(red: 242/255, green: 255/255, blue: 255/255))
            .cornerRadius(32)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            .padding(.horizontal, 32)
            .padding(.top, 32)
            .alert("Enter your name", isPresented: $isPresentAlert) {
                TextField("Enter your name", text: $name)
                Button("OK") {
                    viewModel.updateName(newName: name)
                }
            } message: {

            }
            Spacer()
            
            Button {
                path.append(Router.info(.init(id: "1d", text: "AviX Cloud is a fun game for everyone who likes to test their reflexes and attentiveness! Light and colourful design, simple controls and dynamic gameplay make the game an ideal way to pass the time and have fun.\n\nMain features of the application:\n\nVariety of game modes: Follow the clouds to find the hidden aircraft, or memorise its last location on a grid of clouds.\n\nLevels with increasing difficulty: With each new level, the clouds shuffle faster and the aircraft moves more actively, giving you a real challenge.\n\nVivid graphics: The summer atmosphere of clouds and aeroplanes will put you in a good mood.\n\nIntuitive controls: Just tap the screen to make your choice - no complicated actions!\n\nSkill development: The game helps to train your memory, attention and reaction.\n\nChallenge yourself in Cloud Adventure! Can you tackle the fastest aeroplane and become the champion of the airspace?")))
            } label: {
                Text("about app")
                    .textCase(.uppercase)
                    .foregroundStyle(.white)
                    .font(.system(size: 24, weight: .black, design: .rounded))
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
            }
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
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
            .padding(.horizontal, 32)
            Button {
                isPresentWebView = true
            } label: {
                Text("privacy policy")
                    .textCase(.uppercase)
                    .foregroundStyle(.white)
                    .font(.system(size: 24, weight: .black, design: .rounded))
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
            }
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
            .sheet(isPresented: $isPresentWebView) {
                NavigationStack {
                    SomeWebView(url: URL(string: "https://AviXCloud.store/com.AviXCloud/Mara_Winters/privacy")!)
                        .ignoresSafeArea()
                        .navigationTitle("Privacy Policy")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 2)
            .cornerRadius(32)
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
            .padding(.horizontal, 32)
            .padding(.vertical, 24)
            Button {
                viewModel.deleteAccount()
            } label: {
                Text("delete acc")
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
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.gameBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 3)
        )
    }
}

#Preview {
    SettingsScreen(viewModel: .init(), path: .constant(.init()))
}


struct SomeWebView: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
