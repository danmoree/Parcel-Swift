//
//  AppSettingsView.swift
//  Parcel
//
//  Created by Daniel Moreno on 8/17/24.
//

import SwiftUI
import AppKit
import UniformTypeIdentifiers

struct SettingsView: View {
    @Binding var showingAppSettings: Bool
    @State private var selectedTab: SettingsTab = .appearance
    @EnvironmentObject private var settings: AppSettingsModel

    var body: some View {
        
        VStack(spacing: 0) {
            
            // Top row
            HStack {
                Text("Settings")
                    .font(.title)
                    .fontWeight(.semibold)
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
            
           // RoundedRectangle(cornerRadius: 12)
             //   .fill(Color.gray.opacity(0.3))
              //  .frame(width: .infinity, height: 1)
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .frame(height: 1)
                .opacity(0.1)
           
                
                
            
            HStack(spacing: 0) {
             
                
                // Left Side Menu
                VStack(alignment: .leading) {
                    
                    // invisable box
                    Rectangle()
                        .fill(Color.black.opacity(0.3))
                        .frame(width: 1, height: 10)
                        
                    
                    ForEach(SettingsTab.allCases, id: \.self) { tab in
                        Button(action: {
                            selectedTab = tab
                        }) {
                            Text(tab.rawValue)
                                .foregroundColor(selectedTab == tab ? .white : .primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 16)
                                .background(selectedTab == tab ? Color.orange.opacity(0.8) : Color.clear)
                                
                        }
                        .focusable(false)
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    
                    Spacer()
                }
                .frame(minWidth: 110, maxWidth: 110, minHeight: 0, maxHeight: .infinity)
                .background(Color(red: 0.23, green: 0.22, blue: 0.22)) // Use values between 0 and 1
                
                
                
                
                // Right Side Content
                VStack {
                    TabContentView(selectedTab: selectedTab)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                }
                
            }
            //.background(Color.white)
            
        }
        //.background(Color.red)
        //.background(Color(red: 0.27, green: 0.26, blue: 0.27)) // Use values between 0 and 1
    }
}

enum SettingsTab: String, CaseIterable {
    
    case appearance = "Appearance"
    case features = "Features"
    case about = "About"
}

struct TabContentView: View {
    var selectedTab: SettingsTab

    var body: some View {
        switch selectedTab {
        case .appearance:
            AppearanceView()
        case .features:
            FeaturesView()
        case .about:
            AboutView()
        }
    }
}



struct AppearanceView: View {
    @EnvironmentObject private var settings: AppSettingsModel
    @State private var showingImagePicker = false
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Text("Theme")
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                }
                
                HStack {
                    Form {
                              Picker("Appearance", selection: $settings.selectedTheme) {
                                  ForEach(Theme.allCases, id: \.self) { theme in
                                      Text(theme.rawValue.capitalized)
                                          .tag(theme)
                                  }
                              }
                              .pickerStyle(SegmentedPickerStyle())
                          }
                }
                .padding(.leading,16)
                .font(.subheadline)

                HStack {
                    Text("Custom background")
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                }
                
                HStack {
                                  Button("Select Custom Image") {
                                      openFileExplorer()
                                  }
                                  .padding(.leading)
                                  //.background(Color.gray.opacity(0.3))
                                  .cornerRadius(8)
                              }
                // Display the selected image
                               if let backgroundImage = settings.backgroundImage {
                                   Image(nsImage: backgroundImage)
                                       .resizable()
                                       .scaledToFit()
                                       .frame(height: 200)
                                       .padding()
                               }
            } // end of vstack
        } // end of scroll view
    }
    
    func openFileExplorer() {
           let panel = NSOpenPanel()
           panel.allowedContentTypes = [UTType.png, UTType.jpeg, UTType.image]
           panel.canChooseFiles = true
           panel.canChooseDirectories = false

           if panel.runModal() == .OK {
               if let url = panel.url, let image = NSImage(contentsOf: url) {
                   settings.backgroundImage = image
               }
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
            .frame(width: 600, height: 500)
            .environmentObject(AppSettingsModel())
    }
}
