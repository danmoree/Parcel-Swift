
//
//  ContentView.swift
//  ChordCraft
//
//  Created by Bernabe  Macias on 4/4/24.
//


import SwiftUI
import SwiftData

struct StartUpPage: View {
    // Variables
    @State private var showProjects = false
    @State private var currentSelection = 0
    //@Query private var projects: [Project] // Changed Projects to projects to follow Swift naming conventions
    @State private var projects: [Project]
    @State private var selectedProject: Project? // keep track of selected project
    @EnvironmentObject var viewModel: ProjectViewModel
    @State private var showingAddProjectForm = false
    
    init() {
        // Initialize with hardcoded projects for testing
        let project1 = Project(projectName: "Project 1")
        project1.artistName = "Kanye West"
        
        let project2 = Project(projectName: "Project 2")
        project2.artistName = "Taylor Swift"
        
        let project3 = Project(projectName: "Project 3")
        project3.artistName = "Daniel Moreno"
        
        // Create songs
        let song1 = Song(title: "Song 1", filePath: "/path/to/song1", tempo: 120, genre: "Pop", key: "C", starRating: 4.5, notes: "Great song!", stage: "Completed")
        let song2 = Song(title: "Song 2", filePath: "/path/to/song2", tempo: 130, genre: "Rock", key: "G", starRating: 4.0, notes: "Needs more work", stage: "Mixing")
        let song3 = Song(title: "Song 3", filePath: "/path/to/song3", tempo: 110, genre: "Jazz", key: "F", starRating: 5.0, notes: "Almost done", stage: "Mastering")
        
        // Add songs to projects
     //   project1.addSong(song1)
     //   project2.addSong(song2)
     //   project3.addSong(song3)
        
        _projects = State(initialValue: [project1, project2, project3])
    }

    var body: some View {
        NavigationView {
            if showProjects {
                          // Pass the projects to ListView
                          ListView(options: options, currentSelection: $currentSelection)
                          MainView(project: $selectedProject)
            } else {
                // Pass the projects to SideView
                SideView(showProjects: $showProjects, projects: projects, selectedProject: $selectedProject)
                ProjectView(showProjects: $showProjects, showingAddProjectForm: $showingAddProjectForm)
                    .sheet(isPresented: $showingAddProjectForm) {
                        AddProjectForm()
                    }
            }
        }
    }
    
    // Options for ListView
    var options: [Option] {
        [
            Option(title: "Settings", imageName: "gearshape") // Keep the "Settings" option
        ] 
    //    + projects.map { project in
    //        Option(title: project.projectName, imageName: "folder.fill")
    //    }
    }
}

struct SideView: View {
    @Binding var showProjects: Bool
    let projects: [Project]
    @Binding var selectedProject: Project?
    @EnvironmentObject var viewModel: ProjectViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Button(action: {
                    showProjects.toggle()
                }, label: {
                    HStack {
                        Text("Recent Project").foregroundColor(.black).fontWeight(.semibold)
                        Image(systemName: "book.pages.fill").foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .cornerRadius(100)
                })
                
                // Display list of projects
                ForEach(viewModel.projects) { project in
                    Button(action: {
                        selectedProject = project
                        showProjects.toggle()
                    }) {
                        HStack {
                            Text(project.projectName).foregroundColor(.black)
                            Image(systemName: "folder.fill").foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .cornerRadius(100)
                    }
                }
                
                Spacer()
            }
            .padding()
            .background(Color.white).ignoresSafeArea(edges: .bottom)
        }
    }
}

struct ProjectView: View {
    @Binding var showProjects: Bool
    @Binding var showingAddProjectForm: Bool
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Spacer()
                    Image("ChordCraft1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 130, alignment: .centerLastTextBaseline)
                        .padding(.top, 44)
                    
                    Text("Parcel")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Version 1.0.0")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    Button {
                        showingAddProjectForm = true
                    } label: {
                        Image(systemName: "plus.square")
                        Text("Create New Project...")
                            .padding(.leading, -89)
                            .padding(.vertical, 8)
                            .frame(maxWidth: 250)
                            .cornerRadius(8)
                    }
                    .frame(minWidth: 280, maxWidth: 280)
                    .padding(.bottom, 4)
                    
                    Button {
                        showProjects.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "folder")
                            Spacer()
                            Text("Open Existing Project...")
                                .padding(.leading, -89)
                                .padding(.vertical, 8)
                                .frame(maxWidth: 250)
                                .cornerRadius(8)
                        }
                    }
                    .frame(minWidth: 280, maxWidth: 280)
                }
                .padding(.bottom, 70)
            }
            .padding(.leading, 100)
            .padding(.trailing, 100)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
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

        return StartUpPage()
            .environmentObject(ProjectViewModel(modelContainer: modelContainer))
    }
}

