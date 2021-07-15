//
//  EditCard.swift
//  Flashzilla
//
//  Created by Stefan Tadic on 4/30/21.
//

import SwiftUI

struct EditCard: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var cards = [Card]()
    @State private var newPromt = ""
    @State private var newAnswer = ""

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add new card")) {
                    TextField("Promt", text: $newPromt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }

                Section {
                    ForEach(0..<cards.count, id: \.self) {
                        index in
                        VStack(alignment: .leading) {
                            Text(self.cards[index].promt)
                                .font(.headline)
                            Text(self.cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                    }
                }
            .navigationBarTitle("Edit Cards")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
            .listStyle(GroupedListStyle())
            .onAppear(perform: loadData)
            }

        .navigationViewStyle(StackNavigationViewStyle())
        }

    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try?
                JSONDecoder().decode([Card].self, from: data)
            {
                self.cards = decoded
            }
        }
    }

    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }

    func addCard() {
        let trimmedPromt = newPromt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPromt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }

        let card = Card(promt: trimmedPromt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
    }

    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
}

struct EditCard_Previews: PreviewProvider {
    static var previews: some View {
        EditCard()
    }
}
