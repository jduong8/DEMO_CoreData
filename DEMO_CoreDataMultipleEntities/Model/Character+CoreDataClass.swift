//
//  Character+CoreDataClass.swift
//  DEMO_CoreDataMultipleEntities
//
//  Created by Jonathan Duong on 30/05/2023.
//
//

import Foundation
import CoreData

@objc(Character)
public class Character: NSManagedObject {
    public var wrappedName: String {
        name ?? "Unknown character"
    }
}
