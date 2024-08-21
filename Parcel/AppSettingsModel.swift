//
//  AppSettingsModel.swift
//  Parcel
//
//  Created by Daniel Moreno on 8/20/24.
//

import Foundation
import Combine
import AppKit


class AppSettingsModel: ObservableObject {
    // data is being persistant by user defaults
    
    // Apperance
    @Published var selectedTheme: Theme {
          didSet {
              UserDefaults.standard.set(selectedTheme.rawValue, forKey: "selectedTheme")
          }
      }
    
    @Published var backgroundImage: NSImage? {
            didSet {
                if let image = backgroundImage {
                    _ = saveImageToDocumentsDirectory(image)
                }
            }
        }
    
    @Published var blurAmount: Double {
        didSet {
            UserDefaults.standard.set(blurAmount, forKey: "blurAmount")
        }
    }
    
    @Published var brightnessAmount: Double {
        didSet {
            UserDefaults.standard.set(brightnessAmount, forKey: "brightnessAmount")
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
        
        self.blurAmount = UserDefaults.standard.double(forKey: "blurAmount")
        self.brightnessAmount = UserDefaults.standard.double(forKey: "brightnessAmount")
        self.backgroundImage = loadImageFromDocumentsDirectory()
        
    }
    
    func saveImageToDocumentsDirectory(_ image: NSImage) -> URL? {
            guard let data = image.tiffRepresentation,
                  let bitmap = NSBitmapImageRep(data: data),
                  let jpegData = bitmap.representation(using: .jpeg, properties: [:]) else { return nil }

            let filename = getDocumentsDirectory().appendingPathComponent("background.jpg")
            try? jpegData.write(to: filename)
            return filename
        }

        // Loading image from documents directory
        func loadImageFromDocumentsDirectory() -> NSImage? {
            let filename = getDocumentsDirectory().appendingPathComponent("background.jpg")
            return NSImage(contentsOf: filename)
        }

        func getDocumentsDirectory() -> URL {
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
}

enum Theme: String, CaseIterable {
    case light = "light"
    case dark = "dark"
    case system = "system"
}
