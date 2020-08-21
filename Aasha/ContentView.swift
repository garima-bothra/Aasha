//
//  ContentView.swift
//  Aasha
//
//  Created by Garima Bothra on 20/08/20.
//

import SwiftUI

struct ContentView: View {

    @FetchRequest(entity: Book.entity(), sortDescriptors:[]) var fetchBooks: FetchedResults<Book>
    var body: some View {
        HomeView(books: fetchBooks)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
