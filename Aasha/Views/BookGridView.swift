//
//  BookGridView.swift
//  Aasha
//
//  Created by Garima Bothra on 06/09/20.
//

import SwiftUI

struct BookGridView: View {

    var book: Book!

    var body: some View {
        NavigationLink(destination: DetailView(book: book)){
            VStack {
                Text("\(book.wrappedName)")
                    .font(.title2)
                    .foregroundColor(Color.black)
                    .bold()
                Text("\(book.document.wrappedLang)")
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .bold()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(3.0)
            .background(Color(.sRGB, red: 255/255, green: 145/255, blue: 115/255, opacity: 1))
        }
    }
}

struct BookGridView_Previews: PreviewProvider {
    static var previews: some View {
        BookGridView()
    }
}
