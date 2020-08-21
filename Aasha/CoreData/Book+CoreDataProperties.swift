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
    @NSManaged public var docs: NSSet?

    public var wrappedName: String {
        name ?? "Unknown Book"
    }

    public var wrappedDesc: String {
        descrip ?? "Book Description"
    }

    public var documentArray: [Document] {
        let set = docs as? Set<Document> ?? []
        return set.sorted {
            $0.wrappedLang < $1.wrappedLang
        }
    }

}

// MARK: Generated accessors for docs
extension Book {

    @objc(addDocsObject:)
    @NSManaged public func addToDocs(_ value: Document)

    @objc(removeDocsObject:)
    @NSManaged public func removeFromDocs(_ value: Document)

    @objc(addDocs:)
    @NSManaged public func addToDocs(_ values: NSSet)

    @objc(removeDocs:)
    @NSManaged public func removeFromDocs(_ values: NSSet)

}

extension Book : Identifiable {

}
