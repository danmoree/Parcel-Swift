//
//  ParcelApp.swift
//  Parcel
//
//  Created by Daniel Moreno on 5/9/24.
//

import SwiftUI
import SwiftData

@main
struct ParcelApp: App {
    
    private let urlApp: URL?
    private let url: URL?
        
        // Prints out the path for the db
       init() {
           // Initialize urlApp and url here
           urlApp = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
           url = urlApp?.appendingPathComponent("default.store")

           // Now it's safe to check for file existence
           if let path = url?.path, FileManager.default.fileExists(atPath: path) {
             print("SwiftData db at \(url!.absoluteString)")
           }
       }
    
    // Initial model setup for database
    var sharedModelContainer: ModelContainer = {
        // Define the schema with Song and Project classes
        let schema = Schema([
            Song.self, Project.self
        ])
        
        // Set up model configuration with the defined schema
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false) // Set isStoredInMemoryOnly to false to persist data

        // Create and return the ModelContainer
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView() // Main view of the app
                .environmentObject(ProjectViewModel(modelContainer: sharedModelContainer)) // Inject the view model into the environment
        }
        .windowStyle(HiddenTitleBarWindowStyle()) // Hides the title bar
        .modelContainer(sharedModelContainer) // Injects the model container into the environment
    }
}

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get{.none}
        set{}
    }
}
