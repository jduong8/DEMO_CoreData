//
//  MangaView.swift
//  DEMO_CoreDataMultipleEntities
//
//  Created by Jonathan Duong on 30/05/2023.
//

import SwiftUI
import CoreData

struct MangaView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: MangaViewModel
    @State private var isShowingAlert: Bool = false

    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: MangaViewModel(viewContext: context))
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.mangas) { manga in
                    if let name = manga.name {
                        NavigationLink {
                            CharacterView(viewContext: viewContext,
                                          manga: manga)
                        } label: {
                            Text(name)
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteMangas)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    alertButton()
                }
            }
        }
    }
}

extension MangaView {
    @ViewBuilder
    func alertButton() -> some View {
        Button {
            self.isShowingAlert.toggle()
        } label: {
            Image(systemName: "plus")
        }
        .alert("Add new manga", isPresented: $isShowingAlert) {
            TextField("", text: $viewModel.newManga)
            Button("Add") {
                viewModel.addManga()
                self.viewModel.newManga = ""
            }
            Button("Cancel", role: .cancel) {
                self.viewModel.newManga = ""
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MangaView(context: PersistenceController.preview.container.viewContext).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
