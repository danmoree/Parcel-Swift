import Foundation
import SwiftData

@Model
class song {
    var title: String
    var filePath: String
    var bookmarkData: Data? 
    var dateCreated: String
    var tempo: Double
    var genre: String
    var key: String
    var starRating: Double
    var notes: String
    var stage: String
    
    init(title: String, filePath: String, tempo: Double, genre: String, key: String, starRating: Double, notes: String, stage: String, bookmarkData: Data? = nil) {
        self.title = title
        self.filePath = filePath
        self.bookmarkData = bookmarkData // Initialize the bookmark data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy" // Define the date format you want
        self.dateCreated = dateFormatter.string(from: Date())
        self.tempo = tempo
        self.genre = genre
        self.key = key
        self.starRating = starRating
        self.notes = notes
        self.stage = stage
    }
    
    // update functions
    func updateTitle(newTitle: String) {
        self.title = newTitle
    }
    
    func updateFilePath(newFilePath: String) {
        self.filePath = newFilePath
    }
    
    func updateBookmarkData(newBookmarkData: Data) {
        self.bookmarkData = newBookmarkData
    }
    
    func updateTempo(newTempo: Double) {
        self.tempo = newTempo
    }
    
    func updateGenre(newGenre: String) {
        self.genre = newGenre
    }
    
    func updateKey(newKey: String) {
        self.key = newKey
    }
    
    func updateStarRating(newStarRating: Double) {
        self.starRating = newStarRating
    }
    
    func updateNotes(newNotes: String) {
        self.notes = newNotes
    }
}

