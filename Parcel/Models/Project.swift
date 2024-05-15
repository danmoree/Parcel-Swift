import Foundation
import SwiftData

@Model
class Project {
    @Attribute var projectName: String
    @Attribute var dateCreated: String
    @Attribute var artistName: String
    @Relationship(deleteRule: .cascade, inverse: \Song.project) var songs: [Song]

    init(projectName: String) {
        self.projectName = projectName
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.dateCreated = dateFormatter.string(from: Date())
        self.songs = []
        self.artistName = ""
    }

    func addSong(_ song: Song) {
        songs.append(song)
        song.project = self
    }
}

