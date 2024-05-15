
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
    
    init() {
           // Initialize with hardcoded projects for testing
          
           let project1 = Project(projectName: "Project 1")
           project1.artistName = "Kanye West"
           let project2 = Project(projectName: "Project 2")
           project2.artistName = "Taylor Swift"
           let project3 = Project(projectName: "Project 3")
        project3.artistName = "Daniel Moreno"

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
                ProjectView(showProjects: $showProjects)
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
                ForEach(projects, id: \.self) { project in
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
                        // Handle create new project action
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
        StartUpPage()
    }
}

