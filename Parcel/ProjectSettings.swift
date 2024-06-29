//
//  ProjectSettings.swift
//  Parcel
//
//  Created by Daniel Moreno on 6/21/24.
//

import SwiftUI
import SwiftData

struct ProjectSettings: View {
    
    @State private var projectName: String = ""
    @State private var artistName: String = ""
    @State private var buttonText = "Save Changes"
    @State private var showAlert = false
    
    @Binding var project: Project?
    @Binding var showingProjectSettings: Bool
    
    @EnvironmentObject var viewModel: ProjectViewModel
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                
                Spacer()
                
                // delete button
                Button(action: {
                    showAlert = true
                }) {
                    Image(systemName: "trash")
                        .font(.title)
                        .foregroundColor(.red)
                }
                .padding(.trailing, 6)
                
                
                // Close/dismiss button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.all, 12)
            .focusable(false)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete Project"),
                    message: Text("Are you sure you want to delete this project? This action cannot be undone!"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let project = project {
                            viewModel.deleteProject(project: project)
                            //deleteProjectAndRelaunch()
                        }
                        
                    },
                    secondaryButton: .cancel()
                )
            }
            
            HStack {
                Text("Project Settings ")
                    .font(.title)
                    .fontWeight(.medium)
                Image(systemName: "gearshape")
                    .font(.title)
                Spacer()
            }
            .padding(.leading, 40)
            
            VStack {
                HStack {
                    Text("Project Title")
                        .font(.title2)
                        .fontWeight(.medium)
                    Spacer()
                }
                
                HStack {
                    TextField("Project Title", text: $projectName)
                        .textFieldStyle(myRoundedTextFieldStyle())
                        .frame(maxWidth: 250)
                    Spacer()
                }
            }
            .padding(.bottom, 20)
            .padding(.horizontal, 40)
            
            VStack {
                HStack {
                    Text("Artist Name")
                        .font(.title2)
                        .fontWeight(.medium)
                    Spacer()
                }
                
                HStack {
                    TextField("Artist Name", text: $artistName)
                        .textFieldStyle(myRoundedTextFieldStyle())
                        .frame(maxWidth: 250)
                    Spacer()
                }
            }
            .padding(.bottom, 20)
            .padding(.horizontal, 40)
            
            // Future layout options
            VStack {
                HStack {
                    //Text("Layout")
                    //    .font(.title2)
                    //    .fontWeight(.medium)
                    Spacer()
                }
                
            }
            .padding(.bottom, 20)
            .padding(.horizontal, 40)
            
            Spacer()
            
            HStack {
                Button(action: {
                    viewModel.addProject(projectName: projectName, artistName: artistName)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(buttonText)
                        .padding(.horizontal, 100)
                        .padding(.vertical)
                        .cornerRadius(10)
                }
            }
            .padding(.bottom, 30)
        }
    }
    
    // Style for the custom text field style
    struct myRoundedTextFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(5)
                .background(.gray)
                .cornerRadius(9)
                .opacity(0.3)
        }
    }
    
    
    
    
    
    
    
    struct ProjectSetting_Previews: PreviewProvider {
        
        static var previews: some View {
            ProjectSettings(project: .constant(Project(projectName: "Sample Project")), showingProjectSettings: .constant(true))
                .frame(width: 600, height: 500)
                .previewLayout(.sizeThatFits)
                .environmentObject(ProjectViewModel(modelContainer: {
                    let schema = Schema([Song.self, Project.self])
                    let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
                    return try! ModelContainer(for: schema, configurations: [configuration])
                }()))
        }
    }
}
