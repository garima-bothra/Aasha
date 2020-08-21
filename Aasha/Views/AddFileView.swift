//
//  AddFileView.swift
//  Aasha
//
//  Created by Garima Bothra on 21/08/20.
//

import SwiftUI

struct AddFileView: View {

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext

    @State var bookname = String()
    @State var showPicker = false
    @State var url: URL!
    @State var description = String()
    var body: some View {
        NavigationView {
        Form {
            TextField("Name", text: $bookname)
            TextField("Short Description", text: $description)
            Button(action: {
                self.showPicker = true
            })
            {
                if(self.url != nil){
                    Text("Upload Again")
                }
                else {
                    Text("Upload Book")
                }
            }
            .sheet(isPresented: $showPicker) {
                DocumentPicker(url: $url)
            }

            Section {
                Button(action: {
                    let book = Book(context: managedObjectContext)
                    book.name = bookname
                    book.bookURL = url
                    book.descrip = description
                    book.id = UUID()
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        // handle the Core Data error
                    }
                    self.presentationMode.wrappedValue.dismiss()
                })
                {
                    Text("Save")
                        .frame(alignment: .center)
                }.disabled(bookname == "" || url == nil || description == "")
            }
        }
        .navigationTitle("Add Book")
        }
    }
}

struct AddFileView_Previews: PreviewProvider {
    static var previews: some View {
        Text("hello")
    }
}
