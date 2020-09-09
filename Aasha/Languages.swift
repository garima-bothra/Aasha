//
//  Languages.swift
//  Aasha
//
//  Created by Garima Bothra on 09/09/20.
//

import Foundation
import SwiftGoogleTranslate

class Language {
    var name: String?
    var code: String?

    var wrappedName: String {
        return self.name ?? ""
    }

    var wrappedCode: String {
        return self.code ?? ""
    }
}

class Languages {
    var languages: [Language] = []

    func getLanguages() {
        SwiftGoogleTranslate.shared.languages { (languages, error) in
            if let languages = languages {
                for language in languages {
                    let lang = Language()
                    lang.name = language.name
                    lang.code = language.language
                    self.languages.append(lang)
                }
            }
        }
    }
}
