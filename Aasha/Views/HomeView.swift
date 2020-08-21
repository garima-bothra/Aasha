//
//  HomeView.swift
//  Aasha
//
//  Created by Garima Bothra on 20/08/20.
//

import SwiftUI
import CoreData
struct HomeView: View {

    @State var showPicker = false
    var books: FetchedResults<Book>
    var body: some View {
        NavigationView {
            List {
                ForEach(1...10, id: \.self) { value in
                    DocumentRowView()
                }
                .onDelete(perform: delete)
            }
        .navigationTitle("Your Documents")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                 self.showPicker = true
            }){
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showPicker) {
            AddFileView()
        }
    }

    func delete(at offsets: IndexSet) {
        }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello")
    }
}
