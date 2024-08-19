//
//  ContentView.swift
//  Parcel
//
//  Controls the navigation view, parent window, every view has to go through this
//

import SwiftUI
import SwiftData


struct TransparentTitleBar: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let nsView = NSView()
        DispatchQueue.main.async {
            if let window = nsView.window {
                window.titlebarAppearsTransparent = true
                window.titleVisibility = .hidden
                window.isMovableByWindowBackground = true
               // window.backgroundColor = .clear
            }
        }
        return nsView
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
}

struct ContentView: View {
    @EnvironmentObject private var appState: AppState
    
    @State private var isShowingStartupPage = true
    @State private var selectedProject: Project? = nil
    @State private var isShowingSettings = false
    
    @State var currentOption: Int? = 0
    @State private var selectedSong: Song? = nil
    
    let options: [Option] = [ // Options available in the list
        .init(title: "Projects", imageName: "folder.fill"),
        .init(title: "Settings", imageName: "gearshape")
    ]
    
    
    var body: some View {
        
        ZStack {
            // Background Image
            GeometryReader { geometry in
                Image("sands")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                //.frame(width: geometry.size.width, height: geometry.size.height)
                    .blur(radius: 5.5)
                //.opacity(0.9)
                    .overlay(Color.black.opacity(0.5)) // Dark overlay
            }
            
            VStack {
                // Start up, shows once
                if isShowingStartupPage {
                    StartUpPage(isShowingStartupPage: $isShowingStartupPage, selectedProject: $selectedProject)
                } else {
                    // then main view pops up
                    NavigationView {
                        Sidebar(selectedProject: $selectedProject, isShowingSettings: $isShowingSettings, selectedSong: $selectedSong)
                        
                        // Using the routing engine
                        Group {
                            if let currentRoute = appState.currentRoute {
                                
                                switch currentRoute {
                                    
                                case .dashboard:
                                    Dashboard(project: $selectedProject, selectedSong: $selectedSong)
                                        .transition(.opacity)
                                    
                                case .songView:
                                    songView(currentSong: $selectedSong)
                                        .transition(.opacity)
                                    
                                case .samples:
                                    SamplesView()
                                        .transition(.opacity)
                                }
                                
                            }
                        }
                        .animation(.easeInOut(duration: 0.2), value: appState.currentRoute)
                        
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigation) {
                            Button(action: toggleSidebar) {
                                Image(systemName: "sidebar.leading")
                            }
                            .focusable(false)
                        }
                        
                        ToolbarItem(placement: .automatic) {
                            Spacer() // Pushes the next button to the trailing side
                        }
                        
                        ToolbarItem(placement: .automatic) {
                            Button(action: {
                                isShowingSettings = true
                            }) {
                                Image(systemName: "gearshape")
                            }
                            .focusable(false)
                        }
                    }
                    .sheet(isPresented: $isShowingSettings) {
                        SettingsView(showingAppSettings: $isShowingSettings)
                            .frame(width: 600, height: 500)
                    }
                    
                    
                }
                
            }
            TransparentTitleBar()
        }
    }
    
    
    private func toggleSidebar() {
#if os(macOS)
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
#endif
    }
}





struct Sidebar: View {
    @Binding var selectedProject: Project?
    @Binding var isShowingSettings: Bool
    @Binding var selectedSong: Song?
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            
            List {
                Button(action: {
                    appState.push(.dashboard)
                }) {
                    Image(systemName: "folder.fill")
                    Label("Project", systemImage: "folder.fill")
                        .labelStyle(.titleOnly)
                        .fontWeight(.light)
                }
                .buttonStyle(PlainButtonStyle())
                
                // NavigationLink(destination: Dashboard(project: $selectedProject, selectedSong: $selectedSong)) {
                //     Image(systemName: "folder.fill")
                //     Label("Project", systemImage: "folder.fill")
                //         .labelStyle(.titleOnly)
                //         .fontWeight(.light)
                // }
                
                Button(action: {
                    appState.push(.samples)
                }) {
                    Image(systemName: "waveform")
                    Label("Samples", systemImage: "waveform")
                        .labelStyle(.titleOnly)
                        .fontWeight(.light)
                }
                .buttonStyle(PlainButtonStyle())
                
                // NavigationLink(destination: DetailView2()) {
                //     Image(systemName: "waveform")
                //     Label("Samples", systemImage: "2.circle")
                //         .labelStyle(.titleOnly)
                //         .fontWeight(.light)
                // }
                
                Button(action: {
                    isShowingSettings = true // Show settings sheet
                }) {
                    Image(systemName: "gearshape")
                    Label("Settings", systemImage: "gearshape")
                        .labelStyle(.titleOnly)
                }
                .buttonStyle(PlainButtonStyle())
                
                
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Sidebar")
        
        
    }
    
}


struct DetailView: View {
    var body: some View {
        Text("Select an item from the sidebar.")
            .navigationTitle("Detail")
    }
}

struct DetailView1: View {
    var body: some View {
        Text("Detail View 1")
            .navigationTitle("Detail 1")
    }
}

struct DetailView2: View {
    var body: some View {
        Text("Detail View 2")
            .navigationTitle("Detail 2")
    }
}



#Preview {
    let schema = Schema([
        Song.self, Project.self
    ])
    
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    
    let modelContainer: ModelContainer
    do {
        modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
    
    let sampleProjects = [
        Project(projectName: "Project 1"),
        Project(projectName: "Project 2"),
        Project(projectName: "Project 3")
    ]
    
    return ContentView()
        .environmentObject(ProjectViewModel(modelContainer: modelContainer))
}

struct Sidebar_Previews: PreviewProvider {
    @State static var selectedProject: Project? = nil
    @State static var isShowingSettings: Bool = true
    @State static var selectedSong: Song? = nil
    
    static var previews: some View {
        Sidebar(selectedProject: $selectedProject, isShowingSettings: $isShowingSettings, selectedSong: $selectedSong)
    }
}
