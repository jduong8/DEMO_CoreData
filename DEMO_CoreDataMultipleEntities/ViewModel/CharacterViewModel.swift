//
//  CharacterViewModel.swift
//  DEMO_CoreDataMultipleEntities
//
//  Created by Jonathan Duong on 30/05/2023.
//

import Foundation
import CoreData

class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var name: String = ""
    @Published var description: String = ""
    var viewContext: NSManagedObjectContext
    let manga: Manga

    init(viewContext: NSManagedObjectContext, manga: Manga) {
        self.viewContext = viewContext
        self.manga = manga
        fetchCharacters()
    }

    private func fetchCharacters() {
        let fetchRequest: NSFetchRequest<Character> = Character.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Character.name, ascending: true)]
        do {
            characters = try viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch characters: \(error)")
        }
    }

    func addCharacter() {
        let newCharacter = Character(context: viewContext)
        newCharacter.name = name
        newCharacter.descriptions = description
        newCharacter.manga = manga
        saveContext()
        fetchCharacters()
    }

    func deleteCharacters(at offsets: IndexSet) {
        offsets.forEach { index in
            let character = characters[index]
            viewContext.delete(character)
        }
        saveContext()
        fetchCharacters()
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}


