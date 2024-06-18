//
//  ContentView.swift
//  Parcel
//
//  Controls the navigation view
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
                window.backgroundColor = .clear
            }
        }
        return nsView
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

struct ContentView: View {
    @State private var isShowingStartupPage = true
    @State private var selectedProject: Project? = nil
    
    @State var currentOption: Int? = 0
    
    let options: [Option] = [ // Options available in the list
        .init(title: "Projects", imageName: "folder.fill"),
        .init(title: "Settings", imageName: "gearshape")
    ]
  
    
    var body: some View {
        
        ZStack {
            // Background Image
            GeometryReader { geometry in
                Image("leaf")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .blur(radius: 1.5)
            }
            
            VStack {
                if isShowingStartupPage {
                    StartUpPage(isShowingStartupPage: $isShowingStartupPage, selectedProject: $selectedProject)
                } else {
                    NavigationView {
                        Sidebar(selectedProject: $selectedProject)
                        if currentOption == 0 {
                            Dashboard(project: $selectedProject)
                        } else if currentOption == 1 {
                            Text("Testing Settings Tab")
                        }
                        else {
                            Text("Select an option")
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigation) {
                            Button(action: toggleSidebar) {
                                Image(systemName: "sidebar.leading")
                            }
                        }
                        
                        ToolbarItem(placement: .automatic) {
                            Spacer() // Pushes the next button to the trailing side
                        }
                        
                        ToolbarItem(placement: .automatic) {
                            Button(action: {
                                // Add your action here
                            }) {
                                Image(systemName: "gearshape")
                            }
                        }
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





// Mock-up for the ProjectDashboard view
struct ProjectDashboard: View {
    @Binding var selectedProject: Project?

    var body: some View {
        if let selectedProject = selectedProject {
            Text("Dashboard for \(selectedProject.projectName)")
        } else {
            Text("Select a project")
        }
    }
}



struct Sidebar: View {
    @Binding var selectedProject: Project?
    
    var body: some View {
        List {
            NavigationLink(destination: Dashboard(project: $selectedProject)) {
                Label("Project", systemImage: "1.circle")
            }
          //  NavigationLink(destination: DetailView2()) {
          //      Label("Plugins", systemImage: "2.circle")
          //  }
            NavigationLink(destination: DetailView3()) {
                Label("Settings", systemImage: "3.circle")
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

struct DetailView3: View {
    var body: some View {
        Text("Detail View 3")
            .navigationTitle("Detail 3")
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

    static var previews: some View {
        Sidebar(selectedProject: $selectedProject)
    }
}
