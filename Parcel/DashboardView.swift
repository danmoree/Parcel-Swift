//
//  Dashboard.swift
//  Parcel
//
//  Main view for app
//
import SwiftUI
import SwiftData

// dashboard
// PRE: 1) var project, needs the project from the db to display its songs
// POST: Shows the songs within the project in their current stage of production. 
struct Dashboard : View {
    // all variables needed
    @State private var headerMessage: String = ""   // variables that can change??
    @State private var showingAddSongForm = false
    @State private var showingProjectSettings = false
    @Binding var project: Project?  // Parameter like variable
    @EnvironmentObject var viewModel: ProjectViewModel // lets this file get access to the ProjectViewModel file
    
    // grabs the songs from the project, and stores in a list called songs
    var songs: [Song] {
         return project?.songs ?? []
     }
    
    // start of view
    var body: some View {
        ZStack{
           
            // background img
          //  GeometryReader { geometry in
          //      Image("leaf")
          //          .resizable()
          //          .scaledToFill()
          //          .edgesIgnoringSafeArea(.all)
          //          .opacity(1)
          //          .frame(width: geometry.size.width, height: geometry.size.height)
          //          .blur(radius: 1.5)
          //          .clipped()
          //  }
            
        ScrollView {
                VStack {
                    //Spacer()
                    // Header message
                    // this gets updated bassed on the time
                    // 3am - 12pm - Good Morning!
                    // 12pm - 6pm - Good Afternoon!
                    // 6pm - 3am  - Good Evening!
                    Text(headerMessage).font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, idealHeight: 40, alignment: .leading)
                        .padding(.leading)
                        .onAppear(perform: updateHeaderMessage) // calls function
                        Spacer()
                        Spacer()
                    
                    // if let makes sure "project" isnt nil (null)
                    if let project = project {
                        HStack {
                            // Project title
                            Text(project.projectName).font(.title).fontWeight(.medium).padding(.leading)
                            Spacer()
                            
                            // calls addButton
                            addButton(action: {
                                print("Button tapped")
                                showingAddSongForm = true   // opens up sheet
                                
                            })
                            .padding(.bottom,-20)
                            
                            projectSettingsButton(action: {
                                showingProjectSettings = true
                            })
                            .padding(.bottom,-20)
                        } // end of hstack
                        // Modifier to open up sheet to add a new song
                        .sheet(isPresented: $showingAddSongForm) {
                            AddsongForm(showingAddSongForm: $showingAddSongForm, selectedProject: $project)
                                .frame(width: 800, height: 700)
                        }
                        .sheet(isPresented: $showingProjectSettings) {
                            ProjectSettings(showingProjectSettings: $showingProjectSettings)
                                .frame(width: 500, height: 500)
                        }
                        
                        
                        HStack {
                            // Artist name
                            Text(project.artistName).font(.headline).fontWeight(.thin)
                                .padding(.leading, 17.0)
                            Spacer()
                        }
                    }
                    
                    // divider
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .padding(.leading, 16.0)
                        .frame(height: 3)
                        .opacity(0.4)
                    
                    Spacer()
                    Spacer()
                        
                    // loading rows in view
                    // completed row
                    
                    // filters the songs into a list based on stage given
                    let completedSongs = songs.filter {$0.stage == "Completed"}
                    
                    let completedCount = completedSongs.count
                    ZStack {
                        RoundedRectangle(cornerRadius: 15,style: .continuous)
                            .background(
                                .ultraThinMaterial,
                                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                             )
                            .opacity(0.1)
                            .padding(.leading, 8.0)
                        HStack {
                            //Call SubsectionView to be displayed
                            SubsectionView(songCount: completedCount, title: "Completed", songs: completedSongs)
                            Spacer()
                            
                        }
                        .padding()
                    }
                    Spacer()
                    Spacer()
                    // Mastering row
                    let masteredSongs = songs.filter {$0.stage == "Mastering"}
                    let masteringCount = masteredSongs.count
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 15,style: .continuous)
                            .background(
                                .ultraThinMaterial,
                                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                             )
                            .opacity(0.1)
                            .padding(.leading, 8.0)
                        HStack {
                            SubsectionView(songCount: masteringCount, title: "Mastering", songs: masteredSongs)
                            Spacer()
                        }
                        .padding()
                    }
                    Spacer()
                    Spacer()
                    
                    // mixing row
                    let mixedSongs = songs.filter {$0.stage == "Mixing"}
                    let mixingCount = mixedSongs.count
                    ZStack {
                        RoundedRectangle(cornerRadius: 15,style: .continuous)
                            .background(
                                .ultraThinMaterial,
                                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                             )
                            .opacity(0.1)
                            .padding(.leading, 8.0)
                        HStack {
                            SubsectionView(songCount: mixingCount, title: "Mixing", songs: mixedSongs)
                            Spacer()
                        }
                        .padding()
                    }
                    
                    Spacer()
                    Spacer()
                    
                    // arranging row
                    let arrangingSongs = songs.filter {$0.stage == "Arranging"}
                    let arrangingCount = arrangingSongs.count
                    ZStack {
                        RoundedRectangle(cornerRadius: 15,style: .continuous)
                            .background(
                                .ultraThinMaterial,
                                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                             )
                            .opacity(0.1)
                            .padding(.leading, 8.0)
                        HStack {
                            SubsectionView(songCount: arrangingCount, title: "Arranging", songs: arrangingSongs)
                            Spacer()
                        }
                        .padding()
                    }
                    
                    Spacer()
                    Spacer()
                    
                    // ideas row
                    let ideaSongs = songs.filter {$0.stage == "Ideas"}
                    let ideaCount = ideaSongs.count
                    ZStack {
                        RoundedRectangle(cornerRadius: 15,style: .continuous)
                            .background(
                                .ultraThinMaterial,
                                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                             )
                            .opacity(0.1)
                            .padding(.leading, 8.0)
                        HStack {
                            SubsectionView(songCount: ideaCount, title: "Ideas", songs: ideaSongs)
                            Spacer()
                        }
                        .padding()
                    }
                    Spacer()
                    Spacer()
                    
                    // All row
                    let allCount = songs.count
                    ZStack {
                        RoundedRectangle(cornerRadius: 15,style: .continuous)
                            .background(
                                .ultraThinMaterial,
                                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                             )
                            .opacity(0.1)
                            .padding(.leading, 8.0)
                        HStack {
                            SubsectionView(songCount: allCount, title: "All", songs: songs)
                            Spacer()
                        }
                        .padding()
                    }
                }
                .padding()
                Spacer()
            }
       .padding(.top, 1)
        }
    }
       
    // func to update the header message
    func updateHeaderMessage() {
           let currentTime = Date()
           let calendar = Calendar.current
           let hour = calendar.component(.hour, from: currentTime)
           
           if hour >= 3 && hour < 12 {
               headerMessage = "Good Morning! ☀️"
           } else if hour >= 12 && hour < 18 {
               headerMessage = "Good Afternoon! ⛱️"
           } else {
               headerMessage = "Good Evening! 🌙"
           }
       }
}

// Generic view for a row in dashboard
// PRE: 1) songCount, number of songs in row
//      2) title, title name for the row
//      3) songs, list of songs to be displayed
//
// POST: A row that displays the name of the row, number of songs belonging and clickable songs
struct SubsectionView: View {
    @State private var isExpanded: Bool = true
    @State private var selectedSong: Song?
    @State private var showingSongView = false
    
    let songCount: Int
    let title: String
    let songs: [Song]

   
    var body: some View {
        VStack(alignment: .leading) {
            // row title
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                    
                    Button(action: {
                                      withAnimation {
                                          isExpanded.toggle()
                                      }
                                  }) {
                                      Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                          .foregroundColor(.white)
                                          .padding(.horizontal,2)
                                          .font(.system(size: 15))
                                  }
                                  .buttonStyle(PlainButtonStyle())
                }
                Text("\(songCount)")  // Using string interpolation to convert Int to String
                    .font(.title2)
                    .fontWeight(.light)
                    .padding(.leading, 1)
            }
            
            if isExpanded {
                ScrollView(.horizontal, showsIndicators: true) {
                             HStack(spacing: 20) {
                                 ForEach(songs) { song in
                                     Button(action: {
                                         self.selectedSong = song
                                         self.showingSongView = true // open up SongView
                                     }) {
                                         VStack {
                                             HStack {
                                                 Image(systemName: "folder.fill")
                                                     .padding()
                                             }
                                             Text(song.title)
                                         }
                                     }
                                 } // end of for each
                             }
                            
                         }
                .sheet(isPresented: $showingSongView) {
                        songView(showingSongView: $showingSongView, currentSong: $selectedSong)
                            .frame(width:700, height: 400)
                }
                         .frame(maxWidth: .infinity)
                       
                      } // end of if
        }
        // .border(.orange)
        .padding()
        .cornerRadius(10)
       
        
        }
    }
    

// add new song button, top right
struct addButton: View {
    var action: () -> Void
    @State private var isHovering = false

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: isHovering ? 21 : 20))
                .foregroundColor(isHovering ? .black.opacity(0.8) : .gray)
        }
        .frame(width: 30, height: 30)
        .buttonStyle(.plain)
        .background(isHovering ? Color.gray.opacity(0.2) : Color.clear)
        .cornerRadius(5)
        .onHover { hover in
            withAnimation(.easeInOut) {
                isHovering = hover
            }
        }
    }
}

// add new button, top right
struct projectSettingsButton: View {
    var action: () -> Void
    @State private var isHovering = false

    var body: some View {
        Button(action: action) {
            Image(systemName: "ellipsis")
                .font(.system(size: isHovering ? 21 : 20))
                .foregroundColor(isHovering ? .black.opacity(0.8) : .gray)
        }
        .frame(width: 30, height: 30)
        .buttonStyle(.plain)
        .background(isHovering ? Color.gray.opacity(0.2) : Color.clear)
        .cornerRadius(5)
        .onHover { hover in
            withAnimation(.easeInOut) {
                isHovering = hover
            }
        }
    }
}

// Defines a struct to represent an option with a title and an image name
struct Option: Hashable {
    let title: String
    let imageName: String
}



struct Dashboard_Previews: PreviewProvider {
    @State static var sampleProject: Project? = Project(projectName: "Sample Project") // Create an optional sample project
    static var previews: some View {
        Dashboard(project: $sampleProject)
            .frame(width: 900, height: 600)  // Specifies the frame size for the view
                       .previewLayout(.sizeThatFits)
    }
}




