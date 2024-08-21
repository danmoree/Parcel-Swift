//
//  AppSettingsModel.swift
//  Parcel
//
//  Created by Daniel Moreno on 8/20/24.
//

import Foundation
import Combine


class AppSettingsModel: ObservableObject {
    // data is being persistant by user defaults
    
    // Apperance
    @Published var selectedTheme: Theme {
          didSet {
              UserDefaults.standard.set(selectedTheme.rawValue, forKey: "selectedTheme")
          }
      }
    
    init() {
        if let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme"),
                  let theme = Theme(rawValue: savedTheme) {
                print("Loaded saved theme: \(theme.rawValue)")
                   self.selectedTheme = theme
               } else {
                   print("No saved theme found, defaulting to system")
                   self.selectedTheme = .system // or whatever your default should be
               }
    }
    
    
}

enum Theme: String, CaseIterable {
    case light = "light"
    case dark = "dark"
    case system = "system"
}
