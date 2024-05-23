import SwiftUI
import SwiftData

struct AddProjectForm: View {
    @EnvironmentObject var viewModel: ProjectViewModel
    @State private var projectName: String = ""
    @State private var artistName: String = ""
    @State private var buttonText = "Create Project"
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
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

            HStack {
                Text("New Project 💿")
                    .font(.title)
                    .fontWeight(.medium)
                Spacer()
            }
            .padding(.leading, 40)

            VStack {
                HStack {
                    Text("Name")
                        .font(.title2)
                        .fontWeight(.medium)
                    Spacer()
                }

                HStack {
                    TextField("Project Name", text: $projectName)
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

    struct myRoundedTextFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(5)
                .background(.gray)
                .cornerRadius(9)
                .opacity(0.3)
        }
    }
}

struct AddProjectForm_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectForm()
            .frame(width: 600, height: 500)
            .previewLayout(.sizeThatFits)
            .environmentObject(ProjectViewModel(modelContainer: {
                let schema = Schema([Song.self, Project.self])
                let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
                return try! ModelContainer(for: schema, configurations: [configuration])
            }()))
    }
}
