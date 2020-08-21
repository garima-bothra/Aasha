//
//  DocumentViewPicker.swift
//  Aasha
//
//  Created by Garima Bothra on 20/08/20.
//

import SwiftUI
struct DocumentPicker: UIViewControllerRepresentable {

    func makeCoordinator() -> DocumentPicker.Coordinator {
        return DocumentPicker.Coordinator(parent1: self)
    }

    @Binding var url: URL!

    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        
    }


    class Coordinator: NSObject, UIDocumentPickerDelegate{
        var parent: DocumentPicker

        init(parent1: DocumentPicker){
            parent = parent1
        }
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            self.parent.url = urls[0]
            // PDFKitView(url: urls[0])
        }
    }
}

struct DocumentViewPicker_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
