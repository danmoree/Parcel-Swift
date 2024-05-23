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
}
