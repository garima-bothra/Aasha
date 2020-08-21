//
//  AddFileView.swift
//  Aasha
//
//  Created by Garima Bothra on 21/08/20.
//

import SwiftUI

struct AddFileView: View {
    @State var bookname = String()
    @State var showPicker = false
    @State var url: URL!
    var body: some View {
        NavigationView {
        Form {
            TextField("Name", text: $bookname)
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

                })
                {
                    Text("Save")
                        .frame(alignment: .center)
                }
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
