//
//  AddNewCharacterView.swift
//  DEMO_CoreDataMultipleEntities
//
//  Created by Jonathan Duong on 30/05/2023.
//

import SwiftUI

struct AddNewCharacterView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var charViewModel: CharacterViewModel
    var body: some View {
        Form {
            Section {
                TextField("Character name", text: $charViewModel.name)
            } header: {
                Text("Name")
            }
            Section {
                TextEditor(text: $charViewModel.description)
            } header: {
                Text("Description")
            }
            Button {
                if !charViewModel.name.isEmpty, charViewModel.name.rangeOfCharacter(from: .letters) != nil {
                    self.charViewModel.addCharacter()
                }
                self.charViewModel.name = ""
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add")
            }

        }
    }
}
