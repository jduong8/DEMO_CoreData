//
//  Manga+CoreDataClass.swift
//  DEMO_CoreDataMultipleEntities
//
//  Created by Jonathan Duong on 30/05/2023.
//
//

import Foundation
import CoreData

@objc(Manga)
public class Manga: NSManagedObject {
    public var wrappedName: String {
        name ?? "Unknown manga"
    }
    // Need to call this property to fetch all datas of character depending of Manga
    public var characters: [Character] {
        let set = character as? Set<Character> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}
