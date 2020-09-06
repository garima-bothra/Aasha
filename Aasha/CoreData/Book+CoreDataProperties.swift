//
//  Book+CoreDataProperties.swift
//  Aasha
//
//  Created by Garima Bothra on 21/08/20.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var descrip: String?
    @NSManaged public var docs: Document?

    public var wrappedName: String {
        name ?? "Unknown Book"
    }

    public var wrappedDesc: String {
        descrip ?? "Book Description"
    }

    public var document: Document {
        docs ?? Document()
    }

}

extension Book : Identifiable {

}
