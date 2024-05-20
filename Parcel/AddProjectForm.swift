//
//  AddProjectFrom.swift
//  ChordCraft
//
import Cocoa
import SwiftData
import SwiftUI

struct AddProjectForm: View {
   
    
    // style
    struct myRoundedTextFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(5)
                .background(.gray)
                .cornerRadius(9)
                .opacity(0.3)
                
                
        }
    }
    
    
    
    @State private var projectName: String = ""
    @State private var artistName: String = ""
    @State private var buttonText = "Create Project"
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Spacer()
                Button(action: {
                    // Define the action you want the button to perform here
                    print("Button was tapped")
                   // self.showingAddSongForm = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title) // Optional: Adjust the size of the image
                        .foregroundColor(.gray) // Optional: Change the color of the image
                    
                }
            } // end of close button hstack
            .buttonStyle(PlainButtonStyle())
            .padding(.all, 12)
            
            HStack {
                Text("New Project")
                    .font(.title)
                    .fontWeight(.medium)
                Image(systemName: "music.note")
                    .font(.system(size: 18))
                
                
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
              //      if addItem() {
              //          self.buttonText = "Song added!"
              //      } else {
              //          self.buttonText = "failed, try again"
              //      }
                }) {
                    
                    Text(buttonText)
                        .padding(.horizontal, 100)
                        .padding(.vertical)
                        .cornerRadius(10)  // Corner radius applied to the entire Label
                    
                    
                }
                
            }
            .padding(.bottom, 30)
            
        } // end of main vstack
        
    }
    } // end of view


struct AddProjectForm_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectForm()
            .frame(width: 600, height: 500)  // Specifies the frame size for the view
                       .previewLayout(.sizeThatFits)
         //   .modelContainer(for: Item.self, inMemory: false)    // comented out to fix preview and make it visible
            // Provide any required environment objects or settings here
    }
}
