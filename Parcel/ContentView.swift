//
//  ContentView.swift
//  Parcel
//
//  Controls the navigation view
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isShowingStartupPage = true
    @State private var selectedProject: Project? = nil
    
    @State var currentOption: Int? = 0
    
    let options: [Option] = [ // Options available in the list
        .init(title: "Projects", imageName: "folder.fill"),
        .init(title: "Settings", imageName: "gearshape")
    ]
    
    var body: some View {
        
            if isShowingStartupPage {
                StartUpPage(isShowingStartupPage: $isShowingStartupPage, selectedProject: $selectedProject)
            } else {
                NavigationView {
                    Sidebar()
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
                }
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


/*
// side bar
struct Sidebar: View {
    let options: [Option]
    //@Binding var currentSelection: Int?
    
    var body: some View {
        List(selection: $currentSelection) {
            ForEach(options.indices, id: \.self) { index in
                NavigationLink(
                    destination: EmptyView(), // Destination view (to be replaced)
                    tag: index,
                    selection: $currentSelection
                ) {
                    Label(options[index].title, systemImage: options[index].imageName)
                }
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Sidebar")
    }
}

 */

struct Sidebar: View {
    var body: some View {
        List {
            NavigationLink(destination: DetailView1()) {
                Label("Detail 1", systemImage: "1.circle")
            }
            NavigationLink(destination: DetailView2()) {
                Label("Detail 2", systemImage: "2.circle")
            }
            NavigationLink(destination: DetailView3()) {
                Label("Detail 3", systemImage: "3.circle")
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
