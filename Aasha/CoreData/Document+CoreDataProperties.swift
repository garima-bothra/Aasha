//
//  Document+CoreDataProperties.swift
//  Aasha
//
//  Created by Garima Bothra on 21/08/20.
//
//

import Foundation
import CoreData


extension Document {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document> {
        return NSFetchRequest<Document>(entityName: "Document")
    }

    @NSManaged public var lang: String?
    @NSManaged public var bookURL: URL?
    @NSManaged public var book: Book?

    public var wrappedLang: String {
        lang ?? "Unknown Language"
    }
}

extension Document : Identifiable {

}
