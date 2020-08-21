//
//  DocumentRowView.swift
//  Aasha
//
//  Created by Garima Bothra on 20/08/20.
//

import SwiftUI

struct DocumentRowView: View {
    var body: some View {
        HStack {
            Image(systemName: "book.fill")
                .foregroundColor(.green)
                .frame(width: 40)
            VStack(alignment: .leading) {
                Text("My book")
                    .font(.caption)
                    .fontWeight(.black)
                Text("Book subheading")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct DocumentRowView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentRowView()
    }
}
