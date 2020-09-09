//
//  AddFileView.swift
//  Aasha
//
//  Created by Garima Bothra on 21/08/20.
//

import SwiftUI

struct AddFileView: View {

    @ObservedObject var languages: Languages
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext

    @State var bookname = String()
    @State var showPicker = false
    @State var url: URL!
    @State var description = String()
    @State var lang = String()
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $bookname)
                TextField("Short Description", text: $description)
                Section {
                    Picker(selection: $lang, label: Text("Language")) {
                        ForEach(languages.languages, id: \.id) { language in
                            HStack {
                                Text(language.wrappedName)
                                Spacer()
                                Text(language.wrappedCode)
                            }
                            .tag("\(language.wrappedCode)")
                                }
                    }
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
                }
                Section {
                    Button(action: {
                        let book = Book(context: managedObjectContext)
                        book.name = bookname
                        let doc = Document(context: managedObjectContext)
                        doc.lang = lang
                        doc.bookURL = url
                        book.descrip = description
                        book.id = UUID()
                        doc.book = book
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
