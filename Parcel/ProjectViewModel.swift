//
//  ViewModel for the Model container, swift data
//
//
import SwiftData
import Combine

@MainActor
class ProjectViewModel: ObservableObject {
    @Published var projects: [Project] = []
    private let modelContainer: ModelContainer

    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        fetchProjects()
    }

    func fetchProjects() {
        // Fetch projects from the database using SwiftData's fetch mechanism
        let context = modelContainer.mainContext
        let fetchDescriptor = FetchDescriptor<Project>()

        do {
            let projects = try context.fetch(fetchDescriptor)
            self.projects = projects
        } catch {
            print("Failed to fetch projects: \(error)")
        }
    }

    func addProject(projectName: String, artistName: String) {
        let newProject = Project(projectName: projectName)
        newProject.artistName = artistName

        // Save the new project to the database
        let context = modelContainer.mainContext
        context.insert(newProject)

        do {
            try context.save()
            projects.append(newProject)
        } catch {
            print("Failed to save the project: \(error)")
        }
    }
    
    func addSongToProject(project: Project, song: Song) {
          let context = modelContainer.mainContext
          project.addSong(song)
          context.insert(song)

          do {
              try context.save()
          } catch {
              print("Failed to save the song: \(error)")
          }
      }
    
    func removeSong(from project: Project, song: Song) {
            project.songs.removeAll { $0.id == song.id }
            modelContainer.mainContext.delete(song)
            do {
                try modelContainer.mainContext.save()
            } catch {
                print("Failed to remove song from project: \(error)")
            }
        }
    
    func deleteProject(project: Project) {
        let context = modelContainer.mainContext
        context.delete(project)
        
        do {
            try context.save()
            if let index = projects.firstIndex(of: project) {
                projects.remove(at: index)
            }
        } catch {
            print("Failed to delete the project: \(error)")
        }
    }
    
    func renameProject (_ project: Project, to newName: String) {
        // set new name
        project.projectName = newName
        
        // save the change
        do {
            try modelContainer.mainContext.save()
        } catch {
            print("Failed to save new project name: \(error)")
        }
    }
    
    func renameArtist (_ project: Project, to newArtist: String) {
        // set new name
        project.artistName = newArtist
        
        // save the change
        do {
            try modelContainer.mainContext.save()
        } catch {
            print("Failed to save new artist name: \(error)")
        }
        
    }
}
