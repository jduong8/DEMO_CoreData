//
//  MangaViewModel.swift
//  DEMO_CoreDataMultipleEntities
//
//  Created by Jonathan Duong on 30/05/2023.
//

import Foundation
import CoreData

/// `MangaViewModel` is an ObservableObject that manages the creation, deletion, and retrieval of `Manga` objects.
class MangaViewModel: ObservableObject {
    /// An array of `Manga` that contains the list of mangas fetched from the database.
    @Published var mangas: [Manga] = []
    /// A string that stores the name of the new manga to be added to the database.
    @Published var newManga: String = ""
    /// The `NSManagedObjectContext` used for interacting with the Core Data database.
    private var viewContext: NSManagedObjectContext

    /// Initializes a new `MangaViewModel` object.
    ///
    /// - Parameter viewContext: The `NSManagedObjectContext` to use for interacting with the database.
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        fetchMangas()
    }

    /// Fetches mangas from the database and sorts them by name in ascending order.
    private func fetchMangas() {
        let fetchRequest: NSFetchRequest<Manga> = Manga.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Manga.name, ascending: true)]
        do {
            mangas = try viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch mangas: \(error)")
        }
    }

    /// Creates a new `Manga` object with the name stored in `newManga`, adds it to the database,
    /// then refreshes the list of mangas and resets `newManga` to an empty string.
    func addManga() {
        let manga = Manga(context: viewContext)
        manga.name = newManga
        manga.timestamp = Date()
        saveContext()
        fetchMangas()
        newManga = ""
    }

    /// Deletes mangas at the specified indices from the database,
    /// then refreshes the list of mangas.
    ///
    /// - Parameter offsets: The indices of the mangas to delete.
    func deleteMangas(offsets: IndexSet) {
        offsets.forEach { index in
            let manga = mangas[index]
            viewContext.delete(manga)
        }
        saveContext()
        fetchMangas()
    }

    /// Saves the current context.
    /// If the context cannot be saved, an error is printed.
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
