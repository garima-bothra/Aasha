//
//  DetailView.swift
//  Aasha
//
//  Created by Garima Bothra on 21/08/20.
//

import SwiftUI

struct DetailView: View {
    var book: Book
    var body: some View {
        Form {
            Text(book.descrip ?? "Description")
            Section {
                NavigationLink(
                    destination: PDFKitView(url: book.bookURL!),
                    label: {
                        Text("Document")
                    })
    }
        }
        .navigationTitle(book.name ?? "Book Name")
}
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
       Text("Hello")
    }
}
