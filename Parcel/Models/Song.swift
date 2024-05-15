import Foundation
import SwiftData

@Model
class Song {
    @Attribute var title: String
    @Attribute var filePath: String
    @Attribute var bookmarkData: Data?
    @Attribute var dateCreated: String
    @Attribute var tempo: Double
    @Attribute var genre: String
    @Attribute var key: String
    @Attribute var starRating: Double
    @Attribute var notes: String
    @Attribute var stage: String
    var project: Project?

    init(title: String, filePath: String, tempo: Double, genre: String, key: String, starRating: Double, notes: String, stage: String, bookmarkData: Data? = nil) {
        self.title = title
        self.filePath = filePath
        self.bookmarkData = bookmarkData
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        self.dateCreated = dateFormatter.string(from: Date())
        self.tempo = tempo
        self.genre = genre
        self.key = key
        self.starRating = starRating
        self.notes = notes
        self.stage = stage
    }
}

