//
//  CharDescriptionView.swift
//  DEMO_CoreDataMultipleEntities
//
//  Created by Jonathan Duong on 30/05/2023.
//

import SwiftUI

struct CharDescriptionView: View {
    let character: Character

    var body: some View {
        VStack {
            if let name = character.name {
                Text(name)
            }
            if let description = character.descriptions {
                Text(description)
            }
        }
    }
}
