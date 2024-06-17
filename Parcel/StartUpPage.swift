//
//  ContentView.swift
//  Parcel
//
// Start up page that shows recently worked on projects and lets user create a new project
//


import SwiftUI
import SwiftData

struct StartUpPage: View {
    // Variables
    @State private var showProjects = false
    @State private var showingAddProjectForm = false
    
    @EnvironmentObject var viewModel: ProjectViewModel
    
    @Binding var isShowingStartupPage: Bool
    @Binding var selectedProject: Project? // keep track of selected project
    
    

    var body: some View {
       
        ProjectView(showProjects: $showProjects, showingAddProjectForm: $showingAddProjectForm, isShowingStartupPage: $isShowingStartupPage, selectedProject: $selectedProject)
           
           
        
    }
    
   
}



// Actual start up page
struct ProjectView: View {
    @Binding var showProjects: Bool
    @Binding var showingAddProjectForm: Bool
    @Binding var isShowingStartupPage: Bool

    @Binding var selectedProject: Project? // keep track of selected project
    
    @EnvironmentObject var viewModel: ProjectViewModel
    var body: some View {
        HStack {
               // Recent projects
               VStack(alignment: .leading) {
                //   Text("Saved Projects")
                //       .font(.headline)
                //       .fontWeight(.medium)
                //       .foregroundColor(Color.black)
                //       .padding(.top)
                   
                   ForEach(viewModel.projects) { project in
                       Button(action: {
                           selectedProject = project
                           isShowingStartupPage.toggle()
                       }) {
                           HStack {
                               Text(project.projectName)
                                   .foregroundColor(.black)
                               Image(systemName: "folder.fill")
                                   .foregroundColor(.black)
                           }
                           .frame(maxWidth: 100, maxHeight: 50)
                           .cornerRadius(100)
                       }
                       .padding(.vertical, 4)
                       .focusable(false)
                   }
                
                   
                   Spacer()
               }
               .frame(minWidth: 135, maxHeight: .infinity)
               .background(Color.white)
               //.padding(.leading, 40)
               
               Spacer()
               
               // Main content
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
                   .focusable(false)
                   .sheet(isPresented: $showingAddProjectForm) {
                       AddProjectForm()
                           .frame(width: 400, height: 500)
                   }
                   
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
                   .padding(.bottom, 70)
                   .focusable(false)
               }
               .padding(.trailing)
            Spacer()
           }
        .frame(minWidth: 700, minHeight: 400)
           //.padding(.horizontal, 20)
        }
    }


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let schema = Schema([
//            Song.self, Project.self
//        ])
//
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
//
//        let modelContainer: ModelContainer
//        do {
//            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//
//        return StartUpPage()
//            .environmentObject(ProjectViewModel(modelContainer: modelContainer))
//    }
//}


struct StartUpPage_Previews: PreviewProvider {
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

        let sampleProjects = [
            Project(projectName: "Project 1"),
            Project(projectName: "Project 2"),
            Project(projectName: "Project 3")
        ]

        let viewModel = ProjectViewModel(modelContainer: modelContainer)
        viewModel.projects = sampleProjects

        return StartUpPage(isShowingStartupPage: .constant(true), selectedProject: .constant(nil))
            .environmentObject(viewModel)
    }
}
