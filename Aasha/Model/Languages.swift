//
//  Languages.swift
//  Aasha
//
//  Created by Garima Bothra on 09/09/20.
//

import Foundation
import SwiftGoogleTranslate

struct Language: Identifiable, Codable, Hashable {
    var id: Int?
    var name: String?
    var code: String?

    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }

    var wrappedName: String {
        return self.name ?? ""
    }

    var wrappedCode: String {
        return self.code ?? ""
    }
}

class Languages: ObservableObject {
    @Published var languages: [Language] = []

    init() {
        getLanguages()
    }
    
    func getLanguages() {
        SwiftGoogleTranslate.shared.languages { (languages, error) in
            if let languages = languages {
                var counter = 0
                for language in languages {
                    var lang = Language()
                    lang.id = counter
                    lang.name = language.name
                    lang.code = language.language
                    counter += 1
                    DispatchQueue.main.async {
                      self.languages.append(lang)
                      }

                }
            }
        }
    }
}
