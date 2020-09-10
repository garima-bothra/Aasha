//
//  TranslateView.swift
//  Aasha
//
//  Created by Garima Bothra on 06/09/20.
//

import SwiftUI
import PDFKit
import SwiftGoogleTranslate

struct TranslateView: View {

    @ObservedObject var languages: Languages
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var lang = String()
    @FetchRequest(entity: Book.entity(), sortDescriptors:[]) var books: FetchedResults<Book>
    @State var selectedBook: Book = Book()
    @State var displayPDF: Bool = false
    @State var PDFData: Data = Data()
    @State var PDFURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    @State var text: String = String()
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        self.languages = Languages()
    }

    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }

    var body: some View {
        return  GeometryReader { g in
            NavigationView {

                VStack {
                    Image("translation")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: g.size.width * 0.8, height: g.size.height * 0.4, alignment: .center)

                    Picker(selection: $selectedBook, label: Text("Select book" )
                            .bold()) {
                        ForEach(books, id: \.self) { book in
                            Text(book.wrappedName)
                        }
                    }
                    .opacity(books.count == 0 ? 0.5: 1)
                    .pickerStyle(MenuPickerStyle())
                    .foregroundColor(Color.primary)
                    .frame(width: g.size.width * 0.7)
                    .padding(.all)
                    .background(Color(.sRGB, red: 255/255, green: 145/255, blue: 115/255, opacity: 1))
                    .cornerRadius(10)
                    Picker(selection: $lang, label: Text("\(lang == "" ? "Language" : lang)")
                            .bold()
                            .foregroundColor(Color.primary)) {
                        ForEach(languages.languages, id: \.id) { language in
                            HStack {
                                Text(language.wrappedName)
                                Spacer()
                                Text(language.wrappedCode)
                            }
                            .tag("\(language.wrappedCode)")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .foregroundColor(Color.primary)
                    .frame(width: g.size.width * 0.7)
                    .padding(.all)
                    .background(Color(.sRGB, red: 255/255, green: 145/255, blue: 115/255, opacity: 1))
                    .cornerRadius(10)
                    Button(action: {
                        if books.count == 0 {
                            print("No books")
                        }
                        if let url = selectedBook.docs?.bookURL {
                            let pdf = PDFDocument(url: url)
                            print(pdf?.string ?? "")
                            SwiftGoogleTranslate.shared.translate(pdf?.string ?? "", lang, selectedBook.docs?.wrappedLangCode ?? "en") { (text, error) in
                              if let t = text {
                                print("TRANSLATED:")
//                                self.PDFData = createPDFData(PDFtext: t)
//                                let newPDF = PDFDocument(data: self.PDFData)
//                                let url = self.getDocumentsDirectory().appendingPathComponent("\(selectedBook.name ?? "bookName")-\(lang).pdf")
//                                do {
//                                    try PDFData.write(to: url, atomically: true, encoding: String.Encoding.utf8)
//                                            let input = try String(contentsOf: url)
//                                    self.PDFURL = url
//                                            self.displayPDF = true
//                                            print(input)
//                                        } catch {
//                                            print(error.localizedDescription)
//                                        }
                                let str = t
                                self.text = t
                                displayPDF = true
                                        let url = self.getDocumentsDirectory().appendingPathComponent("\(selectedBook.name ?? "bookName")-\(lang).txt")

//                                        do {
//                                            try str.write(to: url, atomically: true, encoding: .utf8)
//                                            let input = try String(contentsOf: url)
//                                            print(input)
//                                            PDFURL = url
//                                            self.text = str
//                                            displayPDF = true
//                                        } catch {
//                                            print(error.localizedDescription)
//                                        }
                            //    let newPDF = PDFDocument(data: data)

                              }
                            }
                        }
                    }, label: {
                        Text("Translate")
                            .bold()
                            .foregroundColor(Color.primary)
                            .frame(width: g.size.width * 0.7, height: g.size.height * 0.05)
                            .padding(.all)
                            .background(Color(.sRGB, red: 255/255, green: 145/255, blue: 115/255, opacity: 1))
                            .cornerRadius(10)
                            .disabled(lang == "")
                    })
                }
                .moveDisabled(true)
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
                Text(text)
                .navigationTitle("Translate")
            }
            .sheet(isPresented: $displayPDF) {
                ScrollView {
                    Text(text)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .padding()
                }
                    }
        }
    }

    func createPDFData(PDFtext: String) -> Data {
      // 1
      let pdfMetaData = [
        kCGPDFContextCreator: "Book Translator",
        kCGPDFContextAuthor: "Aasha"
      ]
      let format = UIGraphicsPDFRendererFormat()
      format.documentInfo = pdfMetaData as [String: Any]

      // 2
      let pageWidth = 8.5 * 72.0
      let pageHeight = 11 * 72.0
      let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

      // 3
      let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
      // 4
      let data = renderer.pdfData { (context) in
        // 5
        context.beginPage()
        // 6
        let attributes = [
          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
        ]
        let text = PDFtext
        text.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
      }

      return data
    }
}

struct TranslateView_Previews: PreviewProvider {
    static var previews: some View {
        TranslateView()
    }
}
