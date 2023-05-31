//
//  CharacterViewModel.swift
//  DEMO_CoreDataMultipleEntities
//
//  Created by Jonathan Duong on 30/05/2023.
//

import Foundation
import CoreData

/// `CharacterViewModel` is an ObservableObject that manages the creation, deletion, and retrieval of `Character` objects.
class CharacterViewModel: ObservableObject {
    /// An array of `Character` that contains the list of characters fetched from the database.
    @Published var characters: [Character] = []

    /// A string that stores the name of the new character to be added to the database.
    @Published var name: String = ""

    /// A string that stores the description of the new character to be added to the database.
    @Published var description: String = ""

    /// The `NSManagedObjectContext` used for interacting with the Core Data database.
    var viewContext: NSManagedObjectContext

    /// The `Manga` that the characters belong to.
    let manga: Manga

    /// Initializes a new `CharacterViewModel` object.
    ///
    /// - Parameters:
    ///   - viewContext: The `NSManagedObjectContext` to use for interacting with the database.
    ///   - manga: The `Manga` that the characters belong to.
    init(viewContext: NSManagedObjectContext, manga: Manga) {
        self.viewContext = viewContext
        self.manga = manga
        fetchCharacters()
    }

    /// Fetches characters from the database and sorts them by name in ascending order.
    private func fetchCharacters() {
        let fetchRequest: NSFetchRequest<Character> = Character.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Character.name, ascending: true)]
        do {
            characters = try viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch characters: \(error)")
        }
    }

    /// Creates a new `Character` object with the name and description stored in `name` and `description`, adds it to the database,
    /// then refreshes the list of characters.
    func addCharacter() {
        // Check if the input contains at least one letter
        if !name.isEmpty, name.rangeOfCharacter(from: .letters) != nil {
            let newCharacter = Character(context: viewContext)
            newCharacter.name = name
            newCharacter.descriptions = description
            newCharacter.manga = manga
            saveContext()
            fetchCharacters()
        }
    }

    /// Deletes characters at the specified indices from the database,
    /// then refreshes the list of characters.
    ///
    /// - Parameter offsets: The indices of the characters to delete.
    func deleteCharacters(at offsets: IndexSet) {
        offsets.forEach { index in
            let character = characters[index]
            viewContext.delete(character)
        }
        saveContext()
        fetchCharacters()
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
