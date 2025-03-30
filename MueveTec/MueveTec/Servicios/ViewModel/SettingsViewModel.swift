//
//  SettingsViewModel.swift
//  MueveTec
//
//  Created by Frouta on 30/03/25.
//

import SwiftUI

struct DarkModeToggle: View {
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    
    var body: some View {
        HStack {
            Image(systemName: colorScheme == .dark ? "moon.fill" : "sun.max.fill")
                .foregroundColor(colorScheme == .dark ? .blue : .orange)
            
            Toggle("Dark Mode", isOn: $isDarkModeEnabled)
                .onChange(of: isDarkModeEnabled) {
                    setAppearance()
                }
        }
        .padding()
        .onAppear {
            isDarkModeEnabled = colorScheme == .dark
        }
    }
    
    private func setAppearance() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        windowScene?.windows.forEach { window in
            window.overrideUserInterfaceStyle = isDarkModeEnabled ? .dark : .light
        }
    }
}
