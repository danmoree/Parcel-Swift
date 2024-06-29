//
//  AddsongForm.swift
//  Parcel
//
//  View to add a new song to project
import SwiftData
import SwiftUI



// PRE: 1) showingAddSongForm - open/dismiss the sheet
//      2) selectedProject - project object to add song to
// POST: A view to build a song object with its own attributes
struct AddsongForm: View {
    @Binding var showingAddSongForm: Bool
    @Binding var selectedProject: Project?
    
    @EnvironmentObject var viewModel: ProjectViewModel
    
    // variables to store input
    @State private var buttonText = "Add"
    @State private var songName: String = ""
    @State private var songG: String = ""
    @State var songkey: String = ""
    @State var songtempo: String = ""
    @State var startrate: String = ""
    @State var notesInput: String = ""
    @State var stagein: String = ""
    @State private var bookmarkDataa: Data? = nil
    
    @State private var selectedFilePath: String?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                
                Spacer()
                
                Button(action: {
                    print("Button was tapped")
                    self.showingAddSongForm = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .focusable(false)
            }
            
            HStack {
                Text("New Song")
                    .font(.title)
                    .fontWeight(.medium)
                Image(systemName: "music.note")
                    .font(.system(size: 18))
                
                
                Spacer()
                
            }
            .padding(.leading, 40)
            
            HStack {
                Spacer()
            }
            HStack {
                
                // left side
                VStack{
                    
                    VStack {
                        HStack {
                            Text("Title")
                                .font(.title2)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        TextField("Song Name", text: $songName)
                            .textFieldStyle(myRoundedTextFieldStyle())
                    }
                    .padding(.bottom, 20)
                    
                    VStack {
                        HStack {
                            Text("Genre")
                                .font(.title2)
                                .fontWeight(.medium)
                            
                            Spacer()
                        }
                        TextField("Song Genre", text: $songG)
                            .textFieldStyle(myRoundedTextFieldStyle())
                    }
                    .padding(.bottom, 20)
                    
                    VStack {
                        HStack {
                            Text("Tempo")
                                .font(.title2)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                        }
                        
                        TextField("Song Tempo", text: $songtempo)
                            .textFieldStyle(myRoundedTextFieldStyle())
                    }
                    .padding(.bottom, 20)
                    
                    VStack {
                        HStack {
                            Text("Rating")
                                .font(.title2)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        
                        TextField("Rating 0-5", text: $startrate)
                            .textFieldStyle(myRoundedTextFieldStyle())
                        
                    }
                    .padding(.bottom, 20)
                    
                    VStack {
                        HStack {
                            Text("Key")
                                .font(.title2)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        TextField("Song Key", text: $songkey)
                            .textFieldStyle(myRoundedTextFieldStyle())
                    }
                    .padding(.bottom, 20)
                    
                } // end of left side vstack
                
                Spacer()
                Spacer()
                Spacer()
                
                // start of right side vstack
                VStack {
                    
                    VStack {
                        HStack {
                            Text("Notes")
                                .font(.title2)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        
                        TextField("Song Notes", text: $notesInput)
                            .textFieldStyle(myRoundedTextFieldStyle2())
                    }
                    .padding(.bottom, 20)
                    
                    VStack {
                        HStack{
                            Text("Stage of production")
                                .fontWeight(.medium)
                                .font(.title2)
                            Spacer()
                            
                            
                        }
                        
                        HStack {
                            DropdownMenuView(selectedOption: $stagein)
                            Spacer()
                        }
                        
                    }
                    .padding(.bottom, 20)
                    
                    
                    VStack {
                        HStack{
                            Text("Select file")
                                .font(.title2)
                                .fontWeight(.medium)
                            Spacer()
                            
                            
                        }
                        
                        HStack {
                            Button(action: {
                                openFileSelectionDialog()
                            }) {
                                Label {
                                    Image(systemName: "doc.badge.plus")
                                        .font(.system(size: 18))
                                } icon: {
                                    
                                }
                                .padding()
                                .background(Color.gray.opacity(0.4))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                            
                            Spacer()
                        }
                        
                    }
                    .padding(.bottom, 20)
                    
                    Spacer()
                    Spacer()
                    
                } // end of right side vstack
                .padding()
                
                Spacer()
                
            }
            .padding(.leading, 40) // end of hstack
            
            HStack {
                Button(action: {
                    if addItem() {
                        self.buttonText = "Song added!"
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        self.buttonText = "failed, try again"
                    }
                }) {
                    
                    Text(buttonText)
                        .padding(.horizontal, 100)
                        .padding(.vertical)
                        .background(Color.gray.opacity(0.4))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                }
                
            }
            .padding(.bottom, 30)
            
        } // end of v stack
        .padding()
        .buttonStyle(PlainButtonStyle())
        
    }
    
    // Drop down for the stage box
    struct DropdownMenuView: View {
        @Binding var selectedOption: String
        let options = ["Completed", "Mastering", "Mixing", "Arranging", "Ideas"]
        let initialText: String = "Select an Option"
        
        var body: some View {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(option, action: {
                        selectedOption = option
                    })
                }
            } label: {
                Label(selectedOption == "" ? initialText : selectedOption, systemImage: "chevron.down")
                    .padding(.horizontal, 60)
                    .padding(.top, 7)
                    .padding(.bottom, 7)
                    .background(.gray)
                    .opacity(0.3)
                    .cornerRadius(15)
                
            }
            
        }
    }

    // Text field for the small boxes
    struct myRoundedTextFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(5)
                .background(.gray)
                .cornerRadius(9)
                .opacity(0.3)
            
            
        }
    }

    // Text field for notes box
    struct myRoundedTextFieldStyle2: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(50)
                .background(.gray)
                .cornerRadius(15)
                .opacity(0.3)
            
            
        }
    }

    
    // Add song to project
    private func addItem() -> Bool {
        guard let selectedProject = selectedProject else { return false }
        if let tempoin = Double(songtempo), let rating = Double(startrate) {
            let newItem = Song(title: songName, filePath: selectedFilePath ?? "", tempo: tempoin, genre: songG, key: songkey, starRating: rating, notes: notesInput, stage: stagein, bookmarkData: bookmarkDataa)
            withAnimation {
                viewModel.addSongToProject(project: selectedProject, song: newItem)
            }
            return true
        } else {
            return false
        }
    }
    
    // Opens up finder to select the song path and saves it using a bookmark
    func openFileSelectionDialog() {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = false
        
        openPanel.begin { result in
            if result == .OK, let url = openPanel.urls.first {
                // Saving the file path
                self.selectedFilePath = url.path
                
                // Attempt to save the bookmark data
                do {
                    let bookmarkData = try url.bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
                    self.bookmarkDataa = bookmarkData
                } catch {
                    print("Failed to save bookmark data: \(error)")
                    self.bookmarkDataa = nil  // Ensure the bookmark data is nil if there's an error
                }
            }
        }
    }
}


struct AddsongForm_Previews: PreviewProvider {
    static var previews: some View {
        AddsongForm(showingAddSongForm: .constant(true), selectedProject: .constant(Project(projectName: "Sample Project")))
            .frame(width: 700, height: 800)
            .previewLayout(.sizeThatFits)
            .environmentObject(ProjectViewModel(modelContainer: {
                let schema = Schema([Song.self, Project.self])
                let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
                return try! ModelContainer(for: schema, configurations: [configuration])
            }()))
    }
}

