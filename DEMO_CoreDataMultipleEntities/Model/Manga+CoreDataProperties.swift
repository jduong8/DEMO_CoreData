//
//  Manga+CoreDataProperties.swift
//  DEMO_CoreDataMultipleEntities
//
//  Created by Jonathan Duong on 30/05/2023.
//
//

import Foundation
import CoreData


extension Manga {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Manga> {
        return NSFetchRequest<Manga>(entityName: "Manga")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var name: String?
    @NSManaged public var character: NSSet?

}

// MARK: Generated accessors for character
extension Manga {

    @objc(addCharacterObject:)
    @NSManaged public func addToCharacter(_ value: Character)

    @objc(removeCharacterObject:)
    @NSManaged public func removeFromCharacter(_ value: Character)

    @objc(addCharacter:)
    @NSManaged public func addToCharacter(_ values: NSSet)

    @objc(removeCharacter:)
    @NSManaged public func removeFromCharacter(_ values: NSSet)

}

extension Manga : Identifiable {

}
