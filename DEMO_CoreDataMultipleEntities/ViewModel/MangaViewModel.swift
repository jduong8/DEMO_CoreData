//
//  MangaViewModel.swift
//  DEMO_CoreDataMultipleEntities
//
//  Created by Jonathan Duong on 30/05/2023.
//

import Foundation
import CoreData

class MangaViewModel: ObservableObject {
    @Published var mangas: [Manga] = []
    @Published var newManga: String = ""
    private var viewContext: NSManagedObjectContext

    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        fetchMangas()
    }

    private func fetchMangas() {
        let fetchRequest: NSFetchRequest<Manga> = Manga.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Manga.name, ascending: true)]
        do {
            mangas = try viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch mangas: \(error)")
        }
    }

    func addManga() {
        let manga = Manga(context: viewContext)
        manga.name = newManga
        manga.timestamp = Date()
        saveContext()
        fetchMangas()
        newManga = ""
    }

    func deleteMangas(offsets: IndexSet) {
        offsets.forEach { index in
            let manga = mangas[index]
            viewContext.delete(manga)
        }
        saveContext()
        fetchMangas()
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
