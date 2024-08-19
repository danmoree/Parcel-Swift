//
//  AppSettingsView.swift
//  Parcel
//
//  Created by Daniel Moreno on 8/17/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showingAppSettings: Bool
    @State private var selectedTab: SettingsTab = .account

    var body: some View {
        
        VStack {
            
            // Top row
            HStack {
                Text("Settings")
                    .font(.title)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    print("Button was tapped")
                    self.showingAppSettings = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .buttonStyle(PlainButtonStyle())
                .focusable(false)
                .padding()
            
            }
            
            HStack(spacing: 0) {
                
                // Left Side Menu
                VStack(alignment: .leading) {
                    ForEach(SettingsTab.allCases, id: \.self) { tab in
                        Button(action: {
                            selectedTab = tab
                        }) {
                            Text(tab.rawValue)
                                .fontWeight(selectedTab == tab ? .bold : .regular)
                                .foregroundColor(selectedTab == tab ? .white : .primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 16)
                                .background(selectedTab == tab ? Color.blue : Color.clear)
                                .cornerRadius(8)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer()
                }
                .frame(minWidth: 200)
                //.background(Color.blue)
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                // Right Side Content
                VStack {
                    TabContentView(selectedTab: selectedTab)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                }
                
            }
        }
        //.background(Color.red)
    }
}

enum SettingsTab: String, CaseIterable {
    case account = "Account"
    case appearance = "Appearance"
    case features = "Features"
    case privacy = "Privacy"
    case about = "About"
}

struct TabContentView: View {
    var selectedTab: SettingsTab

    var body: some View {
        switch selectedTab {
        case .account:
            AccountView()
        case .appearance:
            AppearanceView()
        case .features:
            FeaturesView()
        case .privacy:
            PrivacyView()
        case .about:
            AboutView()
        }
    }
}

struct AccountView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Account Settings")
                .font(.largeTitle)
                .padding(.bottom, 16)
            
            Text("Email: dapple.06.below@icloud.com")
                .font(.body)
            
            Button("Log out") {
                // Log out action
            }
            .padding(.top, 16)
            
            Spacer()
        }
    }
}

struct AppearanceView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Appearance Settings")
                .font(.largeTitle)
                .padding(.bottom, 16)
            
            // Add appearance-related settings here
            
            Spacer()
        }
    }
}

struct FeaturesView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Features Settings")
                .font(.largeTitle)
                .padding(.bottom, 16)
            
            // Add features-related settings here
            
            Spacer()
        }
    }
}

struct PrivacyView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Privacy Settings")
                .font(.largeTitle)
                .padding(.bottom, 16)
            
            // Add privacy-related settings here
            
            Spacer()
        }
    }
}

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("About")
                .font(.largeTitle)
                .padding(.bottom, 16)
            
            Text("App version: 1.0.0")
                .font(.body)
            
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showingAppSettings: .constant(true))
    }
}
