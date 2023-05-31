//
//  CharacterView.swift
//  DEMO_CoreDataMultipleEntities
//
//  Created by Jonathan Duong on 30/05/2023.
//

import SwiftUI
import CoreData

struct CharacterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var charViewModel: CharacterViewModel
    @State private var isShowing: Bool = false

    init(viewContext: NSManagedObjectContext, manga: Manga) {
        _charViewModel = StateObject(wrappedValue: CharacterViewModel(viewContext: viewContext,
                                                                      manga: manga))
    }

    var body: some View {
        VStack {
            // MARK: - Characters list
            if charViewModel.manga.characters.isEmpty {
                Text("Empty list")
                    .font(.title)
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(charViewModel.manga.characters) { character in
                        NavigationLink {
                            CharDescriptionView(character: character)
                        } label: {
                            if let name = character.name {
                                Text(name)
                            }
                        }
                    }
                    .onDelete(perform: charViewModel.deleteCharacters)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button {
                    self.isShowing.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isShowing) {
                    AddNewCharacterView(charViewModel: charViewModel)
                }
            }
        }
        .navigationTitle("Character")
    }
}
